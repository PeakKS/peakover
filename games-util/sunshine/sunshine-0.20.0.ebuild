# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SUNSHINE_COMMIT="31e8b798dabf47d5847a1b485f57cf850a15fcae"
SIMPLEWEB_COMMIT="27b41f5ee154cca0fce4fe2955dd886d04e3a4ed"
CIRCULAR_COMMIT="8833b3a73fab6530cc51e2063a85cced01714cfb"
VIGEM_COMMIT="9e842ba1c3a6efbb90d9b7e9346a55b1a3d10494"
FFMPEG_COMMIT="d8f29a064caabdeb78f263a5017a5dbdaa454eb6"
MINIUPNP_COMMIT="e439318cf782e30066d430f27a1365e013a5ab94"
MOONLIGHT_COMMIT="c9426a6a71c4162e65dde8c0c71a25f1dbca46ba"
ENET_COMMIT="47e42dbf422396ce308a03b5a95ec056f0f0180c"
NANORS_COMMIT="395e5ada44dd8d5974eaf6bb6b17f23406e3ca72"
NVCODEC_COMMIT="2cd175b30366b6e295991ee0540e3e875cce6f2e"
TRAY_COMMIT="75106962a8ec5abb86157908d12cb799147babb4"

inherit cmake udev fcaps
DESCRIPTION="Self-hosted game stream host for Moonlight."
HOMEPAGE="https://github.com/LizardByte/Sunshine"

SUBMODULES="
	https://gitlab.com/eidheim/Simple-Web-Server/-/archive/${SIMPLEWEB_COMMIT}/Simple-Web-Server-${SIMPLEWEB_COMMIT}.tar.gz -> Simple-Web-Server.tar.gz
	https://github.com/michaeltyson/TPCircularBuffer/archive/${CIRCULAR_COMMIT}.tar.gz -> TPCircularBuffer.tar.gz
	https://github.com/ViGEm/ViGEmClient/archive/${VIGEM_COMMIT}.tar.gz -> ViGEmClient.tar.gz
	https://github.com/LizardByte/build-deps/archive/${FFMPEG_COMMIT}.tar.gz -> ffmpeg-linux-x86_64.tar.gz
	https://github.com/miniupnp/miniupnp/archive/${MINIUPNP_COMMIT}.tar.gz -> miniupnp.tar.gz
	https://github.com/moonlight-stream/moonlight-common-c/archive/${MOONLIGHT_COMMIT}.tar.gz -> moonlight-common-c.tar.gz
	https://github.com/cgutman/enet/archive/${ENET_COMMIT}.tar.gz -> enet.tar.gz
	https://github.com/sleepybishop/nanors/archive/${NANORS_COMMIT}.tar.gz -> nanors.tar.gz
	https://github.com/FFmpeg/nv-codec-headers/archive/${NVCODEC_COMMIT}.tar.gz -> nv-codec-headers.tar.gz
	https://github.com/dmikushin/tray/archive/${TRAY_COMMIT}.tar.gz -> tray.tar.gz
"

NODE_PACKAGES="
	https://registry.npmjs.org/@fortawesome/fontawesome-free/-/fontawesome-free-6.4.0.tgz -> fontawesome-free.tgz
	https://registry.npmjs.org/@popperjs/core/-/core-2.11.8.tgz -> core.tgz
	https://registry.npmjs.org/bootstrap/-/bootstrap-5.2.3.tgz -> bootstrap.tgz
	https://registry.npmjs.org/vue/-/vue-2.6.12.tgz -> vue.tgz
"

SRC_URI="
	https://github.com/LizardByte/Sunshine/archive/${SUNSHINE_COMMIT}.tar.gz -> ${P}.tar.gz
	${SUBMODULES}
	${NODE_PACKAGES}
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/boost-1.82.0
	>=sys-libs/libcap-2.69
	>=net-misc/curl-8.0.1
	>=dev-libs/libappindicator-12.10
	>=x11-libs/libdrm-2.4.115
	>=dev-libs/libevdev-1.13.1
	>=media-libs/libva-2.18.0
	>=x11-libs/libvdpau-1.5
	>=x11-libs/libX11-1.8.4
	>=x11-libs/libxcb-1.15
	>=x11-libs/libXcursor-1.2.1
	>=x11-libs/libXfixes-6.0.1
	>=x11-libs/libXi-1.8.1
	>=x11-libs/libXinerama-1.1.5
	>=x11-libs/libXrandr-1.5.3
	>=x11-libs/libXtst-1.2.4
	>=media-libs/mesa-23.0.3
	>=sys-process/numactl-2.0.16
	>=dev-libs/openssl-3.0.9
	>=media-libs/opus-1.3.1
	>=media-sound/pulseaudio-16.1
	>=media-libs/intel-mediasdk-23.2.2
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-util/cmake-3.26.4
	>=net-libs/nodejs-20.2.0
"

src_unpack() {
	unpack ${P}.tar.gz
	mv Sunshine-${PV} ${P}

	unpack Simple-Web-Server.tar.gz
	mv -T Simple-Web-Server-${SIMPLEWEB_COMMIT} ${P}/third-party/Simple-Web-Server
	unpack TPCircularBuffer.tar.gz
	mv -T TPCircularBuffer-${CIRCULAR_COMMIT} ${P}/third-party/TPCircularBuffer
	unpack ViGEmClient.tar.gz
	mv -T ViGEmClient-${VIGEM_COMMIT} ${P}/third-party/ViGEmClient
	unpack ffmpeg-linux-x86_64.tar.gz
	mv -T build-deps-${FFMPEG_COMMIT} ${P}/third-party/ffmpeg-linux-x86_64
	unpack miniupnp.tar.gz
	mv -T miniupnp-${MINIUPNP_COMMIT} ${P}/third-party/miniupnp
	unpack moonlight-common-c.tar.gz
	mv -T moonlight-common-c-${MOONLIGHT_COMMIT} ${P}/third-party/moonlight-common-c
	unpack enet.tar.gz
	mv -T enet-${ENET_COMMIT} ${P}/third-party/moonlight-common-c/enet
	unpack nanors.tar.gz
	mv -T nanors-${NANORS_COMMIT} ${P}/third-party/nanors
	unpack nv-codec-headers.tar.gz
	mv -T nv-codec-headers-${NVCODEC_COMMIT} ${P}/third-party/nv-codec-headers
	unpack tray.tar.gz
	mv -T tray-${TRAY_COMMIT} ${P}/third-party/tray

	mkdir -p ${P}/node_modules/{@fortawesome,@popperjs}

	unpack fontawesome-free.tgz
	mv package ${P}/node_modules/@fortawesome/fontawesome-free
	unpack core.tgz
	mv package ${P}/node_modules/@popperjs/core
	unpack bootstrap.tgz
	mv package ${P}/node_modules/bootstrap
	unpack vue.tgz
	mv package ${P}/node_modules/vue
}

src_configure() {
	local mycmakeargs=(
		-DSUNSHINE_ASSETS_DIR="share/sunshine"
	)
	cmake_src_configure
}

pkg_postinst() {
	fcaps cap_sys_admin /usr/bin/${P}
	udev_reload
	elog "Use net-dns/avahi to enable discoverability"
	elog "Sunshine uses several ports to function:"
	elog "TCP: 47984,47989,48010"
	elog "\tOptionally 47990 for the web panel"
	elog "UDP: 47998,47999,48000,48002"
}

pkg_postrm() {
	udev_reload
}
