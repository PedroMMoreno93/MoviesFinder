# -------------------------------------------
# File: scripts/build_archive.sh
# Description: Archives macOS project
# -------------------------------------------
#!/usr/bin/env bash
set -euo pipefail

# Load shared ANSI color palette
source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"

# Usage: build_archive.sh <project-path> <scheme> <archive-output-dir>
if [ $# -lt 3 ]; then
  echo -e "${COLOR_ERROR}Usage: $0 <project-path> <scheme> <archive-output-dir>${COLOR_RESET}"
  exit 1
fi

PROJECT_PATH="$1"
SCHEME="$2"
ARCHIVE_DIR="$3"
ARCHIVE_PATH="$ARCHIVE_DIR/$SCHEME.xcarchive"

echo -e "${COLOR_STEP}[1/1] Archiving macOS scheme '$SCHEME' (Release, macOS SDK)...${COLOR_RESET}"
mkdir -p "$ARCHIVE_DIR"
if [[ "$PROJECT_PATH" == *.xcworkspace ]]; then
  xcodebuild -workspace "$PROJECT_PATH" \
    -scheme "$SCHEME" \
    -configuration Release \
    -sdk macosx \
    -archivePath "$ARCHIVE_PATH" \
    archive \
    CODE_SIGN_STYLE=Manual \
    CODE_SIGN_IDENTITY="Developer ID Application: Pedro Moreno (DCVXS4R2VN)" \
    PROVISIONING_PROFILE=""
else
  xcodebuild -project "$PROJECT_PATH" \
    -scheme "$SCHEME" \
    -configuration Release \
    -sdk macosx \
    -archivePath "$ARCHIVE_PATH" \
    archive \
    CODE_SIGN_STYLE=Manual \
    CODE_SIGN_IDENTITY="Developer ID Application: Pedro Moreno (DCVXS4R2VN)" \
    PROVISIONING_PROFILE=""
fi

echo -e "${COLOR_SUCCESS}Archive created at $ARCHIVE_PATH${COLOR_RESET}"
