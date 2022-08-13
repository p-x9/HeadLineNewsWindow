DEBUG = 1
GO_EASY_ON_ME := 1

ARCHS = arm64 arm64e
TARGET := iphone:clang:14.5:13.0
THEOS_DEVICE_IP = 192.168.0.15 -p 22

INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HeadlineNewsWindow

HeadlineNewsWindow_FILES = $(shell find Sources/HeadlineNewsWindow -name '*.swift') $(shell find Sources/HeadlineNewsWindowC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
HeadlineNewsWindow_SWIFTFLAGS = -ISources/HeadlineNewsWindowC/include
HeadlineNewsWindow_CFLAGS = -fobjc-arc -ISources/HeadlineNewsWindowC/include

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += headlinenewswindow
include $(THEOS_MAKE_PATH)/aggregate.mk
