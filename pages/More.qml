import QtQuick 2.6
import QtQuick.Controls 2.0

Flickable {
	id: flickable

	contentHeight: column.height
	boundsBehavior: Flickable.StopAtBounds

//	property alias comments: comments

	Column {
		id: column

		anchors.horizontalCenter: parent.horizontalCenter

		spacing: 20

		Label {
			id: nameLabel

			width: parent.width

			anchors.horizontalCenter: parent.horizontalCenter

			text: qsTr("Unknown name")
			font.pointSize: 18
			font.bold: true
			horizontalAlignment: Qt.AlignHCenter
		}

		Label {
			id: addressLabel

			width: parent.width

			anchors.horizontalCenter: parent.horizontalCenter

			text: qsTr("Unknown address")
			font.pointSize: 14
			font.bold: true
			horizontalAlignment: Qt.AlignHCenter
		}

		Image {
			id: photo

			height: parent.height * 0.25

			anchors.horizontalCenter: parent.horizontalCenter

			source: "qrc:/images/camera.png"
			fillMode: Image.PreserveAspectFit
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter

			Label {
				id: sizeRatingLabel
				text: qsTr("Размер: ")
			}

			Label {
				id: sizeRatingValueLabel
				text: qsTr("Unknown rating")
			}
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter

			Label {
				id: cleanRatingLabel
				text: qsTr("Чистота: ")
			}

			Label {
				id: cleanRatingValueLabel
				text: qsTr("Unknown rating")
			}
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter

			Label {
				id: conditionRatingLabel
				text: qsTr("Обстановка: ")
			}

			Label {
				id: conditionRatingValueLabel
				text: qsTr("Unknown rating")
			}
		}

		Row {
			id: priceRow

			anchors.horizontalCenter: parent.horizontalCenter

			Label {
				id: priceLabel
				text: qsTr("Стоимость обычной в лаваше: ")
			}

			Label {
				id: priceValueLabel
				text: qsTr("Unknown price")
			}
		}

//		CommentWidget {
//			id: comments

//			anchors.top: priceRow.bottom
//			anchors.topMargin: 30
//		}
	}
}
