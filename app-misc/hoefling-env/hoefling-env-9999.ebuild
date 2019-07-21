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
SRC_URI="https://github.com/hoefling/python3/archive/gentoo-dell-xps13-9370.tar.gz"

if [[ ${PV} == 9999* ]]; then
	KEYWORDS=""
	S="${WORKDIR}/${P}"
else
	# versioning not supported (yet?)
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
	PY3_PATCHES=(
		"0001-clear-linux-0001-Fix-python-path-for-linux.patch"
		"0002-clear-linux-0002-Skip-tests-TODO-fix-skips.patch"
		"0003-clear-linux-0003-Use-pybench-to-optimize-python.patch"
		"0004-clear-linux-0004-Add-avx2-and-avx512-support.patch"
		"0005-clear-linux-0005-Build-avx2-and-avx512-versions-of-the-math-library.patch"
		"0006-clear-linux-0001-Add-pybench-for-pgo-optimization.patch"
		"0007-clear-linux-0001-pythonrun.c-telemetry-patch.patch"
	)
	insinto "/etc/portage/patches/dev-lang/python:3.7"
	for _patch in "${PY3_PATCHES[@]}"; do
		newins "${WORKDIR}/python3-gentoo-dell-xps13-9370/${_patch##*clear-linux-}" $_patch
	done
}

pkg_postinst() {
	elog "To enable mlocate database updates, you will need "
	elog "to enable the mlocate-updatedb timer:"
	elog "    systemctl enable --now mlocate-updatedb.timer"
	elog
	elog "To mount /var/tmp/portage to tmpfs:"
	elog "    systemctl enable --now var-tmp-portage.mount"
}
