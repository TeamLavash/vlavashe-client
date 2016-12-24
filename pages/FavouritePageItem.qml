import QtQuick 2.6
import QtQuick.Controls 2.0

Item {
    id: favouriteItem

    width: parent.width
    height: parent.height / 5

    Image {
        id: image
        width: parent.width / 4
        height: parent.height * 0.8
        source: "qrc:/images/shawa.png"
    }

    Text {
        id: nameText
        width: parent.width / 2
        height: parent.height / 5
        text: qsTr("Название")
        anchors.top: parent.top
        anchors.topMargin: 17
        anchors.left: image.right
        anchors.leftMargin: 12
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 18
    }

    Button {
        id: moreButton
        width: parent.width / 3
        height: parent.height / 4
        text: qsTr("Подробнее")
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.bottomMargin: 0

        onClicked: moreActivated(itemId)
    }

    Text {
        id: priceText
        width: parent.width / 3
        height: parent.height / 6
        text: qsTr("Цена")
        anchors.top: parent.top
        anchors.topMargin: 72
        anchors.left: image.right
        anchors.leftMargin: 12
        font.pixelSize: 12
    }

    Text {
        id: addressText
        width: parent.width / 3
        height: parent.height / 6
        text: qsTr("Адрес")
        anchors.top: parent.top
        anchors.topMargin: 114
        anchors.left: image.right
        anchors.leftMargin: 12
        font.pixelSize: 12
    }

    property int itemId: -1

    function setId(id) {
        itemId = id
    }

    function setInfo(name, price, address) {
        nameText.text = name
        priceText.text = price
        addressText.text = address
    }

    signal moreActivated(int id)
}
