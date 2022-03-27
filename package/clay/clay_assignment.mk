################################################################################
#
# CLAY Assignment
#
################################################################################

CLAY_VERSION = 194d4384ffc1458d98eb38f2ebeb48bdd994df15
CLAY_SITE = https://github.com/javad123javad/em_param_server.git
CLAY_SITE_METHOD = git
CLAY_INSTALL_STAGING = YES
CLAY_INSTALL_TARGET = YES 
CLAY_CONF_OPTS = -DBUILD_DEMOS=ON
CALY_DEPENDENCIES = libal host-pkgconf

define EMBEDDEDINN_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/Clay_Assignment  $(TARGET_DIR)/usr/bin
endef
$(eval $(cmake-package))
