# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Improved Nano Syntax Highlighting Files"
HOMEPAGE="https://github.com/scopatz/nanorc"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/scopatz/nanorc.git"
	EGIT_BRANCH="master"
else
	SRC_URI="https://github.com/scopatz/nanorc/releases/download/${PV}/${P}.tar.gz"
fi

PATCHES=( "${FILESDIR}"/391.patch )
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* amd64"
RDEPEND="app-editors/nano"
DEPEND="${RDEPEND}"

if [[ ${PV} == 9999* ]]; then
	KEYWORDS=""
	S="${WORKDIR}/${P}"
fi

src_unpack() {
	default
	[[ ${PV} = 9999* ]] && git-r3_src_unpack
}

src_install() {
	default
	insinto "/usr/share/nanorc"
	doins "${S}"/*.nanorc
}
