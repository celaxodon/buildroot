################################################################################
#
# quickjs
#
################################################################################

QUICKJS_VERSION = 2020-11-08
QUICKJS_SOURCE = quickjs-$(QUICKJS_VERSION).tar.xz
QUICKJS_SITE = https://bellard.org/quickjs
QUICKJS_LICENSE = MIT
QUICKJS_INSTALL_STAGING = YES

define QUICKJS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		CROSS_PREFIX="$(TARGET_CROSS)" \
		all
endef

define QUICKJS_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		CROSS_PREFIX="$(TARGET_CROSS)" \
		DESTDIR=$(STAGING_DIR) \
		STRIP=/bin/true \
		prefix=/usr \
		install
endef

define QUICKJS_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		CROSS_PREFIX="$(TARGET_CROSS)" \
		DESTDIR=$(TARGET_DIR) \
		STRIP=/bin/true \
		prefix=/usr \
		install
endef

$(eval $(generic-package))
