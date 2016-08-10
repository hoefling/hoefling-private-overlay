# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Sphinx extension that automatically document argparse commands and options"
HOMEPAGE="https://pypi.python.org/pypi/sphinx-argparse https://github.com/ribozz/sphinx-argparse"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="MIT"
SLOT="0"

DEPEND="dev-python/sphinx[${PYTHON_USEDEP}]"

REQUIRED_USE=""
