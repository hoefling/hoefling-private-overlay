# Copyright 2026 Donald Hoefling
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Local hardening: inbound firewall, network sysctls, no LLMNR or remote libvirt"
HOMEPAGE="https://github.com/hoefling/hoefling-private-overlay"
S="${WORKDIR}"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="+firewall +libvirt +resolved +sysctl"

# Unit files and drop-ins are inert without systemd, so no dependency on it
# (systemd isn't installable on split-usr/musl profiles).
RDEPEND="firewall? ( net-firewall/nftables )"

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

	if use sysctl; then
		# /usr/lib so local overrides in /etc/sysctl.d win; 60- sorts after systemd's 50-default.conf
		insinto /usr/lib/sysctl.d
		newins "${FILESDIR}"/60-hardening.sysctl.conf 60-hardening.conf
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
	use sysctl && elog "  sysctl --system"
	if use libvirt; then
		elog
		elog "The remote libvirt sockets are masked. Also comment out 'listen_tcp = 1'"
		elog "in /etc/libvirt/libvirtd.conf (owned by app-emulation/libvirt)."
	fi
	if use sysctl; then
		elog
		elog "IP forwarding is off. Rootful Podman bridge networks re-enable it"
		elog "when they start; rootless Podman doesn't need it."
	fi
	if use firewall; then
		elog
		elog "Inbound traffic is now dropped unless allowed in"
		elog "/etc/nftables.d/50-hardening-inbound.nft. Add exceptions there, then run"
		elog "  systemctl reload hardening-nftables.service"
	fi
}
