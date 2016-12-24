import QtQuick 2.6
import QtLocation 5.6

MapQuickItem {
    id: marker

	anchorPoint.x: markerImage.width * 0.5
	anchorPoint.y: markerImage.height

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

    function setLocation(coords) {
        coordinate = coords
    }

    function setText(t) {
        text.text = t
    }
}
