EAPI=8

inherit go-module go-env systemd

DESCRIPTION="New 🌊 wave for @helm"
HOMEPAGE="https://helmwave.app"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/helmwave/helmwave.git"
else
	SRC_URI="
		https://github.com/helmwave/helmwave/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/hoefling/helmwave-ebuild-deps/releases/download/v${PV}/${P}-deps.tar.gz
"
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64"
#IUSE="systemd"
DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	GOOS=linux ego build -ldflags="-s -w" ./cmd/helmwave
}

src_install() {
	dosbin ${PN}
	dodoc README.md
	default
}
