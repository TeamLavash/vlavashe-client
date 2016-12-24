import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import Qt.labs.settings 1.0
import QtQuick.Window 2.1
import QtPositioning 5.3

import "qrc:/pages"

ApplicationWindow {
    id: window

    width: Screen.width
    height: Screen.height
    visible: true

    title: "VLavashe"

    GuiState {
        id: guiState
    }

    Settings {
        id: settings
        property string style: "Material"
    }	

    header: ToolBar {
		Material.foreground: "white" // map

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/images/drawer.png"
                }
                onClicked: drawer.open()
            }

            Label {
                id: titleLabel
                text: "VLavashe"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/images/menu.png"
                }
                onClicked: optionsMenu.open()

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "Выход"
                        onClicked: Qt.quit()
                    }
                }
            }
        }
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height

        ListView {
            id: listView
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    if (listView.currentIndex != index) {
                        listView.currentIndex = index
                        titleLabel.text = model.title
                        stackView.setItem(model.source)
                    }
                    drawer.close()
                }
            }

            model: ListModel {
				ListElement { title: "Карта";            source: "map"         }
				ListElement { title: "Профиль";          source: "profile"     }
				ListElement { title: "Избранное";        source: "favourite"   }
                ListElement { title: "Добавить шаверму"; source: "addNewShawa" }
            }

            ScrollIndicator.vertical: ScrollIndicator { }

            function resetIndex() {
                listView.currentIndex = -1
            }
        }
    }

    AddNewShawa {
        id: addNewShawaPage
    }

    EnterSignIn {
        id: enterSignInPage

        buttonEnter.onClicked: {
            stackView.setItem("enter")
        }

        buttonSignIn.onClicked: {
            stackView.setItem("signIn")
        }
    }

    FavouritePage {
        id: favouritePagePage

        function onMoreActivated(id) {
            print(id, " activated")
            stackView.setItem("more")
            // TODO send request for ext info
        }
    }

    Login {
        id: loginPage
    }

    More {
        id: morePage
    }

    ProfilePage {
        id: profilePagePage
    }

    ProfileSignInPage {
        id: profileSignInPagePage
    }

//    ShawaOnMap {
//        id: shawaOnMapPage
//    }

	ShawarmaMap {
		id: map
	}

    property alias stackView: stackView
    StackView {
        id: stackView
        anchors.fill: parent

        function setItem(name) {
            if (name === "profile") {
                if (guiState.loggedIn) {
                    stackView.replace(profilePagePage)
                } else {
                    setItem("enterSignIn")
                }
            } else if (name === "enterSignIn") {
                stackView.replace(enterSignInPage)
            } else if (name === "enter") {
                stackView.replace(loginPage)
                listView.resetIndex()
            } else if (name === "signIn") {
                stackView.replace(profileSignInPagePage)
                listView.resetIndex()
            } else if (name === "favourite") {
                stackView.replace(favouritePagePage)

				// fake data
                favouritePagePage.addFavourite("qwe", "asd", "zxc")
            } else if (name === "addNewShawa") {
                stackView.replace(addNewShawaPage)
            } else if (name === "more") {
                stackView.replace(morePage)
                listView.resetIndex()
			} else if (name === "map") {
				stackView.replace(map)
			}
        }

		initialItem: map
    }
}

