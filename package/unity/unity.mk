################################################################################
#
# UNITY Testing Framework
#
################################################################################

UNITY_VERSION = b9e9268d92e5339e8cdd251c880429ce30ff7a11
UNITY_SITE = https://github.com/ThrowTheSwitch/Unity.git
UNITY_SITE_METHOD = git
UNITY_INSTALL_TARGET = YES
UNITY_CONF_OPTS = -DBUILD_DEMOS=ON
UNITY_DEPENDENCIES = host-pkgconf
UNITY_INSTALL_STAGING = YES

#define UNITY_INSTALL_TARGET_CMDS
# $(INSTALL) -m 0755 -D $(@D)/libunity.a $(TARGET_DIR)/usr/bin/fbgrab
#endef
$(eval $(cmake-package))

