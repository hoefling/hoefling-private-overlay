# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{3,4,5} )

EGIT_REPO_URI="git://anongit.freedesktop.org/mesa/mesa"

if [[ ${PV} = 9999 ]]; then
        GIT_ECLASS="git-r3"
        EXPERIMENTAL="true"
fi

inherit distutils-r1 ${GIT_ECLASS}

DESCRIPTION="Event driven framework for python"
HOMEPAGE="https://github.com/quantmind/pulsar
	https://pypi.python.org/pypi/pulsar"

if [[ $PV == 9999 ]]; then
        SRC_URI=""
        KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
		https://github.com/quantmind/${PN}/archive/${PV}.zip -> ${P}.zip"
	KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
        test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

# tests
RESTRICT="test"

python_test() {
        esetup.py test
}
