TEMPLATE = app

QT += quickcontrols2
CONFIG += c++11

SOURCES += main.cpp

OTHER_FILES += \
    pages/*.qml

RESOURCES += qml.qrc


# Additional import path used to resolve QML modules in Qt Creator's code model

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

FORMS +=

HEADERS +=

DISTFILES += \
    pages/FavouritePage.qml \
    pages/ShawaOnMap.qml \
    pages/SignIn.qml \
    pages/SignUpSignIn.qml \
    pages/More.qml \
    GuiState.qml \
    pages/FavouritePageItem.qml \
    AddShawarmaInfo.qml \
    Marker.qml \
    pages/ShawarmaMap.qml \
    struct/AddShawarmaInfo.qml \
    struct/GuiState.qml \
    pages/Profile.qml \
    pages/SignUp.qml \
    struct/SignUpData.qml
