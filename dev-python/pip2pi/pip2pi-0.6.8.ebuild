# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="pip2pi builds a PyPI-compatible package repository from pip requirements"
HOMEPAGE="https://pypi.python.org/pypi/pip2pi https://github.com/wolever/pip2pi"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="BSD"
SLOT="0"

DEPEND="dev-python/pip[${PYTHON_USEDEP}]"

REQUIRED_USE=""
