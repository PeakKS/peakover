# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson tmpfiles

DESCRIPTION="Tool for interactive command line environments on Linux"
HOMEPAGE="https://containertoolbx.org/ https://github.com/containers/toolbox"
SRC_URI="
	https://github.com/containers/${PN}/releases/download/${PV}/${P}-vendored.tar.xz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-lang/go
	dev-go/go-md2man
"
RDEPEND="${DEPEND}"

PATCHES=(
	# Fix for weird go build cache issue https://github.com/containers/toolbox/pull/1722
	"${FILESDIR}"/0001-Replace-build-wrapper-with-native-meson-targets.patch
	"${FILESDIR}"/0002-Restore-support-for-migration-path-and-setting-versi.patch
	"${FILESDIR}"/0003-Don-t-explicitly-pass-toolbox.go-to-build.patch
	"${FILESDIR}"/0004-Fix-setting-dynamic-linker.patch
)

pkg_postinst() {
	tmpfiles_process toolbox.conf
}
