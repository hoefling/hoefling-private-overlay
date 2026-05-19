# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg

DESCRIPTION="Raspberry Pi Imaging Utility"
HOMEPAGE="
https://www.raspberrypi.com/software/
https://github.com/raspberrypi/rpi-imager
"
SRC_URI="https://github.com/raspberrypi/rpi-imager/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}/src"

PATCHES=( "${FILESDIR}"/${P}-unbundle-dependencies.patch )

LICENSE="Apache-2.0"
SLOT="0"

KEYWORDS="~amd64"
IUSE="gnutls telemetry"

RDEPEND="
	app-arch/libarchive:=
	app-arch/xz-utils
	net-misc/curl
	sys-apps/util-linux
	sys-libs/zlib
	app-arch/lzma
	app-arch/zstd
	net-libs/nghttp2
	gnutls? ( net-libs/gnutls:= )
	!gnutls? ( dev-libs/openssl:= )
	dev-qt/qtbase:6[concurrent,dbus,gui,network,widgets]
	dev-qt/qtdeclarative:6[svg]
"
DEPEND="${RDEPEND}"
BDEPEND="
	net-misc/curl
	dev-qt/qttools:6[linguist]
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package gnutls GnuTLS)
		-DENABLE_TELEMETRY=$(usex telemetry)
		-DENABLE_CHECK_VERSION=NO
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "running as a non-root user" sys-fs/udisks
}
