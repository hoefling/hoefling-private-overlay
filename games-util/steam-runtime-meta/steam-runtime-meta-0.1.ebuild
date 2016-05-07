# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib-minimal

DESCRIPTION="Meta ebuild for Steam runtime dependencies"
HOMEPAGE=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE=""

RDEPEND="
	>=games-util/steam-launcher-1.0.0.49
	>=dev-libs/glib-2.46.2-r2[${MULTILIB_USEDEP}]
	>=media-sound/pulseaudio-8.0[${MULTILIB_USEDEP}]
	>=x11-libs/gdk-pixbuf-2.32.3[${MULTILIB_USEDEP}]
	>=x11-libs/gtk+-2.24.29[${MULTILIB_USEDEP}]
	>=x11-libs/libXrandr-1.5.0[${MULTILIB_USEDEP}]
	>=x11-libs/libXtst-1.2.2[${MULTILIB_USEDEP}]"

S="${WORKDIR}"
