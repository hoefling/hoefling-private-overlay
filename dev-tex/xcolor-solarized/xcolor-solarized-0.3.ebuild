# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit latex-package

DESCRIPTION="A LaTeX package defining the 16 colors from Ethan Schoonover's popular Solarized color palette"
HOMEPAGE="https://github.com/Jubobs/xcolor-solarized"
# Taken from: ftp://ftp.dante.de/tex-archive/macros/latex/contrib/${PN}.tar.gz
SRC_URI="https://github.com/Jubobs/${PN}/archive/v${PV}.zip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
S=${WORKDIR}/${P}
IUSE=""
DEPEND="dev-texlive/texlive-latexextra"
RDEPEND="dev-texlive/texlive-latex
	dev-tex/xcolor"

src_compile() {
	latex ${PN}.ins || die
}

#TEXMF_DIST="/usr/share/texmf-dist"
#src_install(){
#	latex-package_src_doinstall styles
#	insinto ${TEXMF}/tex/latex/${PN}/
#	doins ${PN}.sty
#	insinto ${TEXMF_DIST}
#}
