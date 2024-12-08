# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/scopatz/nanorc.git"
	EGIT_BRANCH="master"
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
fi

inherit ${GIT_ECLASS}

DESCRIPTION="Improved Nano Syntax Highlighting Files"
HOMEPAGE="https://github.com/scopatz/nanorc"

LICENSE="GPL-3"
SLOT="0"

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
	insinto /usr/local/share/nano
	doins "${S}"/*.nanorc
}
