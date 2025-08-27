# https://wiki.gentoo.org/wiki/Portage_TMPDIR_on_tmpfs

EAPI=8

inherit systemd

DESCRIPTION="Mount /var/tmp/portage to tmpfs"
HOMEPAGE="https://hoefling.io"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64"

src_install() {
	systemd_dounit "${FILESDIR}/var-tmp-portage.mount"
	default
}
