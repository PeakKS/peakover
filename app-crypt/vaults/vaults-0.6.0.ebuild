# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.20
	anyhow-1.0.69
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	block-0.1.6
	cairo-rs-0.16.7
	cairo-sys-rs-0.16.3
	cc-1.0.79
	cfg-expr-0.11.0
	cfg-if-1.0.0
	env_logger-0.7.1
	field-offset-0.3.5
	futures-channel-0.3.26
	futures-core-0.3.26
	futures-executor-0.3.26
	futures-io-0.3.26
	futures-macro-0.3.26
	futures-task-0.3.26
	futures-util-0.3.26
	gdk-pixbuf-0.16.7
	gdk-pixbuf-sys-0.16.3
	gdk4-0.5.5
	gdk4-sys-0.5.5
	gettext-rs-0.7.0
	gettext-sys-0.21.3
	gio-0.16.7
	gio-sys-0.16.3
	glib-0.16.7
	glib-macros-0.16.3
	glib-sys-0.16.3
	gobject-sys-0.16.3
	graphene-rs-0.16.3
	graphene-sys-0.16.3
	gsk4-0.5.5
	gsk4-sys-0.5.5
	gtk-macros-0.3.0
	gtk4-0.5.5
	gtk4-macros-0.5.5
	gtk4-sys-0.5.5
	hashbrown-0.12.3
	heck-0.4.1
	hermit-abi-0.1.19
	humantime-1.3.0
	indexmap-1.9.2
	lazy_static-1.4.0
	libadwaita-0.2.1
	libadwaita-sys-0.2.1
	libc-0.2.139
	locale_config-0.3.0
	log-0.4.17
	malloc_buf-0.0.6
	memchr-2.5.0
	memoffset-0.8.0
	objc-0.2.7
	objc-foundation-0.1.1
	objc_id-0.1.1
	once_cell-1.17.1
	pango-0.16.5
	pango-sys-0.16.3
	partition-identity-0.3.0
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pkg-config-0.3.26
	pretty_env_logger-0.4.0
	proc-macro-crate-1.3.1
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.51
	proc-mounts-0.3.0
	quick-error-1.2.3
	quick-error-2.0.1
	quote-1.0.23
	regex-1.7.1
	regex-syntax-0.6.28
	rustc_version-0.4.0
	rustversion-1.0.12
	semver-1.0.16
	serde-1.0.153
	serde_derive-1.0.153
	serde_spanned-0.6.1
	slab-0.4.8
	smallvec-1.10.0
	strum-0.24.1
	strum_macros-0.24.3
	syn-1.0.109
	system-deps-6.0.3
	temp-dir-0.1.11
	termcolor-1.2.0
	thiserror-1.0.39
	thiserror-impl-1.0.39
	toml-0.5.11
	toml-0.7.2
	toml_datetime-0.6.1
	toml_edit-0.19.4
	unicode-ident-1.0.8
	version-compare-0.1.1
	version_check-0.9.4
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	winnow-0.3.5
"

inherit meson xdg cargo gnome2-utils

DESCRIPTION="Vaults lets you create encrypted vaults in which you can safely store files."
HOMEPAGE="https://github.com/mpobaschnig/vaults"
SRC_URI="
	$(cargo_crate_uris)
	https://github.com/mpobaschnig/${PN}/archive/refs/tags/${PV}.tar.gz
"

LICENSE="GPL-3 Apache-2.0 GPL-3+ MIT Unicode-DFS-2016 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/glib-2.66
	>=gui-libs/gtk-4.4.0
	>=gui-libs/libadwaita-1.0.0
"
RDEPEND="${DEPEND}
	sys-fs/cryfs
"
BDEPEND="
	dev-util/meson
	virtual/rust
"

src_unpack() {
	cargo_src_unpack
	default_src_unpack
}

src_configure() {
	local emesonargs=(
		-Dprofile=default
	)
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
