################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="firmware-dragonboard"
PKG_VERSION="1.4.0"
PKG_ARCH="aarch64"
PKG_LICENSE="proprietary"
PKG_SITE="https://developer.qualcomm.com/"
PKG_URL="https://developer.qualcomm.com/download/db410c/firmware-410c-${PKG_VERSION}.bin"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="Additional firmware for Dragonboard 410c"
PKG_LONGDESC="Additional firmware for Dragonboard 410c"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  mkdir -p $PKG_BUILD
  cp $SOURCES/$PKG_NAME/$PKG_NAME-$PKG_VERSION.bin $PKG_BUILD
  cd $PKG_BUILD
  sh $PKG_NAME-${PKG_VERSION}.bin --auto-accept
}

make_target() {
  : # nothing todo here
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/firmware/
    cp -a linux-board-support-package-v${PKG_VERSION%.0}/proprietary-linux/* $INSTALL/usr/lib/firmware
    rm $INSTALL/usr/lib/firmware/firmware.tar

  MTOOLS_SKIP_CHECK=1 mcopy -n -i linux-board-support-package-v${PKG_VERSION%.0}/bootloaders-linux/NON-HLOS.bin \
    ::image/modem.* ::image/mba.mbn ::image/wcnss.* $INSTALL/usr/lib/firmware/
}
