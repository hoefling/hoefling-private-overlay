# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

INTEL_DIST_SKU=3235
INTEL_DIST_PV=2019_update3_cluster_edition

inherit intel-sdp-r1

DESCRIPTION="Intel C/C++ Compiler"
HOMEPAGE="http://software.intel.com/en-us/articles/intel-composer-xe/"

IUSE="doc"
KEYWORDS="-* ~amd64 ~x86 ~amd64-linux ~x86-linux"

# avoid file collision with ifc #476330
RDEPEND="~dev-libs/intel-common-${PV}[compiler]"

SLOT="0"

MY_PV=$(ver_rs 3 '-')  # 19.0.3-199
MY_PV2=$(ver_cut 1-2)  # 19.0

CHECKREQS_DISK_BUILD=500M

INTEL_DIST_DAT_RPMS=(
	"icc-common-${MY_PV}-${MY_PV}.noarch.rpm"
	"icc-common-ps-${MY_PV}-${MY_PV}.noarch.rpm"
	"icc-common-ps-ss-bec-${MY_PV}-${MY_PV}.noarch.rpm")
INTEL_DIST_AMD64_RPMS=(
	"icc-${MY_PV}-${MY_PV}.x86_64.rpm"
	"icc-ps-${MY_PV}-${MY_PV}.x86_64.rpm"
	"icc-ps-ss-bec-${MY_PV}-${MY_PV}.x86_64.rpm")
INTEL_DIST_X86_RPMS=(
	"icc-32bit-${MY_PV}-${MY_PV}.x86_64.rpm"
	"icc-ps-ss-bec-32bit-${MY_PV}-${MY_PV}.x86_64.rpm")

pkg_setup() {
	if use doc; then
		INTEL_DIST_DAT_RPMS+=(
			"icc-doc-${MY_PV2}-${MY_PV}.noarch.rpm"
			"icc-doc-ps-${MY_PV2}-${MY_PV}.noarch.rpm")
	fi
}
