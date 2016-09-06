# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit unpacker

DESCRIPTION="TODO"
HOMEPAGE="TODO"

#SRC_URI="http://staruml.io/download/release/v2.7.0/StarUML-v2.7.0-64-bit.deb"
#32bit_URI="http://staruml.io/download/release/v2.7.0/StarUML-v2.7.0-32-bit.deb"
ROOT_URI="http://staruml.io/download/release/v${PV}"
SRC_URI="x86? ( ${ROOT_URI}/${PN}-v${PV}-32-bit.deb )
	amd64? ( ${ROOT_URI}/${PN}-v${PV}-64-bit.deb )"

LICENSE="StarUML"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_unpack() {
        # unpack deb
        unpack_deb ${A}
        unpacker data.tar.gz
}

#src_prepare() {
#}

src_install() {
	die "not implemented yet."
}
