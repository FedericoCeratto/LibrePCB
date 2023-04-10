#!/usr/bin/env bash

# set shell settings (see https://sipb.mit.edu/doc/safe-shell/)
set -euv -o pipefail

# replace "bin" and "share" directories with the single *.app directory
mv "./build/install/opt/bin/librepcb.app" "./build/install/opt/LibrePCB.app"
cp -r "./build/install/opt/share" "./build/install/opt/LibrePCB.app/Contents/"
mv "./build/install/opt/bin/librepcb-cli.app" "./build/install/opt/LibrePCB-CLI.app"
cp -r "./build/install/opt/share" "./build/install/opt/LibrePCB-CLI.app/Contents/"
rm -r "./build/install/opt/bin" "./build/install/opt/share"

# Build bundles
pushd "./build/install/opt/"  # Avoid having path in DMG name
macdeployqt "LibrePCB.app" -dmg
macdeployqt "LibrePCB-CLI.app" -dmg
popd

# Restore lowercase app names for backwards compatibility with installers
mv "./build/install/opt/LibrePCB.app" "./build/install/opt/librepcb.app"
mv "./build/install/opt/LibrePCB-CLI.app" "./build/install/opt/librepcb-cli.app"

# Move bundles to artifacts directory
mv ./build/install/opt/LibrePCB.dmg ./artifacts/nightly_builds/librepcb-nightly-mac-x86_64.dmg
mv ./build/install/opt/LibrePCB-CLI.dmg ./artifacts/nightly_builds/librepcb-cli-nightly-mac-x86_64.dmg
