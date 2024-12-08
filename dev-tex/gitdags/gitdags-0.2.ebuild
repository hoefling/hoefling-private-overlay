# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit latex-package

DESCRIPTION="A package for drawing educational Git history graphs"
HOMEPAGE="https://github.com/Jubobs/gitdags"
# Taken from: ftp://ftp.dante.de/tex-archive/macros/latex/contrib/${PN}.tar.gz
SRC_URI="https://github.com/Jubobs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${P}
LICENSE="LPPL-1.2"      # has been changed since 1.5
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND="dev-tex/xcolor-solarized
	>=dev-tex/pgf-3.0.1"

src_install(){
	latex-package_src_doinstall styles
	insinto ${TEXMF}/tex/latex/${PN}/
	doins ${PN}.sty || die
}
