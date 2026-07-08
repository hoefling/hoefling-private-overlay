# Copyright 2026
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit tmpfiles

DESCRIPTION="tmpfiles.d entries for polkit rules directories that polkitd warns about"
HOMEPAGE="https://gitlab.freedesktop.org/polkit/polkit"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	acct-user/polkitd
	sys-auth/polkit
	virtual/tmpfiles
"

S="${WORKDIR}"

src_install() {
	newtmpfiles "${FILESDIR}"/polkit-extra-dirs.conf polkit-extra-dirs.conf
}

pkg_postinst() {
	tmpfiles_process polkit-extra-dirs.conf
}
