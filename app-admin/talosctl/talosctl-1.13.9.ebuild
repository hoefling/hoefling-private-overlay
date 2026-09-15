EAPI=9

inherit go-module

DESCRIPTION="CLI for managing Talos Linux clusters"
HOMEPAGE="https://github.com/siderolabs/talos"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/siderolabs/talos.git"
else
	SRC_URI="
		https://github.com/siderolabs/talos/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/hoefling/talosctl-ebuild-deps/releases/download/v${PV}/${P}-deps.tar.gz
	"
fi

S="${WORKDIR}/talos-${PV}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

BDEPEND=">=dev-lang/go-1.26.7:="

src_compile() {
	GOWORK=off \
	CGO_ENABLED=0 \
	ego build \
		-mod=vendor \
		-trimpath \
		-o talosctl \
		./cmd/talosctl
}

src_install() {
	dobin talosctl
	dodoc README.md
}
