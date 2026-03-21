##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

AESD_ASSIGNMENTS_VERSION = 'd26fa2eda0c40153838b81095e66e8d36a8b9a05'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-vash6799.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

# Tell Buildroot's kernel module infrastructure where your driver code is
AESD_ASSIGNMENTS_MODULE_SUBDIRS = aesd-char-driver

define AESD_ASSIGNMENTS_BUILD_CMDS
        $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
        $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server clean
        $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
        # Create target directories
        $(INSTALL) -d 0755 $(TARGET_DIR)/usr/bin
        $(INSTALL) -d 0755 $(TARGET_DIR)/etc/finder-app/conf

        # Install config files
        $(INSTALL) -m 0644 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/

        # Install scripts
        $(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/
        $(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/

        # Install writer binary
        $(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/

        # Install the executable to /usr/bin
        $(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/
        
        # Install the socket init script to /etc/init.d/ with the S99 prefix
	$(INSTALL) -m 0755 $(@D)/server/S99aesdsocket $(TARGET_DIR)/etc/init.d/S99aesdsocket

        # Install the driver load and unload scripts to /usr/bin
        $(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/usr/bin/
        $(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/bin/
endef

# The kernel-module macro automatically handles compiling aesdchar.ko 
# against the QEMU kernel and installing it into /lib/modules/
$(eval $(kernel-module))
$(eval $(generic-package))
