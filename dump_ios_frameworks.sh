#!/bin/bash

# Path to the iOS SDK frameworks
FRAMEWORKS_DIR="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks"

# Output directory
OUTPUT_DIR="./class-dump-output"
mkdir -p "$OUTPUT_DIR"

# Check if class-dump is installed
if ! command -v class-dump &> /dev/null; then
    echo "Error: class-dump is not installed. Install it from https://stevenygard.com/projects/class-dump/"
    exit 1
fi

echo "Starting class-dump on iOS frameworks..."

# Loop through each framework in the directory
for FRAMEWORK in "$FRAMEWORKS_DIR"/*.framework; do
    FRAMEWORK_NAME=$(basename "$FRAMEWORK" .framework)
    FRAMEWORK_BINARY="$FRAMEWORK/$FRAMEWORK_NAME"

    if [[ -f "$FRAMEWORK_BINARY" ]]; then
        echo "Dumping: $FRAMEWORK_NAME"
        class-dump -H -o "$OUTPUT_DIR/$FRAMEWORK_NAME" "$FRAMEWORK_BINARY"
    else
        echo "Skipping: $FRAMEWORK_NAME (No valid binary found)"
    fi
done
