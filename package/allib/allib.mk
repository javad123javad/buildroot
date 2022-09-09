################################################################################
#
# ALLIB
#
################################################################################

ALLIB_VERSION = 9e23c51e7ed9219bad98b7e105efa881a12892a3
ALLIB_SITE = https://github.com/javad123javad/ALlib.git
ALLIB_SITE_METHOD = git
ALLIB_INSTALL_TARGET = YES
ALLIB_CONF_OPTS = -DBUILD_DEMOS=ON
ALLIB_DEPENDENCIES = host-pkgconf
ALLIB_INSTALL_STAGING = YES

define ALLIB_INSTALL_STAGING_CMDS
     $(INSTALL) -D -m 0644 $(@D)/include/al.h $(STAGING_DIR)/usr/include/al.h
     $(INSTALL) -D -m 0755 $(@D)/libal.so* $(STAGING_DIR)/usr/lib
endef
$(eval $(cmake-package))
