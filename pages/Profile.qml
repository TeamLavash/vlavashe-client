import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.1
import UserEnum 1.0

Pane {
    id: profilePage
    width: parent.width
    height: parent.height

	property alias logoutButton: logoutButton

	Column {
		id: column

		width: parent.width * 0.5

		anchors.horizontalCenter: parent.horizontalCenter

		spacing: 20

		Rectangle {
			width: parent.width * 0.5
			height: width

			anchors.horizontalCenter: parent.horizontalCenter

			border.color: "black"
			border.width: 1

			Image {
				id: image

				width: parent.width - 2
				height: parent.height - 2

				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter

				source: "qrc:/images/user.png"
				fillMode: Image.PreserveAspectFit
			}
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
			id: logoutButton

			anchors.horizontalCenter: parent.horizontalCenter

			text: qsTr("Выйти")
		}
	}

	function setData(data) {
		nameText.text = data.name
		if (data.status == User.USER) {
			statusText.text = "User"
		} else {
			statusText.text = "Admin"
		}
	}
}
