#!/bin/bash
# Copyright 2014 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DISTRO=debian
DIST=jessie
DIST_UPDATES=jessie-updates

PACKAGES_EXT=xz

APT_REPO=http://ftp.jp.debian.org/debian
# gpg keyring file generated using:
#   export KEYS="518E17E1 46925553 2B90D010"
#   gpg --recv-keys $KEYS
#   gpg --output ./debian-archive-jessie-stable.gpg --export $KEYS
KEYRING_FILE="${SCRIPT_DIR}/debian-archive-jessie-stable.gpg"

HAS_ARCH_AMD64=1
HAS_ARCH_I386=1
HAS_ARCH_ARM=1
HAS_ARCH_ARM64=1
HAS_ARCH_MIPS=1

# Sysroot packages: these are the packages needed to build chrome.
# NOTE: When DEBIAN_PACKAGES is modified, the packagelist files must be updated
# by running this script in GeneratePackageList mode.
DEBIAN_PACKAGES="\
  comerr-dev
  krb5-multidev
  libasound2
  libasound2-dev
  libatk-bridge2.0-0
  libatk-bridge2.0-dev
  libatk1.0-0
  libatk1.0-dev
  libatspi2.0-0
  libatspi2.0-dev
  libattr1
  libavahi-client3
  libavahi-common3
  libbluetooth3
  libbluetooth-dev
  libbrlapi0.6
  libbrlapi-dev
  libc6
  libc6-dev
  libcairo2
  libcairo2-dev
  libcairo-gobject2
  libcairo-script-interpreter2
  libcap-dev
  libcap2
  libcomerr2
  libcups2
  libcups2-dev
  libcurl3
  libcurl4-openssl-dev
  libdatrie1
  libdbus-1-3
  libdbus-1-dev
  libdbus-glib-1-2
  libdrm2
  libdrm-dev
  libdrm-nouveau2
  libdrm-radeon1
  libegl1-mesa
  libegl1-mesa-dev
  libelf1
  libelf-dev
  libexpat1
  libexpat1-dev
  libffi6
  libffi-dev
  libfontconfig1
  libfontconfig1-dev
  libfreetype6
  libfreetype6-dev
  libgbm1
  libgbm-dev
  libgcc-4.8-dev
  libgcc1
  libgconf-2-4
  libgconf2-4
  libgconf2-dev
  libgcrypt20
  libgcrypt20-dev
  libgdk-pixbuf2.0-0
  libgdk-pixbuf2.0-dev
  libgl1-mesa-dev
  libgl1-mesa-glx
  libglapi-mesa
  libglib2.0-0
  libglib2.0-dev
  libgmp10
  libgnome-keyring0
  libgnome-keyring-dev
  libgnutls-openssl27
  libgnutls-deb0-28
  libgnutlsxx28
  libgnutls28-dev
  libgomp1
  libgpg-error0
  libgpg-error-dev
  libgraphite2-3
  libgssapi-krb5-2
  libgssrpc4
  libgtk-3-0
  libgtk-3-dev
  libgtk2.0-0
  libgtk2.0-dev
  libharfbuzz0b
  libharfbuzz-dev
  libharfbuzz-gobject0
  libharfbuzz-icu0
  libhogweed2
  libatomic1
  libjavascriptcoregtk-4.0-18
  libjavascriptcoregtk-4.0-dev
  libjavascriptcoregtk-3.0-0
  libjavascriptcoregtk-3.0-dev
  libjsoncpp0
  libjsoncpp-dev
  libk5crypto3
  libkadm5clnt-mit9
  libkadm5srv-mit9
  libkdb5-7
  libkeyutils1
  libkrb5-3
  libkrb5-dev
  libkrb5support0
  libnettle4
  libnotify4
  libnotify-dev
  libnspr4
  libnspr4-dev
  libnss3
  libnss3-dev
  libnss-db
  liborbit2
  libp11-2
  libp11-kit0
  libpam0g
  libpam0g-dev
  libpango-1.0-0
  libpango1.0-dev
  libpangoft2-1.0-0
  libpangocairo-1.0-0
  libpangox-1.0-0
  libpangoxft-1.0-0
  libpci3
  libpci-dev
  libpcre3
  libpcre3-dev
  libpcrecpp0
  libpixman-1-0
  libpixman-1-dev
  libpng12-0
  libpng12-dev
  libpthread-stubs0-dev
  libpulse0
  libpulse-dev
  libpulse-mainloop-glib0
  libselinux1
  libsoup2.4-1
  libsoup2.4-dev
  libspeechd2
  libspeechd-dev
  libssl1.0.0
  libssl-dev
  libstdc++6
  libstdc++-4.8-dev
  libtasn1-6
  libthai0
  libudev-dev
  libudev1
  libwayland-client0
  libwayland-cursor0
  libwayland-dev
  libwayland-egl1-mesa
  libwayland-server0
  libwebkit2gtk-4.0-37
  libwebkit2gtk-4.0-dev
  libwebkitgtk-3.0-0
  libwebkitgtk-3.0-dev
  libwebkitgtk-common-dev
  libx11-6
  libx11-dev
  libx11-xcb1
  libx11-xcb-dev
  libxau6
  libaudit1
  libxau-dev
  libxcb1
  libxcb1-dev
  libxcb-dri2-0
  libxcb-dri3-0
  libxcb-glx0
  libxcb-present0
  libxcb-render0
  libxcb-render0-dev
  libxcb-sync1
  libxcb-shm0
  libxcb-shm0-dev
  libxcomposite1
  libxcomposite-dev
  libxcursor1
  libxcursor-dev
  libxdamage1
  libxdamage-dev
  libxdmcp6
  libxdmcp-dev
  libxext6
  libxext-dev
  libxfixes3
  libxfixes-dev
  libxi6
  libxi-dev
  libxinerama1
  libxinerama-dev
  libxkbcommon0
  libxkbcommon-dev
  libxrandr2
  libxrandr-dev
  libxrender1
  libxrender-dev
  libxshmfence1
  libxss1
  libxss-dev
  libxt6
  libxt-dev
  libxtst6
  libxtst-dev
  libxxf86vm1
  linux-libc-dev
  mesa-common-dev
  speech-dispatcher
  x11proto-composite-dev
  x11proto-core-dev
  x11proto-damage-dev
  x11proto-fixes-dev
  x11proto-input-dev
  x11proto-kb-dev
  x11proto-randr-dev
  x11proto-record-dev
  x11proto-render-dev
  x11proto-scrnsaver-dev
  x11proto-xext-dev
  x11proto-xinerama-dev
  zlib1g
  zlib1g-dev
"

DEBIAN_PACKAGES_AMD64="
  liblsan0
  libtsan0
"

DEBIAN_PACKAGES_X86="
  libasan0
  libcilkrts5
  libdrm-intel1
  libitm1
  libquadmath0
  libubsan0
"

DEBIAN_PACKAGES_ARM="
  libasan0
  libdrm-exynos1
  libdrm-freedreno1
  libdrm-omap1
  libubsan0
"

DEBIAN_PACKAGES_ARM64="
  libitm1
"

. "${SCRIPT_DIR}/sysroot-creator.sh"
