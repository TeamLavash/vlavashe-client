import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.1

Pane {
    id: pane
    width: parent.width
    height: parent.height

    Image {
        id: photo
        width: pane.availableWidth/4
        height: pane.availableWidth/4
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        source: "qrc:/images/shawa.png"   //user photo
    }

    property alias buttonSignIn: buttonSignIn
    Button {
        id: buttonSignIn
        width: pane.availableWidth / 2
        height: 77
        text: qsTr("Зарегистрироваться")
        anchors.top: photo.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
    }

    property alias buttonEnter: buttonEnter
    Button {
        id: buttonEnter
        width: pane.availableWidth / 2
        height: 77
        text: qsTr("Войти")
        anchors.top: buttonSignIn.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter

    }
}
