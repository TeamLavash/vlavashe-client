import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.1

Pane {
    id: pane
    width: parent.width
    height: parent.height

    Image {
        id: shawa
        width: pane.availableWidth * 0.3
        height: pane.availableHeight * 0.3
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/shawa.png"
    }
    Column {
        id: column1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: shawa.bottom
        anchors.topMargin: 100
        spacing: 40


        TextField {
            id: fieldLogin
            placeholderText: "Логин"
            width: Math.max(implicitWidth, Math.min(implicitWidth * 2, pane.availableWidth / 3))
            anchors.top: fieldMail.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
        TextField {
            id: fieldPassword
            placeholderText: "Пароль"
            width: Math.max(implicitWidth, Math.min(implicitWidth * 2, pane.availableWidth / 3))
            anchors.top: fieldLogin.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }



    Button {
        id: buttonSignIn
        x: 0
        y: 0
        width: pane.availableWidth / 2
        height: pane.availableHeight / 8
        text: qsTr("Войти")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }


}
