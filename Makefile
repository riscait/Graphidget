# Variables

PRODUCT_NAME := Graphidget
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace
SCHEME_NAME := ${PRODUCT_NAME}
UI_TESTS_TARGET_NAME := ${PRODUCT_NAME}UITests

# Targets

.PHONY: setup
setup: # Install dependencies and prepared development configuration
	make install-mint
	make install-carthage

.PHONY: install-mint
install-mint: # Install Mint dependencies
	mint bootstrap

.PHONY: install-carthage
install-carthage: # Install Carthage dependencies
	mint run carthage carthage bootstrap --platform iOS --cache-builds

.PHONY: update-carthage
update-carthage: # Update Carthage dependencies
	mint run carthage carthage update --platform iOS

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
