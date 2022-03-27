################################################################################
#
# ALLIB
#
################################################################################

ALLIB_VERSION = 9e23c51e7ed9219bad98b7e105efa881a12892a3
#ALLIB_SOURCE = libfoo-$(ALLIB_VERSION).tar.gz
ALLIB_SITE = https://github.com/javad123javad/ALlib.git
ALLIB_SITE_METHOD = git
ALLIB_INSTALL_STAGING = YES
ALLIB_INSTALL_TARGET = YES
ALLIB_CONF_OPTS = -DBUILD_DEMOS=ON
ALLIB_DEPENDENCIES = host-pkgconf

$(eval $(cmake-package))
