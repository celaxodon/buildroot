################################################################################
#
# edid-decode
#
################################################################################

EDID_DECODE_VERSION = 188950472c19492547e298b27f9da0d72cf826df
EDID_DECODE_SITE = git://linuxtv.org/edid-decode.git
EDID_DECODE_LICENSE = MIT
EDID_DECODE_LICENSE_FILES = LICENSE

define EDID_DECODE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		CXX="$(TARGET_CXX) $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)"
endef

define EDID_DECODE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR="$(TARGET_DIR)" install
endef

$(eval $(generic-package))
