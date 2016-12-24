import QtQuick 2.6
import QtQuick.Controls 2.0

Flickable {
    id: flickable

    Pane {
        id: pane
        width: flickable.width
        height: flickable.height * 1.25

        Column {
            id: column
            spacing: 0
            width: parent.width
            height: parent.height
            anchors.top: parent.top
            anchors.topMargin: 0
        }
    }

    ScrollBar.vertical: ScrollBar { }

    property var favorites: []

    function addFavourite(name, price, address) {
        var object = Qt.createComponent("qrc:/pages/FavouritePageItem.qml")
        var item = object.createObject(column)
        item.itemId = favorites.length
        item.setInfo(name, price, address)
        item.moreActivated.connect(onMoreActivated)
        favorites.push(item)
        contentHeight = item.height * favorites.length
    }

    function onMoreActivated(id) {
        print(id, " activated")
    }
}
