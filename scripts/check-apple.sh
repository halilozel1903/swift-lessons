#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Apple samples require macOS and Xcode." >&2
  exit 1
fi
MAC_SDK="$(xcrun --sdk macosx --show-sdk-path)"
IOS_SDK="$(xcrun --sdk iphonesimulator --show-sdk-path)"
CPU="$(uname -m)"
for source in AppleExamples/*.swift; do
  if [[ "$source" == *uikit* ]]; then
    xcrun swiftc -swift-version 6 -warnings-as-errors -typecheck \
      -sdk "$IOS_SDK" -target "$CPU-apple-ios17.0-simulator" "$source"
  else
    xcrun swiftc -swift-version 6 -warnings-as-errors -typecheck \
      -sdk "$MAC_SDK" -target "$CPU-apple-macosx14.0" "$source"
  fi
  echo "PASS: $source"
done
