# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI='7'

inherit latex-package

DESCRIPTION="LaTeX package defining 16 colors from Ethan Schoonover's Solarized color palette"
HOMEPAGE="https://github.com/Jubobs/xcolor-solarized"
# Taken from: ftp://ftp.dante.de/tex-archive/macros/latex/contrib/${PN}.tar.gz
SRC_URI="https://github.com/Jubobs/${PN}/archive/v${PV}.zip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
S=${WORKDIR}/${P}
IUSE=""
DEPEND="dev-texlive/texlive-latexextra"
RDEPEND="dev-texlive/texlive-latexrecommended"

src_compile() {
	latex ${PN}.ins || die
}
