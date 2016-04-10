# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Google Spreadsheets Python API"
HOMEPAGE="https://pypi.python.org/pypi/gspread https://github.com/burnash/gspread"
SRC_URI="
	https://github.com/burnash/gspread/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
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
