TEMPLATE = app

QT += quickcontrols2
CONFIG += c++11

SOURCES += main.cpp \
    App.cpp \
    User.cpp \
    ServerApi.cpp

OTHER_FILES += \
    pages/*.qml

RESOURCES += qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

FORMS +=

HEADERS += \
    App.hpp \
    Types.hpp \
    User.hpp \
    ServerApi.hpp

DISTFILES += \
    pages/FavouritePage.qml \
    pages/ShawaOnMap.qml \
    pages/SignIn.qml \
    pages/SignUpSignIn.qml \
    pages/More.qml \
    pages/FavouritePageItem.qml \
    AddShawarmaInfo.qml \
    Marker.qml \
    pages/ShawarmaMap.qml \
    pages/Profile.qml \
    pages/SignUp.qml \
    CheckMarker.qml \
    SelectMarker.qml \
