EAPI=8

inherit go-module systemd

DESCRIPTION="Automated WireGuard® Management Client"
HOMEPAGE="https://netmaker.io"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gravitl/netclient.git"
else
	SRC_URI="
		https://github.com/gravitl/netclient/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/hoefling/netclient-ebuild-deps/releases/download/v${PV}/${P}-deps.tar.gz
"
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64"
IUSE="systemd"
DEPEND="net-vpn/wireguard-tools
	net-firewall/iptables
	net-firewall/nftables
	systemd? ( sys-apps/systemd )
"
RDEPEND="${DEPEND}"

#S="${WORKDIR}"

src_compile() {
	ego build
}

src_install() {
	dosbin ${PN}
	if use systemd; then
		systemd_newunit ${S}/build/${PN}.service ${PN}.service
	fi
}

# nano /var/db/repos/gentoo/media-libs/amdgpu-pro-vulkan/amdgpu-pro-vulkan-22.40.6.1580631-r1.ebuild for the rest
