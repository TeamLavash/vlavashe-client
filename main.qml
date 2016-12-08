import QtQuick 2.5
import QtQuick.Window 2.2
import QtLocation 5.6
import QtPositioning 5.3

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Main Window")

    property variant locationSpb: QtPositioning.coordinate(59.9343, 30.3351)
    property var markerArray: []

    signal qmlSignal(string message)

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

    MainForm {
        id: mainForm

        anchors.fill: parent

        mapButton.onClicked: {
            print("mapButton: onClicked")

            mainForm.visible = false
            map.visible = true

            map.addMarker(locationSpb)
            map.addMarker(QtPositioning.coordinate(59.8, 30.2))
            map.addMarker(QtPositioning.coordinate(59.7, 30.1))
            map.addMarker(QtPositioning.coordinate(59.6, 30.0))
            map.addMarker(QtPositioning.coordinate(59.5, 30.4))
        }
    }

    Map {
        id: map
        anchors.fill: parent
        visible: false
        width: 640
        height: 480
        plugin: mapPlugin
        zoomLevel: (maximumZoomLevel - minimumZoomLevel) / 2
        center: locationSpb

        function addMarker(coords) {
            var newMarker = Qt.createComponent("Marker.qml")
            var object = newMarker.createObject(map)
            object.setLocation(coords)
            object.setText("TEXT")
            map.addMapItem(object)
        }

        Component {
            id: markerComponent
            MapQuickItem {
                id: marker
                coordinate: locationSpb

                sourceItem: Image {
                    id: image

                    source: "marker.png"

                    MouseArea {
                        id: markerMouseArea
                        anchors.fill: parent
                        hoverEnabled: false
                        preventStealing: true
                    }

                    Text {
                        id: text
                        y: image.height / 10
                        width: image.width
                        color: 'white'
                        font.bold: true
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        text: "MARKER"
                    }
                }
            }
        }
    }
}
