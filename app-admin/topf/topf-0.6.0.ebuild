EAPI=9

inherit go-module

DESCRIPTION="Talos orchestrator by PostFinance"
HOMEPAGE="https://github.com/postfinance/topf"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/postfinance/topf.git"
else
	SRC_URI="
		https://github.com/postfinance/topf/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/hoefling/topf-ebuild-deps/releases/download/v${PV}/${P}-deps.tar.gz
	"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

BDEPEND=">=dev-lang/go-1.26.7:="

src_compile() {
	ego build \
		-trimpath \
		-ldflags "-s -w -X main.version=v${PV}" \
		-o topf \
		./cmd/topf
}

src_install() {
	dobin topf
	dodoc README.md
	default
}
