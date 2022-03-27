################################################################################
#
# CLAY Assignment
#
################################################################################

CLAY2_VERSION = 1.0 
CLAY2_SITE = ./package/clay2/src
CLAY2_SITE_METHOD = local
#CLAY_INSTALL_STAGING = YES
#CLAY_INSTALL_TARGET = YES 
CLAY2_AUTORECONF = YES
CLAY2_LICENSE = GPL-3.0+
CLAY2_LICENSE_FILES = COPYING
CLAY2_CPE_ID_VENDOR = gnu
#CLAY2_INSTALL_STAGING = YES
CLAY2_INSTALL_TARGET = YES

define CLAY2_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/src/Clay_Assignment  $(TARGET_DIR)/usr/bin
endef
$(eval $(autotools-package))

