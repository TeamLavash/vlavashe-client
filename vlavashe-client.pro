TEMPLATE = app

QT += qml quick sql
CONFIG += c++11

SOURCES += \
    Main.cpp \
    Shawarma.cpp \
    SQLiteDataBase.cpp \
    App.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

GIT_VERSION = $$system(git describe --always)

DEFINES += GIT_VERSION=\\\"$$GIT_VERSION\\\"

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    DataBase.hpp \
    Shawarma.hpp \
    User.hpp \
    SQLiteDataBase.hpp \
    App.hpp
