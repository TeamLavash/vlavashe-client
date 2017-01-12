import QtQuick 2.6
import QtQuick.Controls 2.0

Pane {
	height: parent.height

	anchors.horizontalCenter: parent.horizontalCenter

	property alias commentButton: commentButton
	property int shawaId

	Column {
		height: parent.height

		anchors.horizontalCenter: parent.horizontalCenter

		spacing: 10

		Column {
			id: column

			Row {
				spacing: 10

				TextField {
					id: commentField

					placeholderText: qsTr("Оставить комментарий")
				}

				Button {
					id: commentButton

					background: Image {
						height: commentField.height
						width: height

						source: "qrc:/images/send.png"
						fillMode: Image.PreserveAspectFit
					}
				}
			}

			Row {
				spacing: 10

				Label {
					text: qsTr("Оценка")
				}

				Slider {
					id: ratingSlider

					value: 0.5
				}
			}
		}

		Label {
			id: resultLabel

			anchors.horizontalCenter: parent.horizontalCenter

			horizontalAlignment: Text.AlignHCenter

			opacity: 0.0
			SequentialAnimation {
				id: resultAnimation
				running: false
				NumberAnimation { target: resultLabel; property: "opacity"; to: 1.0; duration: 1000 }
			}
		}

		ListView {
			id: commentList

			width: parent.width
			height: parent.height - column.height - 50
			spacing: 30

			boundsBehavior: Flickable.StopAtBounds

			Component {
				id: commentDelegate

				Item {
					id: commentItem

					height: userName.height + comment.lineCount * userName.height

					Column {
						spacing: 1

						Label {
							id: userName

							text: user + ":"
						}

						Label {
							id: ratingLabel

							text: "Оценка: " + rating
						}

						Label {
							id: comment
							width: commentList.width

							wrapMode: Text.Wrap

							text: txt
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

	property int commentCount: 0

	function setData(data) {
		shawaId = data.id

		resultLabel.text = ""
		listModel.clear()

		var comments = data.comments
		for (var i = comments.length - 1; i >= 0; --i) {
			addComment(comments[i]["user"], comments[i]["comment"], comments[i]["rating"])
		}
	}

	function addComment(user, txt, rating) {
		print(user + ": " + rating + ": " + txt)
		listModel.append({"user": user, "txt": txt, "rating": rating})
		commentCount += 1
	}

	function getData() {
		var data = {
			"id": shawaId,
			"comment": commentField.text,
			"rating": ratingSlider.value * 5
		}
		return JSON.stringify(data)
	}

	function setResult(result) {
		resultAnimation.stop()
		resultLabel.opacity = 0.0
		resultLabel.text = result
		resultAnimation.start()
	}
}
