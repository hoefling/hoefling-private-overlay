# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Extensions for dev-python/devpi-client"
HOMEPAGE="https://pypi.org/project/devpi-client-extensions/ https://github.com/hoefling/devpi-client-extensions/"
SRC_URI="
	mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	https://github.com/hoefling/devpi-client-extensions/archive/${PV}.zip -> ${P}.zip"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-python/devpi-client[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	 ${EPYTHON} -m pytest -vv || die
}
