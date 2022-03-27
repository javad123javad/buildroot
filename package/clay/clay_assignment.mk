################################################################################
#
# CLAY Assignment
#
################################################################################

CLAY_VERSION = 46fc4388354ba735c5a51db7a6e35e1afe25f630
CLAY_SITE = https://github.com/javad123javad/em_param_server.git
CLAY_SITE_METHOD = git
CLAY_INSTALL_STAGING = YES
CLAY_INSTALL_TARGET = NO
CLAY_CONF_OPTS = -DBUILD_DEMOS=ON
CALY_DEPENDENCIES = libal host-pkgconf

$(eval $(cmake-package))
