# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 
# mantainer: Ilya Kashirin (seclorum@seclorum.ru)
inherit eutils rpm versionator

MY_PV=$(replace_version_separator 3 '-')
MY_PV1=${PV%.*}
MY_PV2=${PV%.*.*}
MY_PV3=${PV%.*.*.*}

# * 5.1.10-1
# * 5.1.10
# * 5.1
# * 5

DESCRIPTION="Wing IDE is advanced Python IDE."
HOMEPAGE="http://www.wingware.com"
SRC_URI="
	  x86? ( http://wingware.com/pub/${PN}/${MY_PV1}/${PN}${MY_PV3}-${MY_PV}.i386.rpm )
	  amd64? ( http://wingware.com/pub/${PN}/${MY_PV1}/${PN}${MY_PV3}-${MY_PV}.x86_64.rpm )
"

LICENSE="WingIDE"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=dev-lang/python-2.0.0"

WINGHOME="/opt/${PN}${MY_PV3}"
S=${WORKDIR}

src_unpack () {
	rpm_src_unpack ${A}
	sed -i -e "s:/usr/lib/${PN}${MY_PV3}:${WINGHOME}:g" usr/lib/${PN}${MY_PV3}/wing || die
}


src_compile() {
	echo "Nothing to compile."
}

src_install() {
	dodir ${WINGHOME}
	cp -R ${WORKDIR}/usr/lib/${PN}${MY_PV3}/* ${D}/${WINGHOME}/ || die "Install failed!"
	dosym ${WINGHOME}/wing /usr/bin/${PN}${MY_PV3}

	for res in 16 32 48 64 128; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins "${WORKDIR}"/usr/lib/${PN}${MY_PV3}/resources/wing${res}.png ${PN}${MY_PV3}.png
	done

	insinto ${WINGHOME}
        doins "${FILESDIR}"/keymap.eclipse

	cat > ${PN}${MY_PV3}.desktop <<-EOF
		[Desktop Entry]
		Version=${MY_PV3}
		Type=Application
		Name=Wing IDE Professional ${MY_PV_MAJOR}
		Comment=Wingware Python IDE: Python IDE for Python Developers
		Exec=${PN}${MY_PV3}
		Icon=wingide
		Categories=Development;
		MimeType=application/x-python;
	EOF

        insinto /usr/share/applications/
        doins ${PN}${MY_PV3}.desktop
}

pkg_postinst() {
	einfo ""
	einfo "To run Wing IDE Professional use ${PN}${MY_PV3} command"
	einfo ""
	einfo "To install fixes from Wing\`s developers run Wing IDE Professional under root"
	einfo "and select in menu Help-Check for updates"
	einfo ""
}
