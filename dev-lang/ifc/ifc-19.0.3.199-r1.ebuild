# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

INTEL_DIST_SKU=3235
INTEL_DIST_PV=2019_update3_cluster_edition

inherit intel-sdp-r1

DESCRIPTION="Intel FORTRAN Compiler"
HOMEPAGE="http://software.intel.com/en-us/articles/intel-composer-xe/"

IUSE="doc"
KEYWORDS="-* ~amd64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND="~dev-libs/intel-common-${PV}[compiler]"

SLOT="0"

MY_PV=$(ver_rs 3 '-')  # 19.0.3-199
MY_PV2=$(ver_cut 2)  # 19.0
MY_PV3='20'$(ver_cut 1)'.'$(ver_cut 3-)  # 2019.3.199

CHECKREQS_DISK_BUILD=400M

INTEL_DIST_DAT_RPMS=( "ifort-common-${MY_PV}-${MY_PV}.noarch.rpm" )
INTEL_DIST_X86_RPMS=( "ifort-32bit-${MY_PV}-${MY_PV}.x86_64.rpm" )
INTEL_DIST_AMD64_RPMS=( "ifort-${MY_PV}-${MY_PV}.x86_64.rpm" )

pkg_setup() {
	if use doc; then
		INTEL_DIST_DAT_RPMS+=( "ifort-doc-${MY_PV2}-${MY_PV}.noarch.rpm" )
	fi
}

src_install() {
	# already provided in dev-libs/intel-common
	rm \
		"${WORKDIR}"/opt/intel/compilers_and_libraries_${MY_PV3}/linux/compiler/include/omp_lib.f90 \
		"${WORKDIR}"/opt/intel/compilers_and_libraries_${MY_PV3}/linux/compiler/include/intel64/omp_lib.mod \
		"${WORKDIR}"/opt/intel/compilers_and_libraries_${MY_PV3}/linux/compiler/include/intel64/omp_lib_kinds.mod \
		|| die "rm failed"

	intel-sdp-r1_src_install
}
