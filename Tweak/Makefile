INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS=arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = QuitAll


QuitAll_FILES = Tweak.xm quitm.x
QuitAll_CFLAGS = -fobjc-arc
QuitAll_EXTRA_FRAMEWORKS += Cephei
QuitAll_LIBRARIES = sparkapplist 

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += quitallprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
