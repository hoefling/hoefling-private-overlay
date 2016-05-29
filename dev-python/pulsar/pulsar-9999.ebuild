# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} )

if [[ ${PV} = 9999 ]]; then
        EXPERIMENTAL="true"
        GIT_ECLASS="git-r3"
	EGIT_REPO_URI="https://github.com/quantmind/${PN}.git"
        SRC_URI=""
        KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
		https://github.com/quantmind/${PN}/archive/${PV}.zip -> ${P}.zip"
	KEYWORDS="~amd64 ~x86"
fi

inherit distutils-r1 ${GIT_ECLASS}

DESCRIPTION="Event driven framework for python"
HOMEPAGE="https://github.com/quantmind/pulsar
	https://pypi.python.org/pypi/pulsar"

LICENSE="MIT"
SLOT="0"
IUSE="doc examples test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

# tests
RESTRICT="test"

python_test() {
        esetup.py test
}

python_install_all() {
        #if use doc; then
        #        local DOCS=( *.txt doc/*.txt )
        #        local HTML_DOCS=( doc/html/. )
        #fi
        use examples && local EXAMPLES=( examples/. )

        distutils-r1_python_install_all
}
