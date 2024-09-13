# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson tmpfiles

DESCRIPTION="Tool for interactive command line environments on Linux"
HOMEPAGE="https://containertoolbx.org/ https://github.com/containers/toolbox"
SRC_URI="
	https://github.com/containers/${PN}/releases/download/${PV}/${P}-vendored.tar.xz
"
# https://github.com/containers/${PN}/releases/download/${PV}/${P}-vendored.tar.xz -> ${P}-vendored.tar

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-lang/go
	dev-go/go-md2man
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	tmpfiles_process toolbox.conf
}
