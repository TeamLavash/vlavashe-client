import QtQuick 2.6
import QtQuick.Controls 2.0
import "qrc:/struct"

Pane {
    id: pane
    width: parent.width
    height: parent.height

	property alias signInButton: signInButton
	property alias signInData: signInData

	SignInData {
		id: signInData
	}

	Column {
		id: column
		spacing: 50
		width: parent.width / 2
		anchors.horizontalCenter: parent.horizontalCenter

		TextField {
			id: loginField

			width: parent.width

			placeholderText: "Логин"

			onTextChanged: {
				signInData.login = text
			}
		}

		TextField {
			id: passwordField

			width: parent.width

			placeholderText: "Пароль"
			echoMode: TextInput.PasswordEchoOnEdit

			onTextChanged: {
				signInData.password = text
			}
		}

		Button {
			id: signInButton

			anchors.horizontalCenter: parent.horizontalCenter

			text: qsTr("Войти")
		}
	}
}
