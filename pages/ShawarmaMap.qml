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
	property int state: 0 // 0 - search, 1 - select, 2 - check

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
		enabled: false

		onClicked: {
			var coord = map.toCoordinate(Qt.point(mouse.x, mouse.y))
			print("Clicked on map at ", coord)

			onMapClicked(coord)
		}
	}

	Pane {
		id: searchPane

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

			Button {
				id: searchButton

				height: searchField.height
				width: height

				background: Image {
					source: "qrc:/images/search.png"
					fillMode: Image.PreserveAspectFit
				}

				onClicked: {
					onSearchButtonClicked(searchField.text)
				}
			}
		}
	}

	function reset() {
		searchField.text = ""
		map.clearMapItems()
	}

	function setData(data) {
		reset();
		for (var i = 0; i < data.length; i++) {
			addMarker(data[i]["id"], QtPositioning.coordinate(data[i]["x"], data[i]["y"]),
					  data[i]["name"] + "\n" + data[i]["road"] + ", " + data[i]["house"])
		}
	}

	function addMarker(id, coords, name, address) {
		var newMarker = Qt.createComponent("qrc:/Marker.qml")
		var object = newMarker.createObject(map)
		object.setData(id, coords, name, address)
		object.markerClicked.connect(onMarkerClicked)
		markers.push(object)
		map.addMapItem(object)
	}

	function addSelectMarker(data) {
		var marker = Qt.createComponent("qrc:/SelectMarker.qml")
		var object = marker.createObject(map)
		object.setData(data)
		object.markerClicked.connect(onSelectMarkerClicked)
		map.addMapItem(object)
	}

	function addCheckMarker(data) {
		var marker = Qt.createComponent("qrc:/CheckMarker.qml")
		var object = marker.createObject(map)
		object.setData(data)
		object.markerClicked.connect(onCheckMarkerClicked)
		map.addMapItem(object)
	}

	function onMarkerClicked(mId) {
		print("Marker " + mId + " clicked")
	}

	function onSelectMarkerClicked(data) {

	}

	function onCheckMarkerClicked(data) {

	}

	function onSearchButtonClicked(text) {
		print("Searching " + text)
	}

	function setFocus(info) {
		for (var i = 0; i < markers.length; ++i) {
			if (markers[i].mId == info.id) {
				map.center = markers[i].coordinate
				map.zoomLevel = (maximumZoomLevel - minimumZoomLevel)
			}
		}
	}

	function setSelection(enable) {
		reset()
		if (enable) {
			state = 1
			mapMouseArea.enabled = true
			searchPane.visible = false
		} else {
			state = 0
			mapMouseArea.enabled = false
			searchPane.visible = true
		}
	}

	function setChecking(enable) {
		reset()
		if (enable) {
			state = 2
			mapMouseArea.enabled = true
			searchPane.visible = false
		} else {
			state = 0
			mapMouseArea.enabled = false
			searchPane.visible = true
		}
	}

	function filterCheckResponse(resp) {
		var data = []

		for (var i = 0; i < resp.length; ++i) {
			if (resp[i].address.road != null && resp[i].address.house_number != null) {
				var entry = {
					"x": resp[i].lat,
					"y": resp[i].lon,
					"road": resp[i].address.road,
					"house": resp[i].address.house_number
				}
				data.push(entry)
			}
		}

		return data
	}

	function checkAddress(address) {
		var http = new XMLHttpRequest()
		var addr = address.split(/[\s,]+/).join("/")
		var url = "http://nominatim.openstreetmap.org/search/ru/spb/" + addr
				+ "?format=json&accept-language=ru&addressdetails=1"
		print(url)

		http.onreadystatechange = function() {
			if (http.readyState == 4 && http.status == 200) {
				var resp = JSON.parse(http.responseText)
				print("http response: ", JSON.stringify(resp))

				var data = filterCheckResponse(resp)
				print("filtered response: ", JSON.stringify(data))

				if (data.length === 0) {
					checkFailed()
				} else if (data.length === 1) {
					onCheckMarkerClicked(data[0])
				} else {
					for (var i = 0; i < data.length; ++i) {
						addCheckMarker(data[i])
					}
				}
			}
		}

		http.open("GET", url, true)
		http.send()
	}

	function checkFailed() {

	}

	function onMapClicked(coords) {
		print(coords)
		var http = new XMLHttpRequest();
		var url = "http://nominatim.openstreetmap.org/reverse?format=json&accept-language=ru&lat="
				+ coords.latitude.toString() + "&lon=" + coords.longitude.toString() + "&zoom=18"
		print(url)

		http.onreadystatechange = function() {
			if (http.readyState == 4 && http.status == 200) {
				var resp = JSON.parse(http.responseText)

				var data = {
					"x": resp.lat,
					"y": resp.lon,
					"road": resp.address.road,
					"house": resp.address.house_number
				}

				if (data.road != null && data.house != null) {
					addSelectMarker(data)
				}
			}
		}

		http.open("GET", url, true)
		http.send()
	}
}
