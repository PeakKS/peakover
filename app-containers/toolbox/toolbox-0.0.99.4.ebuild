# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson tmpfiles

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="
	https://github.com/containers/${PN}/releases/download/${PV}/${P}-vendored.tar.xz -> ${P}-vendored.tar
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-lang/go
	dev-go/go-md2man
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	# Force vendor mode
	sed -i '75i        -v -mod=vendor \\' ${S}/src/go-build-wrapper
	sed -i "s/'run'/'run', '-mod=vendor', '-v'/g" ${S}/src/meson_generate_completions.py

	# Force disable zsh completions generation
	sed -i '72,116d' ${S}/src/meson.build

	eapply_user
}

pkg_postinst() {
	tmpfiles_process toolbox.conf
}
