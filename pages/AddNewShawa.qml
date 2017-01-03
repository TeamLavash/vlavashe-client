import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.1

import "qrc:/"
import "qrc:/struct"

Flickable {
	id: flickable

	contentHeight: pane.height
	boundsBehavior: Flickable.StopAtBounds

	AddShawarmaInfo {
		id: shawarmaInfo
		sizeRating: 0.5
		cleanRating: 0.5
		conditionRating: 0.5
		price: 120
	}

	Pane {
		id: pane

		width: flickable.width
		height: flickable.height
		spacing: 30

		Column {
			id: ratesColumns
			width: parent.width
			height: parent.height

			anchors.horizontalCenter: parent.horizontalCenter

			Image {
				id: photoImage

				width: 100
				height: 100

				source: "qrc:/images/camera.png"
				fillMode: Image.Pad

				anchors.horizontalCenter: parent.horizontalCenter

				MouseArea {
					id: photoImageMouseArea

					anchors.fill: parent

					onClicked: {
						print("Photo button clicked")
					}
				}
			}

			TextField {
				id: nameField

				placeholderText: qsTr("Название")
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter

				anchors.horizontalCenter: parent.horizontalCenter

				onTextChanged: {
					shawarmaInfo.name = nameField.text
				}
			}

			TextField {
				id: addressField

				width: parent.width / 2

				placeholderText: qsTr("Адрес")
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter

				anchors.horizontalCenter: parent.horizontalCenter

				onTextChanged: {
					shawarmaInfo.address = addressField.text
				}
			}

			Button {
				id: addressButton

				text: qsTr("На карте")

				anchors.horizontalCenter: parent.horizontalCenter

				onClicked: {
					// TODO call map interface
				}
			}

			Text {
				id: sizeText

				text: qsTr("Удовлетворенность размером")
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter

				anchors.horizontalCenter: parent.horizontalCenter
			}

			Slider {
				id: sizeSlider

				value: 0.5

				anchors.horizontalCenter: parent.horizontalCenter

				onValueChanged: {
					shawarmaInfo.sizeRating = sizeSlider.value
				}
			}

			Text {
				id: cleanText

				text: qsTr("Чистота производства")
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter

				anchors.horizontalCenter: parent.horizontalCenter
			}

			Slider {
				id: cleanSlider

				value: 0.5

				anchors.horizontalCenter: parent.horizontalCenter

				onValueChanged: {
					shawarmaInfo.cleanRating = cleanSlider.value
				}
			}

			Text {
				id: conditionText

				text: qsTr("Обстановка заведения")
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter

				anchors.horizontalCenter: parent.horizontalCenter
			}

			Slider {
				id: conditionSlider

				value: 0.5

				anchors.horizontalCenter: parent.horizontalCenter

				onValueChanged: {
					shawarmaInfo.conditionRating = conditionSlider.values
				}
			}

			Text {
				id: priceLabelText

				text: qsTr("Цена за обычную в лаваше")
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter

				anchors.horizontalCenter: parent.horizontalCenter
			}

			TextField {
				id: priceField

				text: qsTr("120")
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				validator: IntValidator { bottom: 0; top: 1000 }

				anchors.horizontalCenter: parent.horizontalCenter

				onTextChanged: {
					shawarmaInfo.price = parseInt(priceField.text)
				}
			}

			TextField {
				id: commentField

				width: parent.width / 2

				placeholderText: qsTr("Комментарий")
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter

				anchors.horizontalCenter: parent.horizontalCenter

				onTextChanged: {
					shawarmaInfo.comment = commentField.text
				}
			}

			Button {
				id: addButton

				text: qsTr("Добавить")

				anchors.horizontalCenter: parent.horizontalCenter

				onClicked: {
					// TODO send info
					print("Adding shawarma with: ")
					print("Name: " + shawarmaInfo.name)
					print("Address: " + shawarmaInfo.address)
					print("Coordinates: " + shawarmaInfo.coords)
					print("Size rating: " + shawarmaInfo.sizeRating.toFixed(1))
					print("Clean rating: " + shawarmaInfo.cleanRating.toFixed(1))
					print("Condition rating: " + shawarmaInfo.conditionRating.toFixed(1))
					print("Price: " + shawarmaInfo.price.toString())
					print("Comment: " + shawarmaInfo.comment)
				}
			}
		}
	}
}
