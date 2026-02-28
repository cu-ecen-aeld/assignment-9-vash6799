#   git rev-parse HEAD
LDD_VERSION = 6559cdaad15517e566c3af053c46b67493a8bc6d

LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-vash6799.git
LDD_SITE_METHOD = git

LDD_LICENSE = GPL-2.0
LDD_LICENSE_FILES = COPYING

LDD_MODULE_SUBDIRS = misc-modules scull

$(eval $(kernel-module))
$(eval $(generic-package))
