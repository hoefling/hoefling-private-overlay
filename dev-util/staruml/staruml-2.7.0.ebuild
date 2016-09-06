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
SRC_URI="x86? ( ${ROOT_URI}/StarUML-v${PV}-32-bit.deb )
	amd64? ( ${ROOT_URI}/StarUML-v${PV}-64-bit.deb )"

LICENSE="StarUML"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libgcrypt:11"
DEPEND=""

INSTALLDIR="/opt/${PN}"
S="${WORKDIR}"

src_unpack() {
        # unpack deb
        unpack_deb ${A}
}

src_compile() {
	einfo "nothing to compile."
}

src_install() {
	dodir ${INSTALLDIR}
	cp -R ${WORKDIR}/opt/${PN} ${D}/${INSTALLDIR}/ || die "Install failed!"
	dosym ${INSTALLDIR}/${PN}/${PN} /usr/bin/${PN}

	for res in 16 32 48 64 128; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins "${WORKDIR}"/usr/share/icons/hicolor/scalable/apps/${PN}.svg ${PN}.svg
		newins "${WORKDIR}"/opt/${PN}/appshell32.png ${PN}.png
	done

	cat > ${PN}.desktop <<-EOF
		[Desktop Entry]
		Type=Application
		Name=StarUML
		Comment=StarUML Software Modeler
		Exec=/usr/bin/${PN}
		Icon=${PN}
		Categories=Development;
		#icon="/opt/staruml/appshell32.png"
	EOF

	insinto /usr/share/applications/
	doins ${PN}.desktop
}
