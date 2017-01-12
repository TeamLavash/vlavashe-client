import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.1

import "qrc:/"

Flickable {
	id: flickable

	contentHeight: pane.height
	boundsBehavior: Flickable.StopAtBounds

	property alias addButton: addButton
	property alias onMapButton: onMapButton
	property var shawarmaInfo: {
		"name": "",
		"road": "",
		"house": "",
		"x": 0.0,
		"y": 0.0,
		"price": 120
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

			spacing: 10

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

			Row {
				anchors.horizontalCenter: parent.horizontalCenter

				spacing: 10

				RadioButton {
					id: addressRadioButton

					checked: true

					onCheckedChanged: {
						addressField.enabled = checked
						onMapRadioButton.checked = !checked
					}
				}

				TextField {
					id: addressField

					width: parent.width * 0.8

					enabled: true

					placeholderText: qsTr("Адрес")
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
			}

			Row {
				anchors.horizontalCenter: parent.horizontalCenter

				spacing: 10

				RadioButton {
					id: onMapRadioButton

					checked: false

					onCheckedChanged: {
						onMapButton.enabled = checked
						addressRadioButton.checked = !checked
					}
				}

				Button {
					id: onMapButton

					width: parent.width * 0.8

					enabled: false

					text: qsTr("На карте")
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
					if (text == "") {
						shawarmaInfo.price = 0
					} else {
						shawarmaInfo.price = parseInt(priceField.text)
					}
				}
			}

			Row {
				anchors.horizontalCenter: parent.horizontalCenter

				spacing: 50

				Button {
					id: addButton

					text: qsTr("Добавить")

					onClicked: {
						// TODO send info
						print("Adding shawarma with: ")
						print("Name: " + shawarmaInfo.name)
						print("Address: " + shawarmaInfo.road + ", " + shawarmaInfo.house)
						print("Coordinates: " + shawarmaInfo.coords)
						print("Price: " + shawarmaInfo.price.toString())
						print("Comment: " + shawarmaInfo.comment)
					}
				}

				Button {
					id: clearButton

					text: qsTr("Очистить")

					onClicked: {
						reset()
					}
				}
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
	}

	function validate() {
		var err = ""
		var res = true

		if (shawarmaInfo.name == "") {
			err += "Имя не указано.\n"
			res = false
		}
		if (shawarmaInfo.road == "" || addressField.text == "") {
			err += "Адрес не указан.\n"
			res = false
		}
		if ((shawarmaInfo.x == 0 || shawarmaInfo.y == 0)
				&& (shawarmaInfo.road != "" || addressField.text != "")) {
			err += "Координаты не указаны.\n"
			res = false
		}
		if (shawarmaInfo.price == 0) {
			err += "Цена не указана.\n"
			res = false
		}
		setResult(err)
		return res
	}

	function reset() {
		nameField.text = ""
		addressField.text = ""
		priceField.text = 120
		resultLabel.text = ""
		addressRadioButton.checked = true
	}

	function setResult(result) {
		resultAnimation.stop()
		resultLabel.opacity = 0.0
		resultLabel.text = result
		resultAnimation.start()
	}

	function getData() {
		return JSON.stringify(shawarmaInfo)
	}

	function setAddress(data) {
		addressField.text = data.road + ", " + data.house
		shawarmaInfo.road = data.road
		shawarmaInfo.house = data.house
		shawarmaInfo.x = data.x
		shawarmaInfo.y = data.y
	}

	function setCoordinates(data) {
		print(JSON.stringify(data))

		shawarmaInfo.x = data.x
		shawarmaInfo.y = data.y
		addressField.text = data.road + ", " + data.house
		shawarmaInfo.road = data.road
		shawarmaInfo.house = data.house
	}

	function byAddress() {
		return addressRadioButton.checked
	}

	function getAddress() {
		return addressField.text
	}
}
