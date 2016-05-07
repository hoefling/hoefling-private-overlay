# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Meta ebuild for Steam runtime dependencies"
HOMEPAGE=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE=""

RDEPEND="
	>=games-util/steam-launcher-1.0.0.49"


S="${WORKDIR}"
