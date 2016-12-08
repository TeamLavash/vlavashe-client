import QtQuick 2.5
import QtQuick.Controls 2.0

Rectangle {
    property alias mouseArea: mouseArea

    width: 360
    height: 360
    property alias mapButton: mapButton

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        Button {
            id: mapButton
            x: 130
            y: 160
            text: qsTr("To map")
            transformOrigin: Item.Center
        }
    }
}
