include $(THEOS)/makefiles/common.mk
ARCHS=arm64 arm64e

BUNDLE_NAME = quitAllPrefs

quitAllPrefs_FILES = qapRootListController.m zodiacs.m
quitAllPrefs_INSTALL_PATH = /Library/PreferenceBundles
quitAllPrefs_FRAMEWORKS = UIKit
quitAllPrefs_PRIVATE_FRAMEWORKS = Preferences
quitAllPrefs_CFLAGS = -fobjc-arc
quitAllPrefs_EXTRA_FRAMEWORKS = CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/quitAllPrefs.plist$(ECHO_END)
