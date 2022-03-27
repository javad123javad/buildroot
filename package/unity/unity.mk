################################################################################
#
# UNITY Testing Framework
#
################################################################################

UNITY_VERSION = b9e9268d92e5339e8cdd251c880429ce30ff7a11
UNITY_SITE = https://github.com/ThrowTheSwitch/Unity.git
UNITY_SITE_METHOD = git
UNITY_INSTALL_STAGING = YES
UNITY_INSTALL_TARGET = NO
UNITY_CONF_OPTS = -DBUILD_DEMOS=ON
UNITY_DEPENDENCIES = host-pkgconf

$(eval $(cmake-package))
