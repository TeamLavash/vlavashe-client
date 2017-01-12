import QtQuick 2.6
import QtQuick.Controls 2.0

Flickable {
	id: flickable

	contentHeight: column.height
	boundsBehavior: Flickable.StopAtBounds

	property alias favouriteButton: favouriteButton
	property alias commentButton: commentButton
	property alias onMapButton: onMapButton
	property var info

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
				id: ratingLabel
				text: qsTr("Рейтинг: ")
			}

			Label {
				id: ratingValueLabel
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

		Button {
			id: favouriteButton

			width: parent.width * 0.2
			height: width

			anchors.horizontalCenter: parent.horizontalCenter

			background: Image {
				id: buttonImage
				source: "qrc:/images/favourite_disabled.png"
				anchors.left: favouriteButton.left
				anchors.right: favouriteButton.right
				anchors.top: favouriteButton.top
				anchors.bottom: favouriteButton.bottom

				fillMode: Image.PreserveAspectFit
			}
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter

			spacing: 50

			Button {
				id: commentButton

				text: qsTr("Отзывы")
			}

			Button {
				id: onMapButton

				text: qsTr("На карте")
			}
		}
	}

	function isFavourite() {
		return info.favourite
	}

	function setData(data) {
		info = data

		nameLabel.text = data.name
		addressLabel.text = data.road + ", " + data.house
		ratingValueLabel.text = data.rating.toString()
		priceValueLabel.text = data.price.toString()

		setState(data.favourite)
	}

	function setState(enable) {
		if (enable) {
			buttonImage.source = "qrc:/images/favourite_enabled.png"
			info.favourite = true
		} else {
			buttonImage.source = "qrc:/images/favourite_disabled.png"
			info.favourite = false
		}
	}
}
