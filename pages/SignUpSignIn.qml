import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.1

Pane {
    id: pane
    width: parent.width
    height: parent.height

	property alias signUpButton: signUpButton
	property alias signInButton: signInButton

	Column {
		id: columns
		spacing: 50
		anchors.horizontalCenter: parent.horizontalCenter

		Image {
			id: photo

			width: pane.availableWidth / 4
			height: pane.availableHeight / 4
			anchors.horizontalCenter: parent.horizontalCenter

			source: "qrc:/images/shawa.png"
			fillMode: Image.PreserveAspectFit
		}

		Button {
			id: signUpButton

			width: pane.availableWidth / 2
			anchors.horizontalCenter: parent.horizontalCenter

			text: qsTr("Зарегистрироваться")
		}

		Button {
			id: signInButton

			width: pane.availableWidth / 2
			anchors.horizontalCenter: parent.horizontalCenter

			text: qsTr("Войти")
		}
	}
}
