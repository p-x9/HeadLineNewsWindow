TARGET := iphone:clang:14.5:13.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = HeadLineNewsWindow

HeadLineNewsWindow_FILES = $(shell find Sources/HeadLineNewsWindow -name '*.swift') $(shell find Sources/HeadLineNewsWindowC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')

$(BUNDLE_NAME)_FRAMEWORKS = UIKit CoreGraphics
$(BUNDLE_NAME)_PRIVATE_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS = Cephei CepheiPrefs
HeadLineNewsWindow_INSTALL_PATH = /Library/PreferenceBundles
HeadLineNewsWindow_SWIFTFLAGS = -ISources/HeadLineNewsWindowC/include -I.sparkcolorheaders
HeadLineNewsWindow_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
