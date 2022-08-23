# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="LookingGlass"
MY_PV="a11"
EGIT_REPO_URI="https://github.com/gnif/${MY_PN}.git"
EGIT_SUBMODULES=( '*' )

inherit cmake git-r3 linux-mod

DESCRIPTION="A low latency KVM FrameRelay implementation for guests with VGA PCI Passthrough"
HOMEPAGE="https://looking-glass.io https://github.com/gnif/LookingGlass"
SRC_URI="host? ( https://github.com/gnif/${MY_PN}/releases/download/${MY_PV}/looking-glass-host-${MY_PV}.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug +host module"

RDEPEND="dev-libs/libconfig:0=
	dev-libs/nettle:=[gmp]
	media-libs/freetype:2
	media-libs/fontconfig:1.0
	media-libs/libsdl2
	media-libs/sdl2-ttf
	virtual/glu"
DEPEND="${RDEPEND}
	app-emulation/spice-protocol"
BDEPEND="app-arch/unzip
	virtual/pkgconfig"

BUILD_TARGETS="all"
MODULE_NAMES="kvmfr(:${S}/module:${S}/module)"

CMAKE_USE_DIR="${S}"/client

pkg_setup() {
	if use module; then
		linux-mod_pkg_setup
		export KERNELRELEASE=${KV_FULL}
	fi
}

src_prepare() {
	default

	# Respect FLAGS
	sed -i '/CMAKE_C_FLAGS/s/-O3 -march=native //' \
		client/CMakeLists.txt || die "sed failed for FLAGS"

	if ! use debug ; then
		sed -i '/CMAKE_C_FLAGS/s/-g //' \
		client/CMakeLists.txt || die "sed failed for debug"
	fi

	cmake_src_prepare
}

src_compile() {
	cmake_src_compile
	if use module; then
		linux-mod_src_compile
	fi
}

src_install() {
	einstalldocs

	dobin "${BUILD_DIR}"/looking-glass-client

	if use host ; then
		insinto /usr/share/"${PN}"
		doins "${DISTDIR}"/looking-glass-host-"${MY_PV}".zip
	fi

	if use module; then
		linux-mod_src_install
	fi
}

pkg_postinst() {
	if use module; then
		elog "You have installed the kvmfr kernel module for DMABUF"
		elog "To set up for using the module, please visit https://looking-glass.io/docs/stable/module/#usage"
	fi
}
