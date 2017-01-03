import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import "qrc:/struct"

Pane {
	id: pane
	width: parent.width
	height: parent.height

	property alias signUpData: signUpData
	property alias signUpButton: signUpButton

	SignUpData {
		id: signUpData
	}

	Column {
		id: column

		width: parent.width / 2
		spacing: 30

		anchors.horizontalCenter: parent.horizontalCenter

		Image {
			id: photoButton

			width: parent.width

			anchors.horizontalCenter: parent.horizontalCenter

			source: "qrc:/images//camera.png"
			fillMode: Image.PreserveAspectFit

			MouseArea {
				id: photoButtonMouseArea

				anchors.fill: parent

				onClicked: {
					print("Photo button clicked")
				}
			}
		}

		TextField {
			id: nameField

			width: parent.width

			placeholderText: "Имя"

			onTextChanged:
				signUpData.name = text
		}

		TextField {
			id: emailField

			width: parent.width

			placeholderText: "E-mail"

			onTextChanged: {
				signUpData.email = text
			}
		}

		TextField {
			id: passwordField

			width: parent.width

			placeholderText: "Пароль"
			echoMode: TextInput.PasswordEchoOnEdit

			onTextChanged: {
				signUpData.password = text
			}
		}

		TextField {
			id: checkPasswordField

			width: parent.width

			placeholderText: "Повторите пароль"
			echoMode: TextInput.PasswordEchoOnEdit

			onTextChanged: {
				signUpData.checkPassword = text
			}
		}

		Button {
			id: signUpButton

			anchors.horizontalCenter: parent.horizontalCenter

			text: qsTr("Зарегистрироваться")
		}
	}
}
