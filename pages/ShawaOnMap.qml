import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.1

Pane {
	id: paneMap

	width: parent.width
	height: parent.height
	property alias button1: button1

	Item {
		id: item2
		width: parent.width * 0.9
		height: parent.height / 4
		anchors.verticalCenterOffset: 100
		anchors.verticalCenter: parent.verticalCenter
		anchors.horizontalCenter: parent.horizontalCenter
		Text {
			id: text4
			width: parent.width * 0.5
			height: parent.height / 4
			text: qsTr("Название")
			horizontalAlignment: Text.AlignHCenter
			font.bold: true
			verticalAlignment: Text.AlignVCenter
			anchors.left: image2.right
			anchors.leftMargin: 5
			anchors.top: parent.top
			anchors.topMargin: 5
			font.pixelSize: 14
		}

		Text {
			id: text5
			width: parent.width * 0.5
			height: parent.height / 4
			text: qsTr("Адрес")
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			anchors.top: text4.bottom
			anchors.topMargin: 5
			anchors.left: image2.right
			anchors.leftMargin: 5
			font.pixelSize: 14
		}

		Text {
			id: text6
			width: parent.width / 4
			height: parent.height * 0.15
			text: qsTr("Рейтинг 7.5 / 10")
			anchors.left: parent.left
			anchors.leftMargin: 10
			anchors.top: image2.bottom
			anchors.topMargin: 5
			font.pixelSize: 12
		}

		Image {
			id: image2

			width: parent.height * 0.6
			height: parent.height * 0.6
			anchors.left: parent.left
			anchors.leftMargin: 10
			source: "qrc:/images/shawa.png"
		}

		Button {
			id: button1
			width: flickable.width * 0.1
			height: textField1.height * 0.9
			text: qsTr("Подробнее")
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 0
			anchors.right: parent.right
			anchors.rightMargin: 0
		}
	}
}


