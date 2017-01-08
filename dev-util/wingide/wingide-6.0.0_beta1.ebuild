# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:
# mantainer: Ilya Kashirin (seclorum@seclorum.ru)
inherit eutils rpm versionator

MY_PV=$(replace_version_separator 3 '-')
MY_PV_MAJOR=$(get_major_version)
MY_PV_WING_CONFORM_BETA=${MY_PV/beta/b}

#MY_PV=$(replace_version_separator 3 '-')
#MY_PV1=${PV%.*}
#MY_PV2=${PV%.*.*}
#MY_PV3=${PV%.*.*.*}
# * 5.1.10-1
# * 5.1.10
# * 5.1
# * 5

# prerelease version url format:
#http://wingware.com/pub/wingide-personal/prerelease/6.0.0-b1/wingide-personal6-6.0.0-b1.x86_64.rpm

DESCRIPTION="the intelligent development environment for python programmers"
HOMEPAGE="http://www.wingware.com"
SRC_URI="http://wingware.com/pub/${PN}/prerelease/${MY_PV_WING_CONFORM_BETA}/${PN}${MY_PV_MAJOR}-${MY_PV_WING_CONFORM_BETA}.x86_64.rpm"

LICENSE="WingIDE-EULA"
SLOT="6"
KEYWORDS="~amd64"

DEPEND=">=dev-lang/python-2.0.0"

WINGHOME="/opt/${PN}"
S=${WORKDIR}

src_unpack () {
	rpm_src_unpack ${A}
	sed -i -e "s:/usr/lib/${PN}${MY_PV_MAJOR}:${WINGHOME}:g" usr/lib/${PN}${MY_PV_MAJOR}/wing || die
}


src_compile() {
	echo "Nothing to compile."
}

src_install() {
	dodir ${WINGHOME}
	cp -R ${WORKDIR}/usr/lib/${PN}${MY_PV_MAJOR}/* ${D}/${WINGHOME}/ || die "Install failed!"
	dosym ${WINGHOME}/wing /usr/bin/${PN}${MY_PV_MAJOR}

	for res in 16 32 48 64 128; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins "${WORKDIR}"/usr/lib/${PN}${MY_PV_MAJOR}/resources/wing${res}.png ${PN}${MY_PV_MAJOR}.png
	done

	insinto ${WINGHOME}
	doins "${FILESDIR}"/keymap.eclipse

	cat > ${PN}${MY_PV_MAJOR}.desktop <<-EOF
		[Desktop Entry]
		Version=${MY_PV_MAJOR}
		Type=Application
		Name=Wing IDE Professional ${MY_PV_MAJOR}
		Comment=Wingware Python IDE: Python IDE for Python Developers
		Exec=${PN}${MY_PV_MAJOR}
		Icon=${PN}${MY_PV_MAJOR}
		Categories=Development;
		MimeType=application/x-python;
	EOF

        insinto /usr/share/applications/
        doins ${PN}${MY_PV_MAJOR}.desktop
}

pkg_postinst() {
	einfo ""
	einfo "To run Wing IDE Professional use ${PN}${MY_PV_MAJOR} command"
	einfo ""
	einfo "To install fixes from Wing\`s developers run Wing IDE Professional under root"
	einfo "and select in menu Help-Check for updates"
	einfo ""
}
