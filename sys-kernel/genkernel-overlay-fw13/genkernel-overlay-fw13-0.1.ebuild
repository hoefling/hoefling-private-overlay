# Copyright 2026
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit tmpfiles

DESCRIPTION="genkernel INITRAMFS_OVERLAY content for the Framework 13 (dm-lvm rule mask, /dev/console)"
HOMEPAGE="https://wiki.gentoo.org/wiki/Genkernel"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="virtual/tmpfiles"

S="${WORKDIR}"

src_install() {
	insinto /var/lib/genkernel-overlay/lib/udev/rules.d
	doins "${FILESDIR}"/69-dm-lvm.rules

	keepdir /var/lib/genkernel-overlay/dev

	newtmpfiles "${FILESDIR}"/${PN}.conf ${PN}.conf
}

pkg_postinst() {
	tmpfiles_process ${PN}.conf
	elog "Set in /etc/genkernel.conf:"
	elog "    INITRAMFS_OVERLAY=\"/var/lib/genkernel-overlay\""
	elog "then rebuild kernel+initramfs with genkernel."
}
