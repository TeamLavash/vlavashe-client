import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import Qt.labs.settings 1.0
import QtQuick.Window 2.1
import QtPositioning 5.3
import TypeEnum 1.0
import ResultEnum 1.0
import UserEnum 1.0

import "qrc:/pages"

ApplicationWindow {
	id: window

	width: Screen.width
	height: Screen.height
	visible: true

	title: "VLavashe"

	Settings {
		id: settings
		property string style: "Material"
	}

	header: ToolBar {
		Material.foreground: "white" // map

		RowLayout {
			spacing: 1
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

			ToolButton {
				contentItem: Image {
					fillMode: Image.PreserveAspectFit
					horizontalAlignment: Image.AlignHCenter
					verticalAlignment: Image.AlignVCenter
					source: "qrc:/images/back.png"
				}

				onClicked: {
					stackView.pop()
					titleLabel.text = container.titles[stackView.currentItem.titleId]
				}
			}

			Label {
				id: titleLabel
				text: "ВЛаваше"
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
				id: listViewDelegate
				width: parent.width
				text: model.title
				highlighted: ListView.isCurrentItem
				onClicked: {
					listView.currentIndex = index
					titleLabel.text = model.title
					qmlSignal(model.source, "")
					drawer.close()
				}
			}

			model: ListModel {
				id: listModel
				ListElement { title: "Карта";     source: Type.SHOW_MAP       }
				ListElement { title: "Профиль";   source: Type.SHOW_PROFILE   }
				ListElement { title: "Избранное"; source: Type.SHOW_FAVOURITE }
			}

			ScrollIndicator.vertical: ScrollIndicator { }

			function resetIndex() {
				listView.currentIndex = -1
			}

			function setAddNewShawa(visible) {
				if (visible) {
					listModel.append({ "title": "Добавить шаверму", "source": Type.SHOW_ADD_NEW })
				} else {
					listModel.remove(3)
				}
			}
		}
	}

	Item {
		id: container
		visible: false

		property var titles: ["ВЛаваше", "Профиль", "Вход", "Вход", "Регистрация",
			"Избранное", "Подробнее", "Добавить шаверму", "Отзывы"]

		ShawarmaMap {
			id: map
			property int titleId: 0

			function onMarkerClicked(id) {
				var data = { "id": id }
				qmlSignal(Type.MORE, JSON.stringify(data))
			}

			function onSelectMarkerClicked(data) {
				map.setSelection(false)
				addNewShawaPage.setAddress(data)
				stackView.push(addNewShawaPage)
			}

			function onCheckMarkerClicked(data) {
				map.setChecking(false)
				addNewShawaPage.setCoordinates(data)
				stackView.push(addNewShawaPage)

				if (addNewShawaPage.validate()) {
					var sData = addNewShawaPage.getData()
					qmlSignal(Type.ADD_NEW_SHAWA, sData)
				}
			}

			function checkFailed() {
				map.setChecking(false)
				addNewShawaPage.setResult("Invalid address.")
				stackView.push(addNewShawaPage)
			}

			function onSearchButtonClicked(text) {
				var data = { "text": text }
				qmlSignal(Type.SEARCH, JSON.stringify(data))
			}
		}

		Profile {
			id: profilePage
			property int titleId: 1

			logoutButton.onClicked: {
				qmlSignal(Type.LOGOUT, "")
			}
		}

		SignUpSignIn {
			id: signUpSignInPage
			property int titleId: 2

			signUpButton.onClicked: {
				listView.resetIndex()
				qmlSignal(Type.SHOW_SIGN_UP, "")
			}

			signInButton.onClicked: {
				listView.resetIndex()
				qmlSignal(Type.SHOW_SIGN_IN, "")
			}
		}

		SignIn {
			id: signInPage
			property int titleId: 3

			signInButton.onClicked: {
				if (validate()) {
					var data = signInPage.getData()
					qmlSignal(Type.SIGN_IN, data)
				}
			}
		}

		SignUp {
			id: signUpPage
			property int titleId: 4

			signUpButton.onClicked: {
				if (validate()) {
					var data = signUpPage.getData()
					qmlSignal(Type.SIGN_UP, data)
				}
			}
		}

		Favourite {
			id: favouritePage
			property int titleId: 5

			function onMoreActivated(id) {
				var data = { "id": id }
				qmlSignal(Type.MORE, JSON.stringify(data))
			}
		}

		More {
			id: morePage
			property int titleId: 6

			favouriteButton.onClicked: {
				var data = { "id": morePage.info.id }
				if (morePage.isFavourite()) {
					qmlSignal(Type.FAVOURITE_REMOVE, JSON.stringify(data))
				} else {
					qmlSignal(Type.FAVOURITE_ADD, JSON.stringify(data));
				}
			}

			commentButton.onClicked: {
				var data = { "id": morePage.info.id }
				qmlSignal(Type.SHOW_COMMENTS, JSON.stringify(data))
			}

			onMapButton.onClicked: {
				var data = morePage.info

				map.setFocus(data)
				stackView.push(map)
			}
		}

		AddNewShawa {
			id: addNewShawaPage
			property int titleId: 7

			addButton.onClicked: {
				if (byAddress()) {
					var addr = getAddress()
					if (addr == "") {
						validate()
					} else {
						map.setChecking(true)
						map.checkAddress(getAddress())
						stackView.push(map)
					}
				} else {
					if (validate()) {
						var data = getData()
						qmlSignal(Type.ADD_NEW_SHAWA, data)
					}
				}
			}

			onMapButton.onClicked: {
				map.setSelection(true)
				stackView.push(map)
			}
		}

		Comments {
			id: commentsPage
			property int titleId: 8

			commentButton.onClicked: {
				var data = commentsPage.getData()
				qmlSignal(Type.COMMENT_ADD, data)
			}
		}
	}

	StackView {
		id: stackView
		anchors.fill: parent
		initialItem: map
	}

	function show(item) {
		stackView.push(item)
		titleLabel.text = container.titles[item.titleId]
	}

	signal qmlSignal(int type, string message)

	function cppSlot(type, data, result) {
		print("Message " + type + ": " + result + ": " + data);

		var resp
		if (data) {
			resp = JSON.parse(data)
		}

		if (type == Type.SHOW_MAP) {
			map.setData(resp)
			show(map)
		} else if (type == Type.SHOW_PROFILE) {
			profilePage.setData(resp)
			sow(profilePage)
		} else if (type == Type.SHOW_FAVOURITE) {
			favouritePage.setData(resp)
			show(favouritePage)
		} else if (type == Type.SHOW_ADD_NEW) {
			addNewShawaPage.reset()
			show(addNewShawaPage)
		} else if (type == Type.SHOW_SIGN_UP_SIGN_IN) {
			show(signUpSignInPage)
		} else if (type == Type.SHOW_SIGN_UP) {
			signUpPage.reset()
			show(signUpPage)
		} else if (type == Type.SHOW_SIGN_IN) {
			signInPage.reset()
			show(signInPage)
		} else if (type == Type.SIGN_UP) {
			signUpPage.setResult(resp.result)
		} else if (type == Type.SIGN_IN) {
			if (result == Result.OK) {
				profilePage.setData(resp)
				listView.setAddNewShawa(resp.status == User.ADMIN)
				show(profilePage)
			} else {
				signInPage.setResult(resp.result)
			}
		} else if (type == Type.ADD_NEW_SHAWA) {
			addNewShawaPage.setResult(resp.result)
		} else if (type == Type.MORE) {
			listView.resetIndex()
			morePage.setData(resp)
			show(morePage)
		} else if (type == Type.SEARCH) {
			map.setData(resp)
		} else if (type == Type.LOGOUT) {
			show(signUpSignInPage)
			listView.setAddNewShawa(false)
		} else if (type == Type.FAVOURITE_ADD) {
			if (result == Result.OK) {
				morePage.setState(true)
			}
		} else if (type == Type.FAVOURITE_REMOVE) {
			if (result == Result.OK) {
				morePage.setState(false)
			}
		} else if (type == Type.SHOW_COMMENTS) {
			commentsPage.setData(resp)
			show(commentsPage)
		} else if (type == Type.COMMENT_ADD) {
			if (result == Result.ERROR) {
				commentsPage.setResult(resp.result)
			}
		}
	}
}

