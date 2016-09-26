# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} pypy )

EGIT_REPO_URI="https://github.com/ReactiveX/RxPY.git"
EGIT_BRANCH="master"

if [[ ${PV} = 9999 ]]; then
        GIT_ECLASS="git-r3"
        EXPERIMENTAL="true"
fi

inherit distutils-r1 ${GIT_ECLASS}

DESCRIPTION="Reactive Extensions (Rx) for Python"
HOMEPAGE="https://pypi.python.org/pypi/Rx https://github.com/ReactiveX/RxPY"

if [[ ${PV} == 9999 ]]; then
        SRC_URI=""
        KEYWORDS=""
else
	SRC_URI="
		mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
		https://github.com/ReactiveX/RxPY/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
fi

SLOT="0"
LICENSE="MIT"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

# not implemented in this version, git already has it
RESTRICT=test

python_test() {
	esetup.py test
}
