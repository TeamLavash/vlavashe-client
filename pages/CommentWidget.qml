import QtQuick 2.6
import QtQuick.Controls 2.0

Item {
	height: parent.height

	Column {
		spacing: 10

		Row {
			id: row
			spacing: 30

			TextField {
				id: commentField

				placeholderText: qsTr("Оставить комментарий")
			}

			Button {
				id: commentButton

				text: qsTr("Отправить")
			}
		}

		Item {
			height: parent.height

			anchors.top: row.bottom
			anchors.topMargin: 20

			ListView {
				id: commentList

				width: parent.width
				height: parent.height
				spacing: 30

				boundsBehavior: Flickable.StopAtBounds

				Component {
					id: commentDelegate

					Rectangle {
						id: content

						anchors { left: parent.left; right: parent.right }
						height: commentItem.height + 4

						Item {
							id: commentItem

							Column {
								spacing: 50

								Label {
									id: userName

									text: user + ":"
								}

								Label {
									id: comment
									width: commentList.width
									anchors.top: userName.bottom

									wrapMode: Text.Wrap

									text: txt
								}
							}
						}
					}
				}

				delegate: commentDelegate

				model: ListModel {
					id: listModel
				}
			}
		}
	}

	property int commentCount: 0

	function addComment(user, txt) {
		print(user + ": " + txt)
		listModel.append({"user": user, "txt": txt})
		commentCount += 1
	}
}
