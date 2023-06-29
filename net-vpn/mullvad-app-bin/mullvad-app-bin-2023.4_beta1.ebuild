# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm xdg

DESCRIPTION="Mullvad VPN App"
HOMEPAGE="https://mullvad.net"

MY_PN="MullvadVPN"
MY_PV=$(ver_rs 2 '-')
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="https://github.com/mullvad/mullvadvpn-app/releases/download/${MY_PV}/${MY_P}_x86_64.rpm"
S=${WORKDIR}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	insinto "/opt"
	doins -r "${S}/opt/Mullvad VPN"

	exeinto "/opt/Mullvad VPN"
	doexe "${S}/opt/Mullvad VPN/chrome_crashpad_handler"
	doexe "${S}/opt/Mullvad VPN/chrome-sandbox"
	doexe "${S}/opt/Mullvad VPN/libEGL.so"
	doexe "${S}/opt/Mullvad VPN/libffmpeg.so"
	doexe "${S}/opt/Mullvad VPN/libGLESv2.so"
	doexe "${S}/opt/Mullvad VPN/libvk_swiftshader.so"
	doexe "${S}/opt/Mullvad VPN/libvulkan.so.1"
	doexe "${S}/opt/Mullvad VPN/mullvad-gui"
	doexe "${S}/opt/Mullvad VPN/mullvad-vpn"

	exeinto "/usr/bin"
	doexe "${S}/usr/bin/mullvad"
	doexe "${S}/usr/bin/mullvad-daemon"
	doexe "${S}/usr/bin/mullvad-exclude"

	insinto "/usr/bin"
	doins "${S}/usr/bin/mullvad-problem-report"

	insinto "/usr"
	doins -r "${S}/usr/lib"
	doins -r "${S}/usr/share"
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
