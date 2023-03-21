# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1 desktop xdg

DESCRIPTION="A wine+roblox management application"
HOMEPAGE="
	https://gitlab.com/brinkervii/grapejuice
"
SRC_URI="https://gitlab.com/brinkervii/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sys-devel/gettext
	dev-vcs/git
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]
	x11-libs/cairo
	x11-libs/gtk+
	dev-libs/gobject-introspection
	dev-util/desktop-file-utils
	x11-misc/xdg-utils
	x11-misc/xdg-user-dirs
	dev-util/gtk-update-icon-cache
	x11-misc/shared-mime-info
	x11-apps/mesa-progs
	virtual/wine
"

src_install() {
	distutils-r1_src_install

	for i in {16,24,32,48,64,128,256}; do
		icondir=${S}/src/grapejuice_common/assets/icons/hicolor/${i}x${i}/apps
		newicon -s ${i} ${icondir}/grapejuice.png grapejuice.png
		newicon -s ${i} ${icondir}/grapejuice-roblox-player.png grapejuice-roblox-player.png
		newicon -s ${i} ${icondir}/grapejuice-roblox-studio.png grapejuice-roblox-studio.png
	done

	desktop_dir=${S}/src/grapejuice_common/assets/desktop
	sed -i 's/$GRAPEJUICE_GUI_EXECUTABLE/\/usr\/bin\/grapejuice-gui/g' ${desktop_dir}/grapejuice.desktop
	sed -i 's/$GRAPEJUICE_EXECUTABLE/\/usr\/bin\/grapejuice/g' ${desktop_dir}/roblox-app.desktop
	sed -i 's/$GRAPEJUICE_EXECUTABLE/\/usr\/bin\/grapejuice/g' ${desktop_dir}/roblox-player.desktop
	sed -i 's/$GRAPEJUICE_EXECUTABLE/\/usr\/bin\/grapejuice/g' ${desktop_dir}/roblox-studio.desktop
	sed -i 's/$GRAPEJUICE_EXECUTABLE/\/usr\/bin\/grapejuice/g' ${desktop_dir}/roblox-studio-auth.desktop
	sed -i 's/$GRAPEJUICE_ICON/grapejuice/g' ${desktop_dir}/grapejuice.desktop
	sed -i 's/$PLAYER_ICON/grapejuice-roblox-player/g' ${desktop_dir}/roblox-app.desktop
	sed -i 's/$PLAYER_ICON/grapejuice-roblox-player/g' ${desktop_dir}/roblox-player.desktop
	sed -i 's/$STUDIO_ICON/grapejuice-roblox-studio/g' ${desktop_dir}/roblox-studio.desktop
	sed -i 's/$STUDIO_ICON/grapejuice-roblox-studio/g' ${desktop_dir}/roblox-studio-auth.desktop
	domenu ${desktop_dir}/grapejuice.desktop
	domenu ${desktop_dir}/roblox-app.desktop
	domenu ${desktop_dir}/roblox-player.desktop
	domenu ${desktop_dir}/roblox-studio.desktop
	domenu ${desktop_dir}/roblox-studio-auth.desktop
}

xdg_pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

xdg_pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
