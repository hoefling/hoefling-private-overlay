# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:
# mantainer: Ilya Kashirin (seclorum@seclorum.ru)
inherit eutils rpm versionator

MY_PV=$(replace_version_separator 3 '-')
#MY_PV1=${PV%.*}
#MY_PV2=${PV%.*.*}
#MY_PV3=${PV%.*.*.*}
MY_PV_MAJOR=$(get_major_version)
MY_PV1=${MY_PV/beta/b}

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
SRC_URI="http://wingware.com/pub/wingide/prerelease/${MY_PV1}/wingide${MY_PV_MAJOR}-${MY_PV1}.x86_64.rpm"

LICENSE="WingIDE"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-lang/python-2.0.0"

WINGHOME="/opt/${PN}"
S=${WORKDIR}

src_unpack () {
	einfo "${PV}"
	einfo "${PR}"
	einfo "${PVR}"
	rpm_src_unpack ${A}
	sed -i -e "s:/usr/lib/wingide${MY_PV3}:${WINGHOME}:g" usr/lib/wingide${MY_PV3}/wing || die
}


src_compile() {
	echo "Nothing to compile."
}

src_install() {
	dodir ${WINGHOME}
	cp -R ${WORKDIR}/usr/lib/wingide${MY_PV3}/* ${D}/${WINGHOME}/ || die "Install failed!"
	dosym ${WINGHOME}/wing /usr/bin/wingide

	for res in 16 32 48 64 128; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins "${WORKDIR}"/usr/lib/wingide${MY_PV3}/resources/wing${res}.png wingide.png
	done

	insinto ${WINGHOME}
	doins "${FILESDIR}"/keymap.eclipse
}

pkg_postinst() {
	einfo ""
	einfo "To run Wing IDE Professional use wingide command"
	einfo ""
	einfo "To install fixes from Wing\`s developers run wingide under root"
	einfo "and select in menu Help-Check for updates"
	einfo ""
}
