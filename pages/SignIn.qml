import QtQuick 2.6
import QtQuick.Controls 2.0

Pane {
    id: pane
    width: parent.width
    height: parent.height

	property alias signInButton: signInButton

	property var signInData: {
		"name": "",
		"password": ""
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
				signInData.name = text
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

		Label {
			id: resultLabel

			anchors.horizontalCenter: parent.horizontalCenter

			horizontalAlignment: Text.AlignHCenter

			opacity: 0.0
			SequentialAnimation {
				id: resultAnimation
				running: false
				NumberAnimation { target: resultLabel; property: "opacity"; to: 1.0; duration: 1000 }
			}
		}
	}

	function validate() {
		var err = ""
		var res = true

		if (signInData.name == "") {
			err += "Имя не указано.\n"
			res = false
		}
		if (signInData.password == "") {
			err += "Пароль не указан.\n"
			res = false
		}

		setResult(err)
		return res
	}

	function reset() {
		loginField.text = ""
		passwordField.text = ""
		resultLabel.text = ""
	}

	function setResult(result) {
		resultAnimation.stop()
		resultLabel.opacity = 0.0
		resultLabel.text = result
		resultAnimation.start()
	}

	function getData() {
		return JSON.stringify(signInData)
	}
}
