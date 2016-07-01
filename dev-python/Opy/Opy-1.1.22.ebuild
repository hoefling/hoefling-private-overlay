# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} )

if [[ ${PV} == "9999" ]]; then
        GIT_ECLASS="git-r3"
	EGIT_REPO_URI="https://github.com/JdeH/Opy/${PN}.git"
        SRC_URI=""
        KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"
	KEYWORDS="~amd64 ~x86"
fi

inherit distutils-r1 ${GIT_ECLASS}

DESCRIPTION="Obfuscator for Python"
HOMEPAGE="https://github.com/JdeH/Opy
	https://pypi.python.org/pypi/Opy"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

# tests
RESTRICT="test"
