TEMPLATE = app

QT += core qml quick
CONFIG += c++11

SOURCES += main.cpp \
    logviewmodel.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../build-libImageResizer-Desktop_Qt_5_6_0_MSVC2015_32bit-Release/release/ -llibImageResizer
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../build-libImageResizer-Desktop_Qt_5_6_0_MSVC2015_32bit-Release/release/ -llibImageResizerd
else:unix:!macx: LIBS += -L$$PWD/../build-libImageResizer-Desktop_Qt_5_6_0_MSVC2015_32bit-Release/release/ -llibImageResizer

INCLUDEPATH += $$PWD/../libImageResizer
DEPENDPATH += $$PWD/../build-libImageResizer-Desktop_Qt_5_6_0_MSVC2015_32bit-Release/release

HEADERS += \
    logviewmodel.h
