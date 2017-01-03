import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.1

Pane {
    id: profilePage
    width: parent.width
    height: parent.height

	Column {
		id: column

		anchors.horizontalCenter: parent.horizontalCenter

		spacing: 20

		Image {
			id: image

			width: parent.width * 0.5
			height: parent.height * 0.5

			anchors.horizontalCenter: parent.horizontalCenter

			source: "qrc:/images/user.png"
			fillMode: Image.PreserveAspectFit
		}

		Text {
			id: nameText

			anchors.horizontalCenter: parent.horizontalCenter

			text: qsTr("Unknown name")
			font.pixelSize: 14
		}

		Text {
			id: statusText

			anchors.horizontalCenter: parent.horizontalCenter

			text: qsTr("Unknown status")
			font.pixelSize: 14
		}

		Button {
			id: signDownButton

			anchors.horizontalCenter: parent.horizontalCenter

			text: qsTr("Выйти")
		}
	}
}
