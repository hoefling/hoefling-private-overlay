# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4} )

if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="https://github.com/hongtaocai/googlefinance"
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
fi

inherit distutils-r1 ${GIT_ECLASS}

DESCRIPTION="Google Finance Python API"
HOMEPAGE="https://pypi.python.org/pypi/googlefinance https://github.com/hongtaocai/googlefinance"

if [[ ${PV} == 9999 ]]; then
	KEYWORDS=""
	SRC_URI=""
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/hongtaocai/googlefinance/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

SLOT="0"
LICENSE="MIT"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

# not implemented in this version, git already has it
RESTRICT=test

python_test() {
	esetup.py test
}
