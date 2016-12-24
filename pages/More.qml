import QtQuick 2.6
import QtQuick.Controls 2.0

Flickable {
    id: flickable
    property alias photo1: photo1

    contentHeight: pane.height

    Pane {
        id: pane
        width: flickable.width
        height: flickable.height * 2
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        
        //Name
        //Adress
        Column {
            id: columnInfo
            spacing: 0
            width: parent.width
            height:  parent.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            Label {
                id: label1
                width: parent.width
                height: parent.height*0.6
                wrapMode: Label.Wrap
                horizontalAlignment: Qt.AlignHCenter
                text: "У Захара"
                font.bold: true
                font.pointSize: 18
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
            }
            Label {
                width: parent.width
                height: parent.height*0.4
                wrapMode: Label.Wrap
                horizontalAlignment: Qt.AlignHCenter
                text: "Новочеркасский проспект 39"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 14
                anchors.top: label1.bottom
                anchors.topMargin: 0
                
            }
        }
        
        //Photos

        SwipeView {
            id: view
            width: parent.width * 0.3
            height: parent.width * 0.3
            anchors.horizontalCenterOffset: 0
            currentIndex: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: columnInfo.bottom
            anchors.topMargin: 10

            Image {
                id: photo1
                source: "qrc:/images/zaxar.png"
            }
            Image {
                id: photo2

                source: "qrc:/images/spb.png"
            }
            Image {
                id: photo3

                source: "qrc:/images/shawa.png"
            }



        }
        Item {
            id: itemDot
            width: parent.width * 0.1
            height: parent.height * 0.02
            anchors.top: view.bottom
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter

            PageIndicator {

                width: parent.width
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: view.bottom
                anchors.topMargin: 0
                count: view.count
                currentIndex: view.currentIndex
            }
        }
        
        //menu
        Column {
            id: columnMenu
            spacing: 0
            width: parent.width
            height:  parent.height * 0.2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: itemDot.bottom
            anchors.topMargin: 0
            Label {
                id: labelM
                width: parent.width
                height: parent.height * 0.15
                wrapMode: Label.Wrap
                horizontalAlignment: Qt.AlignHCenter
                text: "Меню"
                font.bold: true
                font.pointSize: 14
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
            }
            
            Label {
                wrapMode: Label.Wrap
                width: parent.width
                height: parent.height
                text: qsTr("В лаваше.................140\nВ лаваше двойная....180\nВ пите.....................120\nНа тарелке..............200")
                horizontalAlignment: Text.AlignHCenter

                topPadding: 5
                font.pointSize: 12
                anchors.top: labelM.bottom
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
            }

            
        }
        
        //comments
        Column {
            id: column
            spacing: 0
            width: parent.width
            height: parent.height * 0.3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: columnMenu.bottom
            anchors.topMargin: 10
            
            TextField {
                id: textFieldComment
                width: parent.width
                text: qsTr("Оставить комментарий")
                anchors.left: parent.left
                anchors.leftMargin: 0
                
                Button {
                    id: button1
                    width: parent.width * 0.1
                    height: parent.height * 0.9
                    text: qsTr("Отправить")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                }
            }

            Item {
                id: item1
                y: 0
                width: parent.width
                height: parent.height/2
                anchors.top: textFieldComment.bottom
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                
                Text {
                    id: text4
                    width: parent.width * 0.65
                    height: parent.height / 4
                    text: qsTr("ФИО пользователя")
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: text6.right
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    font.pixelSize: 14
                }

                Text {
                    id: text5
                    width: parent.width * 0.65
                    height: parent.height * 0.6
                    text: qsTr("Текст комментария")
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: text4.bottom
                    anchors.topMargin: 5
                    anchors.left: text6.right
                    anchors.leftMargin: 5
                    font.pixelSize: 14
                }

                Text {
                    id: text6
                    width: parent.width / 4
                    height: parent.height * 0.15
                    text: qsTr("Оценка 7.5 / 10")
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.top: image2.bottom
                    anchors.topMargin: 5
                    font.pixelSize: 12
                }

                Image {
                    id: image2
                    width: parent.height * 0.75
                    height: parent.height * 0.75
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    source: "qrc:/images/shawa.png"
                }

            }
            
        }


    }

    ScrollBar.vertical: ScrollBar { }
}
