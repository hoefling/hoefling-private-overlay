# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/hoefling/gentoo-postinstall.git"
EGIT_BRANCH="master"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
fi

inherit ${GIT_ECLASS} systemd

DESCRIPTION="My private stuff"
HOMEPAGE="https://github.com/hoefling/gentoo-postinstall"

if [[ ${PV} == 9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
	S="${WORKDIR}/${P}"
else
	# versioning not supported
	SRC_URI=""
	KEYWORDS=""
	S="${WORKDIR}/${P}"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="+systemd +test"

RDEPEND="
	systemd? ( sys-apps/systemd:= )"
DEPEND="
	test? (
		${RDEPEND}
		dev-util/bats
	)"
BDEPEND=""

src_unpack() {
	default
	[[ ${PV} = 9999* ]] && git-r3_src_unpack
}

src_test() {
	bats "${S}/tests/" || die "Tests failed - there might be something wrong with the system configuration"
}

src_install() {
	default
	insinto /etc/portage
	newins "${S}/portage-bashrc" bashrc
	use systemd && systemd_dounit "${S}"/systemd/*.*
}

pkg_postinst() {
	elog "To enable mlocate database updates, you will need "
	elog "to enable the mlocate-updatedb timer:"
	elog "    systemctl enable --now mlocate-updatedb.timer"
	elog
	elog "To mount /var/tmp/portage to tmpfs:"
	elog "    systemctl enable --now var-tmp-portage.mount"
}
