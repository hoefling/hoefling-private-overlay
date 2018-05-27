# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python2_7 python3_4 python3_5 python3_6 pypy3 )

inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/myint/yolk.git"
	inherit git-r3
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
fi

DESCRIPTION="Tool and library for querying PyPI and locally installed Python packages"
HOMEPAGE="https://pypi.org/project/yolk3k/"

LICENSE="BSD"
SLOT="0"

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"
