import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1

Pane {
	id: pane
	width: parent.width
	height: parent.height

	property alias signUpButton: signUpButton

	property var signUpData: {
		"name": "",
		"email": "",
		"password": "",
		"checkPassword": ""
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

			onTextChanged: {
				signUpData.name = text
			}
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

		Label {
			id: resultLabel

			anchors.horizontalCenter: parent.horizontalCenter

			horizontalAlignment: Text.AlignHCenter

			SequentialAnimation {
				id: resultAnimation
				running: false
				NumberAnimation { target: resultLabel; property: "opacity"; from: 0.0; to: 1.0; duration: 1000 }
			}
		}
	}

	RegExpValidator { id: emailValidator; regExp:/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }

	function validate() {
		var err = ""
		var res = true

		if (signUpData.name == "") {
			err += "Имя не указано.\n"
			res = false
		}
		if (signUpData.email == "") {
			err += "Email не указан.\n"
			res = false
		} else {
			var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
			if (!re.test(signUpData.email)) {
				err += "Неверный формат email.\n"
				res = false
			}
		}
		if (signUpData.password == "" || signUpData.checkPassword == "") {
			err += "Пароль не указан.\n"
			res = false
		} else if (signUpData.password != signUpData.checkPassword) {
			err += "Пароли не совпадают.\n"
			res = false
		}

		setResult(err)
		return res
	}

	function reset() {
		nameField.text = ""
		emailField.text = ""
		passwordField.text = ""
		checkPasswordField.text = ""
		resultLabel.text = ""
	}

	function setResult(result) {
		resultAnimation.stop()
		resultLabel.opacity = 0.0
		resultLabel.text = result
		resultAnimation.start()
	}

	function getData() {
		var data = JSON.stringify(signUpData)
		return data
	}
}
