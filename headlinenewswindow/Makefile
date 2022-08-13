TARGET := iphone:clang:latest:12.2

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = HeadLineNewsWindow

HeadLineNewsWindow_FILES = $(shell find Sources/HeadLineNewsWindow -name '*.swift') $(shell find Sources/HeadLineNewsWindowC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
HeadLineNewsWindow_INSTALL_PATH = /Library/PreferenceBundles
HeadLineNewsWindow_SWIFTFLAGS = -ISources/HeadLineNewsWindowC/include
HeadLineNewsWindow_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
