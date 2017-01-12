import QtQuick 2.6
import QtLocation 5.6
import QtPositioning 5.3

MapQuickItem {
	id: marker

	anchorPoint.x: markerImage.width * 0.5
	anchorPoint.y: markerImage.height - 1

	sourceItem: Image {
		id: markerImage
		source: "qrc:/images/marker.png"

		MouseArea {
			id: markerMouseArea
			anchors.fill: parent
			hoverEnabled: false
			preventStealing: true

			onClicked: {
				print("Clicked on marker: ", coordinate)
				markerClicked(mData)
			}
		}

		Text {
			id: text
			y: markerImage.height / 10
			width: markerImage.width
			color: 'black'
			font.bold: true
			font.pixelSize: 14
			horizontalAlignment: Text.AlignHCenter
			text: "MARKER"
		}
	}

	signal markerClicked(var data)

	property var mData

	function setData(data) {
		mData = data

		coordinate = QtPositioning.coordinate(data.x, data.y)
		text.text = data.road + ", " + data.house
	}
}

