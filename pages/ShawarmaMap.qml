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
	property var markers: []

	Plugin {
		id: mapPlugin
		name: "mapbox"
		PluginParameter {
			name: "mapbox.access_token"
			value: "pk.eyJ1Ijoia29ybWljayIsImEiOiJjaXc3MWgwbG0wMDAxMnpwcWh1bGpyc2Z4In0.fHHDFBcWFuTcJQ7CqrqXlg"
		}
		PluginParameter {
			name: "mapbox.map_id"
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

	Pane {
		z: map.z + 3

		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter

		Row {
			spacing: 5

			TextField {
				id: searchField

				width: map.width * 0.8

				placeholderText: "Поиск"
			}

			Image {
				id: searchImage

				height: searchField.height

				source: "qrc:/images/search.png"
				fillMode: Image.PreserveAspectFit

				MouseArea {
					id: searchImageMouseArea

					anchors.fill: parent

					onClicked: {
						onSearchButtonClicked(searchField.text)
					}
				}
			}
		}
	}

	function addMarker(coords) {
		var newMarker = Qt.createComponent("qrc:/Marker.qml")
		var object = newMarker.createObject(map)
		object.setData(markers.length, coords, "TEXT")
		object.markerClicked.connect(onMarkerClicked)
		markers.push(object)
		map.addMapItem(object)
	}

	function onMarkerClicked(mId) {
		print("Marker " + mId + " clicked")
	}

	function onSearchButtonClicked(text) {
		print("Searching " + text)
	}
}
