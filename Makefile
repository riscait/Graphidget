# Variables

PRODUCT_NAME := Graphidget
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace
SCHEME_NAME := ${PRODUCT_NAME}
UI_TESTS_TARGET_NAME := ${PRODUCT_NAME}UITests

# Targets

.PHONY: setup
setup: # Install dependencies and prepared development configuration
	make install-mint

.PHONY: install-mint
install-mint: # Install Mint dependencies
	mint bootstrap

.PHONY: generate
generate:
	mint run xcodegen xcodegen generate
	make open

.PHONY: open
open:
	open ./${PRODUCT_NAME}.xcodeproj
