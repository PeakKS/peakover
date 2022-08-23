# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Linux port of Nem's VTFLib"
HOMEPAGE="https://github.com/panzi/VTFLib"
inherit git-r3
EGIT_REPO_URI="https://github.com/panzi/${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_INSTALL_PREFIX="/usr"
		-DUSE_LIBTXC_DXTN=OFF
	)
	cmake_src_configure
}
