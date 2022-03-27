################################################################################
#
# CLAY Assignment
#
################################################################################

CLAY_VERSION = 46fc4388354ba735c5a51db7a6e35e1afe25f630 #194d4384ffc1458d98eb38f2ebeb48bdd994df15
CLAY_SITE = https://github.com/javad123javad/em_param_server.git
CLAY_SITE_METHOD = git
CLAY_INSTALL_STAGING = YES 
CLAY_INSTALL_TARGET = YES 
CLAY_CONF_OPTS = -DBUILD_DEMOS=ON
#CLAY_DEPENDENCIES = allib  host-pkgconf

define CLAY_INSTALL_STAGING_CMDS
    $(INSTALL) -D -m 0755 $(@D)/Clay_Assignment  $(TARGET_DIR)/usr/bin/Clay_Assignment
endef
#define CLAY_INSTALL_TARGET_CMDS
#    $(INSTALL) -D -m 0755 $(@D)/Clay_Assignment  $(TARGET_DIR)/usr/bin/Clay_Assignment

#endef
$(eval $(cmake-package))
