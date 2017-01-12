import QtQuick 2.6
import QtQuick.Controls 2.0

ListView {
	id: listView

	width: parent.width
	height: parent.height

	anchors.fill: parent
	boundsBehavior: Flickable.StopAtBounds

	Component {
		id: listViewDelegate

		Rectangle {
			id: content

			anchors { left: parent.left; right: parent.right }
			height: favouriteItem.height + 4

			FavouriteItem {
				id: favouriteItem

				itemId: id
				nameText.text: name
				addressText.text: road + ", " + house
				priceText.text: "Стоимость обычной в лаваше: " + price

				onMoreActivated: {
					print("More activated with " + id.toString())
					listView.onMoreActivated(id)
				}
			}
		}
	}

	delegate: listViewDelegate

	model: ListModel {
		id: listModel
	}

	function setData(data) {
		listModel.clear()
		for (var i = 0; i < data.length; i++) {
			listModel.append(data[i])
		}
	}

	function onMoreActivated(id) {
		print(id, " acivated")
	}
}
