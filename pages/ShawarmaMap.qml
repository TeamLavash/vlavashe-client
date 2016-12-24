import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.1
import QtLocation 5.6
import QtPositioning 5.3

Map {
	id: map
	visible: true
	width: parent.width
	height: parent.height
	plugin: mapPlugin
	zoomLevel: (maximumZoomLevel - minimumZoomLevel) / 2
	center: locationSpb

	property variant locationSpb: QtPositioning.coordinate(59.9343, 30.3351)

	Plugin {
		id: mapPlugin
		name: "mapbox"
		PluginParameter {
			name: "mapbox.access_token";
			value: "pk.eyJ1Ijoia29ybWljayIsImEiOiJjaXc3MWgwbG0wMDAxMnpwcWh1bGpyc2Z4In0.fHHDFBcWFuTcJQ7CqrqXlg"
		}
		PluginParameter {
			name: "mapbox.map_id";
			value: "examples.map-zr0njcqy"
		}
	}

	MouseArea {
		id: mapMouseArea
		anchors.fill: parent

		onClicked: {
			var coord = map.toCoordinate(Qt.point(mouse.x, mouse.y))
			print("Clicked on map at ", coord)
			addMarker(coord)
		}
	}

	function addMarker(coords) {
		var newMarker = Qt.createComponent("qrc:/Marker.qml")
		var object = newMarker.createObject(map)
		object.setLocation(coords)
		object.setText("TEXT")
		map.addMapItem(object)
	}
}
