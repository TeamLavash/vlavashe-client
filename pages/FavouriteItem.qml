import QtQuick 2.6
import QtQuick.Controls 2.0

Item {
	id: favouriteItem

	width: parent.width
	height: image.height

	property alias nameText: nameText
	property alias addressText: addressText
	property alias priceText: priceText

	Row {
		Image {
			id: image

			height: parent.height
			fillMode: Image.PreserveAspectFit
			source: "qrc:/images/shawa.png"
		}

		Column {
			id: infoColumn
			spacing: 30

			Text {
				id: nameText

				text: "Unknown name"
				font.pixelSize: 18

				function setText(txt) {
					nameText.text = txt
				}
			}

			Text {
				id: addressText

				text: "Unknown address"
				font.pixelSize: 12

				function setText(txt) {
					addressText.text = txt
				}
			}

			Text {
				id: priceText

				text: "Unknown price"
				font.pixelSize: 12

				function setText(txt) {
					priceText.text = "Стоимость обычной в лаваше: " + txt
				}
			}
		}
	}

	MouseArea {
		id: favouriteItemMouseArea
		anchors.fill: parent

		onClicked: {
			print("More activated on " + itemId.toString())
			moreActivated(itemId)
		}
	}

	property int itemId: -1

	function setId(id) {
		itemId = id
	}

	function setInfo(name, price, address) {
		nameText.setText(name)
		addressText.setText(address)
		priceText.setText(price)
	}

	function activate() {
		print("More activated on " + itemId.toString())
		moreActivated(itemId)
	}

	signal moreActivated(int id)
}
