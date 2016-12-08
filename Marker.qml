import QtQuick 2.5
import QtLocation 5.6

MapQuickItem {
    id: marker

    sourceItem: Image {
        id: markerImage
        source: "marker.png"

        MouseArea {
            id: markerMouseArea
            anchors.fill: parent
            hoverEnabled: false
            preventStealing: true
        }

        Text {
            id: text
            y: markerImage.height / 10
            width: markerImage.width
            color: 'white'
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
