ARCHS=arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = QuitAll

QuitAll_FILES = Tweak.xm
QuitAll_CFLAGS = -fobjc-arc
QuitAll_EXTRA_FRAMEWORKS += Cephei

SUBPROJECTS += quitallprefs

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
