##############################################################
#
# AESD-CHAR-DRIVER
#
##############################################################

AESD_CHAR_DRIVER_VERSION = 'db90ef3fc409d7abac0bfa53c0efd5e3a2ecd1eb'
AESD_CHAR_DRIVER_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-vash6799.git'
AESD_CHAR_DRIVER_SITE_METHOD = git
AESD_CHAR_DRIVER_GIT_SUBMODULES = YES

# This points the kernel-module macro to the specific directory in your repo
AESD_CHAR_DRIVER_MODULE_SUBDIRS = aesd-char-driver

define AESD_CHAR_DRIVER_INSTALL_TARGET_CMDS
	# Install the driver load and unload scripts to /usr/bin
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/bin/
endef

# Evaluate the kernel module and generic package macros
$(eval $(kernel-module))
$(eval $(generic-package))
