# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

EGIT_REPO_URI="https://github.com/hoefling/gentoo-postinstall"
EGIT_BRANCH="master"

DESCRIPTION="My private stuff"
HOMEPAGE="https://github.com/hoefling/gentoo-postinstall"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="+test"

RDEPEND=""
DEPEND="
	test? (
		${RDEPEND}
		dev-util/bats
	)"

src_unpack() {
	git-r3_fetch
	git-r3_checkout
}

src_test() {
	bats tests/ || die
}

src_install() {
	mkdir -p "${ED}/etc/portage"
	cp "${WORKDIR}/${P}/portage-bashrc" "${ED}/etc/portage/bashrc" || die
}
