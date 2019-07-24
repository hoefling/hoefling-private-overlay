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
SRC_URI="
	https://github.com/hoefling/python3/archive/gentoo-dell-xps13-9370.tar.gz -> clearlinux-python3-gentoo.tar.gz
	https://github.com/clearlinux-pkgs/numpy/archive/master.tar.gz -> clearlinux-numpy-master.tar.gz"

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

	PY36_PATCHES=(
		"0001-clearlinux-0001-Fix-python-path-for-linux.patch"
		"0002-clearlinux-0002-Skip-tests-TODO-fix-skips.patch"
		"0003-clearlinux-0003-Use-pybench-to-optimize-python.patch"
		"0004-clearlinux-0004-Add-avx2-and-avx512-support.patch"
		"0005-clearlinux-0005-Build-avx2-and-avx512-versions-of-the-math-library.patch"
		"0007-clearlinux-0001-pythonrun.c-telemetry-patch.patch"
	)
	insinto "/etc/portage/patches/dev-lang/python:3.6"
	for _patch in "${PY36_PATCHES[@]}"; do
		newins "${WORKDIR}/python3-gentoo-dell-xps13-9370/${_patch##*clearlinux-}" $_patch
	done

	PY37_PATCHES=(
		"0001-clearlinux-0001-Fix-python-path-for-linux.patch"
		"0002-clearlinux-0002-Skip-tests-TODO-fix-skips.patch"
		"0003-clearlinux-0003-Use-pybench-to-optimize-python.patch"
		"0004-clearlinux-0004-Add-avx2-and-avx512-support.patch"
		"0005-clearlinux-0005-Build-avx2-and-avx512-versions-of-the-math-library.patch"
		"0006-clearlinux-0001-Add-pybench-for-pgo-optimization.patch"
		"0007-clearlinux-0001-pythonrun.c-telemetry-patch.patch"
	)
	insinto "/etc/portage/patches/dev-lang/python:3.7"
	for _patch in "${PY37_PATCHES[@]}"; do
		newins "${WORKDIR}/python3-gentoo-dell-xps13-9370/${_patch##*clearlinux-}" $_patch
	done

	NUMPY_PATCHES=(
		"0001-clearlinux-build.patch"
		"0002-clearlinux-avx2-distutils.patch"
		"0003-clearlinux-avx2-fortran-distutils.patch"
		"0004-clearlinux-timestamp.patch"
	)
	insinto "/etc/portage/patches/dev-python/numpy"
	for _patch in "${NUMPY_PATCHES[@]}"; do
		newins "${WORKDIR}/numpy-master/${_patch##*clearlinux-}" $_patch
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
