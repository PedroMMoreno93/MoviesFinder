# -------------------------------------------
# File: scripts/master.sh
# Description: Master script to archive, package, sign, and clean up in one command
# -------------------------------------------
#!/usr/bin/env bash
set -euo pipefail

# Load shared ANSI color palette
source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$ROOT_DIR/build"
ARCHIVE_DIR="$BUILD_DIR/archive"
PKG_DIR="$BUILD_DIR/pkg"

echo -e "${COLOR_STEP}[0/6] Detecting Xcode project in root...${COLOR_RESET}"
if compgen -G "$ROOT_DIR"/*.xcworkspace > /dev/null; then
  PROJECT_FILE="$(basename $(compgen -G "$ROOT_DIR"/*.xcworkspace | head -n1))"
elif compgen -G "$ROOT_DIR"/*.xcodeproj > /dev/null; then
  PROJECT_FILE="$(basename $(compgen -G "$ROOT_DIR"/*.xcodeproj | head -n1))"
else
  echo -e "${COLOR_ERROR}Error: No .xcworkspace or .xcodeproj found.${COLOR_RESET}"
  exit 1
fi
PROJECT_PATH="$ROOT_DIR/$PROJECT_FILE"
SCHEME="${PROJECT_FILE%.*}"
echo -e "${COLOR_INFO}    → Project: $PROJECT_FILE, scheme: $SCHEME${COLOR_RESET}"

echo -e "${COLOR_STEP}[1/6] Archiving macOS app...${COLOR_RESET}"
mkdir -p "$ARCHIVE_DIR"
bash "$SCRIPT_DIR/build_archive.sh" "$PROJECT_PATH" "$SCHEME" "$ARCHIVE_DIR"
ARCHIVE_PATH="$ARCHIVE_DIR/$SCHEME.xcarchive"

echo -e "${COLOR_STEP}[2/6] Extracting .app for packaging...${COLOR_RESET}"
mkdir -p "$PKG_DIR"
bash "$SCRIPT_DIR/extract_app.sh" "$ARCHIVE_PATH" "$PKG_DIR"
APP_PATH="$PKG_DIR/$SCHEME.app"

echo -e "${COLOR_STEP}[3/6] Reading bundle ID & version...${COLOR_RESET}"
BUNDLE_ID=$(/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" "$APP_PATH/Contents/Info.plist")
VERSION=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$APP_PATH/Contents/Info.plist")
echo -e "${COLOR_INFO}    → Bundle ID: $BUNDLE_ID, Version: $VERSION${COLOR_RESET}"

echo -e "${COLOR_STEP}[4/6] Detecting Developer ID Installer...${COLOR_RESET}"
IDENTS=$(security find-identity -v -p codesigning)
SIGN_ID_INSTALLER=$(echo "$IDENTS" | grep "Developer ID Installer" | head -n1 | sed -E 's/.*\"([^\"]+)\".*/\1/' || true)
if [ -z "$SIGN_ID_INSTALLER" ]; then
  echo -e "${COLOR_WARN}[4/6] Warning: No Developer ID Installer found under codesigning policy. Trying macappstore...${COLOR_RESET}"
  IDENTS=$(security find-identity -v -p macappstore)
  SIGN_ID_INSTALLER=$(echo "$IDENTS" | grep "Developer ID Installer" | head -n1 | sed -E 's/.*\"([^\"]+)\".*/\1/' || true)
fi
if [ -z "$SIGN_ID_INSTALLER" ]; then
  echo -e "${COLOR_ERROR}Error: No Developer ID Installer certificate found in keychain.${COLOR_RESET}"
  exit 1
fi
echo -e "${COLOR_INFO}    → Using: $SIGN_ID_INSTALLER${COLOR_RESET}"

echo -e "${COLOR_STEP}[5/6] Building and signing .pkg...${COLOR_RESET}"
bash "$SCRIPT_DIR/build_pkg.sh" "$APP_PATH" "$BUNDLE_ID" "$VERSION" "$SIGN_ID_INSTALLER" "$PKG_DIR"
SIGNED_PKG="$PKG_DIR/${SCHEME}-signed.pkg"

echo -e "${COLOR_STEP}[6/6] Cleaning up extracted .app...${COLOR_RESET}"
bash "$SCRIPT_DIR/clean_up.sh" "$APP_PATH"

echo -e "\n${COLOR_SUCCESS}Done!${COLOR_RESET}"
echo -e "${COLOR_INFO}Archive: $ARCHIVE_PATH${COLOR_RESET}"
echo -e "${COLOR_INFO}Signed PKG: $SIGNED_PKG${COLOR_RESET}"

echo -e "${COLOR_PROMPT}Do you want to open the signed installer now? [y/N] ${COLOR_RESET}\c"
read answer
if [[ "$answer" =~ ^[Yy] ]]; then
  open "$SIGNED_PKG"
fi
