EAPI=8

inherit systemd

DESCRIPTION="Local hardening: inbound nftables policy, no LLMNR, no remote libvirt sockets"
HOMEPAGE="https://github.com/hoefling/hoefling-private-overlay"
S="${WORKDIR}"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+firewall +libvirt +resolved"

RDEPEND="
	sys-apps/systemd
	firewall? ( net-firewall/nftables )
"

src_install() {
	if use firewall; then
		insinto /etc/nftables.d
		doins "${FILESDIR}"/50-hardening-inbound.nft
		systemd_dounit "${FILESDIR}"/hardening-nftables.service
	fi

	if use resolved; then
		insinto /etc/systemd/resolved.conf.d
		doins "${FILESDIR}"/50-hardening.conf
	fi

	if use libvirt; then
		# A unit symlinked to /dev/null in /etc is masked: socket activation can't start it.
		local unit
		for unit in libvirtd-{tcp,tls}.socket virtproxyd-{tcp,tls}.socket; do
			dosym /dev/null /etc/systemd/system/${unit}
		done
	fi
}

pkg_postinst() {
	elog "Apply the changes:"
	elog "  systemctl daemon-reload"
	use firewall && elog "  systemctl enable --now hardening-nftables.service"
	use resolved && elog "  systemctl restart systemd-resolved.service"
	if use libvirt; then
		elog
		elog "The remote libvirt sockets are masked. Also comment out 'listen_tcp = 1'"
		elog "in /etc/libvirt/libvirtd.conf (owned by app-emulation/libvirt)."
	fi
	if use firewall; then
		elog
		elog "Inbound traffic is now dropped unless allowed in"
		elog "/etc/nftables.d/50-hardening-inbound.nft. Add exceptions there, then run"
		elog "  systemctl reload hardening-nftables.service"
	fi
}
