import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.1

Pane {
    id: pane
    width: parent.width
    height: parent.height

    Column {
        id: column1
        height: parent.height * 0.55
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: butonSelectPhoto.bottom
        anchors.topMargin: 20
        spacing: 20

        TextField {
            id: fieldName
            placeholderText: "Имя"
            width: Math.max(implicitWidth, Math.min(implicitWidth * 2, pane.availableWidth / 3))
            anchors.horizontalCenter: parent.horizontalCenter
        }
        TextField {
            id: fieldSurname
            placeholderText: "Фамилия"
            width: Math.max(implicitWidth, Math.min(implicitWidth * 2, pane.availableWidth / 3))
            anchors.top: fieldName.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
        TextField {
            id: fieldMail
            placeholderText: "E-mail"
            width: Math.max(implicitWidth, Math.min(implicitWidth * 2, pane.availableWidth / 3))
            anchors.top: fieldSurname.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
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
        TextField {
            id: fieldConfirm
            placeholderText: "Подтвердите пароль"
            width: Math.max(implicitWidth, Math.min(implicitWidth * 2, pane.availableWidth / 3))
            anchors.top: fieldPassword.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Button {
        id: butonSelectPhoto
        width: pane.availableWidth / 4
        height: pane.availableHeight / 4
        text: qsTr("Выберите фото")
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

    }

    Button {
        id: buttonSignIn
        x: 0
        width: pane.availableWidth / 2
         height: parent.height * 0.1
        text: qsTr("Зарегистрироваться")
        anchors.top: column1.bottom
        anchors.topMargin: 20
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }


}
