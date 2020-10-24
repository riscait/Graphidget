# Variables

PRODUCT_NAME := Graphidget
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace
SCHEME_NAME := ${PRODUCT_NAME}
UI_TESTS_TARGET_NAME := ${PRODUCT_NAME}UITests

TEST_SDK := iphonesimulator
TEST_CONFIGURATION := Debug
TEST_PLATFORM := iOS Simulator
TEST_DEVICE ?= iPhone 11 Pro Max
TEST_OS ?= 14.0
TEST_DESTINATION := 'platform=${TEST_PLATFORM},name=${TEST_DEVICE},OS=${TEST_OS}'

# Targets

.PHONY: setup
setup: # Install dependencies and prepared development configuration
	make mint-bootstrap
	make carthage-bootstrap
	make generate

.PHONY: mint-bootstrap
mint-bootstrap: # Install Mint dependencies
	mint bootstrap

.PHONY: carthage-bootstrap
carthage-bootstrap: # Install Carthage dependencies
	make export-carthage-config
	mint run carthage carthage bootstrap --platform iOS --cache-builds
	make show-carthage-dependencies

.PHONY: carthage-update
carthage-update: # Update Carthage dependencies
	make export-carthage-config
	mint run carthage carthage update --platform iOS
	make show-carthage-dependencies

.PHONY: show-carthage-dependencies
show-carthage-dependencies:
	@echo '*** Resolved dependencies:'
	@cat 'Cartfile.resolved'

.PHONY: export-carthage-config
export-carthage-config:
	export XCODE_XCCONFIG_FILE=Configs/Carthage.xcconfig

.PHONY: generate
generate:
	mint run xcodegen xcodegen generate
	make open

.PHONY: open
open:
	open ./${PRODUCT_NAME}.xcodeproj

.PHONY: clean
clean: # Delete cache
	xcodebuild clean -alltargets
	rm -rf ./Carthage

.PHONY: build-debug
build-debug: # Xcode build for debug
	set -o pipefail \
&& xcodebuild \
-sdk ${TEST_SDK} \
-configuration ${TEST_CONFIGURATION} \
-scheme ${SCHEME_NAME} \
build \
| xcpretty

.PHONY: test
test: # Xcode test # TEST_DEVICE=[device] TEST_OS=[OS]
	set -o pipefail \
&& xcodebuild \
-sdk ${TEST_SDK} \
-configuration ${TEST_CONFIGURATION} \
-scheme ${SCHEME_NAME} \
-destination ${TEST_DESTINATION} \
-skip-testing:${UI_TESTS_TARGET_NAME} \
clean test \
| xcpretty --report html

.PHONY: show-devices
show-devices: # Show devices
	xcrun xctrace list devices