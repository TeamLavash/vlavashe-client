import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.1

Pane {
    id: profilePage
    width: parent.width
    height: parent.height

    Column {
        id: column1

        width: profilePage.availableWidth * 0.7
        height: profilePage.availableHeight / 8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: photo.bottom
        anchors.topMargin: 50
        spacing: 20

        Text {
            id: text1

            text: qsTr("ФИО")
            anchors.left: parent.left
            anchors.leftMargin: 0
            font.pixelSize: 14
        }

        Text {
            id: text2

            text: qsTr("Статус")
            anchors.left: parent.left
            anchors.leftMargin: 0
            font.pixelSize: 14
        }
    }

    Image {
        id: photo
        width: profilePage.availableWidth / 4
        height: profilePage.availableWidth / 4
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        source: "qrc:/images/user.png"   //user photo
    }

    Button {
        id: buttonSignOut
        width: profilePage.availableWidth / 2
        height: profilePage.availableHeight / 8
        text: qsTr("Удалить учётную запись")
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

    }
}
