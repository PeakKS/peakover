# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg desktop

DESCRIPTION="A program used for applying custom artwork to Steam, using SteamGridDB."
HOMEPAGE="https://www.steamgriddb.com/"

MY_PN="SGDBoop"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/SteamGridDB/${MY_PN}/archive/v${PV}/${MY_P}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="CC BY-SA 4.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	net-misc/curl
	x11-libs/gtk+:3
	x11-libs/gdk-pixbuf
	x11-libs/pango
	x11-libs/cairo
	dev-libs/glib
	x11-libs/libXext
	x11-libs/libX11
"
RDEPEND="${DEPEND}"

src_install() {
	exeinto "/usr/bin"
	doexe linux-release/SGDBoop
	domenu linux-release/com.steamgriddb.SGDBoop.desktop
}

xdg_pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

xdg_pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
