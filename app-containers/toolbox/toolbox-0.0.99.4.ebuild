# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://github.com/containers/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-lang/go
	dev-go/go-md2man
"
RDEPEND="${DEPEND}"
BDEPEND=""
