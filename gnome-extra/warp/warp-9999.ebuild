# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson cargo git-r3 xdg gnome2-utils

DESCRIPTION="Fast and secure file transfer"
HOMEPAGE="https://gitlab.gnome.org/World/warp"
EGIT_REPO_URI="https://gitlab.gnome.org/World/${PN}.git"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 EUPL-1.2 GPL-3 ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS=""

DEPEND="
	>=dev-libs/glib-2.66
	>=gui-libs/gtk-4.10.0
	>=gui-libs/libadwaita-1.4_alpha
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	git-r3_fetch
	git-r3_checkout
	cargo_live_src_unpack
}

src_configure() {
	meson_src_configure
	cargo_src_configure
}

src_compile() {
	CARGO_TARGET_DIR="${BUILD_DIR}/target" cargo_src_compile
	ln -s "${ECARGO_HOME}" "${BUILD_DIR}/cargo-home"
	meson_src_compile
}

src_install() {
	meson_install
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
