import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

Rectangle {
    id: cardInfoEdit
    property string activeBackSide: "qrc:/Items/CardBackSideEdit.qml"
    signal nowShowing(string activeBackSide)
    color: "Transparent"
    width: 245
    height: 342


    // Album
    Rectangle {
        id: cardInAlbumAreaEdit
        color: "Transparent"
        width: 200
        height: 60
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 30
        anchors.leftMargin: 25

        // Album Tag
        Rectangle {
            id: albumTagEdit
            color: "Transparent"
            anchors.fill: parent

            Text {
                id: albumNameTagEdit
                text: "Album:"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 8
                font.pointSize: 12
                color: "#FFFFFF"
            }
            ComboBox {
                id: albumNameComboBoxEdit
                anchors.top: albumNameTagEdit.bottom
                anchors.left: parent.left
                anchors.topMargin: 0
                width: 190
                height: 40
                font.pointSize: 20
                leftPadding: 8
                bottomPadding: 9
                Component.onCompleted: {

                    albumNameComboBoxEdit.currentIndex = albumNameComboBoxEdit.find(cardInAlbum)
                }
                // Model
                model: albumsModel
                textRole: 'albumName'

                // Delegate
                delegate: ItemDelegate {
                    width: albumNameComboBoxEdit.width
                    height: 40
                    contentItem: Text {
                        text: albumName
                        color: "#FECC04"
                        font.pointSize: 20
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: albumNameComboBoxEdit.highlightedIndex == index
                }
                // Indicator
                indicator: Canvas {
                    id: canvas
                    x: albumNameComboBoxEdit.width - width - albumNameComboBoxEdit.rightPadding
                    y: albumNameComboBoxEdit.topPadding + (albumNameComboBoxEdit.availableHeight - height) / 2
                    width: 12
                    height: 8
                    contextType: "2d"

                    Connections {
                        target: albumNameComboBoxEdit
                        onPressedChanged: canvas.requestPaint()
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = albumNameComboBoxEdit.pressed ? "#FECC04" : "#FECC04";
                        context.fill();
                    }
                }

                // Content Item
                contentItem: Text {
                    topPadding: 0
                    leftPadding: 0
                    bottomPadding: 0
                    rightPadding: albumNameComboBoxEdit.indicator.width + albumNameComboBoxEdit.spacing

                    text: albumNameComboBoxEdit.displayText
                    font: albumNameComboBoxEdit.font
                    color: albumNameComboBoxEdit.pressed ? "#FECC04" : "#FECC04"
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                // Background
                background: Rectangle {
                    implicitWidth: 120
                    implicitHeight: 40
                    border.color: albumNameComboBoxEdit.pressed ? "#19284C" : "#FECC04"
                    border.width: albumNameComboBoxEdit.visualFocus ? 2 : 1
                    radius: 2
                    color: "#2E6EB6"
                }

                // Pop up
                popup: Popup {
                    y: albumNameComboBoxEdit.height - 1
                    width: albumNameComboBoxEdit.width
                    implicitHeight: listview.contentHeight
                    height: 180
                    padding: 1

                    contentItem: ListView {
                        id: listview
                        clip: true
                        model: albumNameComboBoxEdit.popup.visible ? albumNameComboBoxEdit.delegateModel : null
                        currentIndex: albumNameComboBoxEdit.highlightedIndex

                        ScrollIndicator.vertical: ScrollIndicator {
                            visible: true
                        }

                    }

                    background: Rectangle {
                        border.color: albumNameComboBoxEdit.pressed ? "#19284C" : "#FECC04"
                        color: "#19284C"
                        radius: 2
                    }
                }
            }
        }
    }

    // Status
    Rectangle {
        id: cardStatusAreaEdit
        color: "Transparent"
        width: 200
        height: 60
        anchors.top: cardInAlbumAreaEdit.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 25

        // Status Tag
        Rectangle {
            id: statusTagAreaEdit
            color: "Transparent"
            anchors.fill: parent

            Text {
                id: statusTagEdit
                text: "Status:"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 8
                font.pointSize: 12
                color: "#FFFFFF"
            }
            TextField {
                id: statusNameEdit
                anchors.top: statusTagEdit.bottom
                anchors.left: parent.left
                anchors.topMargin: 0
                width: 190
                height: 40
                text: cardStatus
                selectByMouse: true
                font.pointSize: 20
                color: "#FECC04"
                background: Rectangle {
                    border.color: "#FECC04"
                    color: "#2E6EB6"
                    radius: 2
                }
                leftPadding: 8
                bottomPadding: 5
            }
        }
    }

    // Condition
    Rectangle {
        id: cardConditionAreaEdit
        color: "Transparent"
        width: 200
        height: 60
        anchors.top: cardStatusAreaEdit.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 25

        // Condition Tag
        Rectangle {
            id: ctatusTagAreaEdit
            color: "Transparent"
            anchors.fill: parent

            Text {
                id: conditionTagEdit
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 8
                text: "Condition:"
                font.pointSize: 12
                color: "#FFFFFF"
            }
            TextField {
                id: conditionNameEdit
                anchors.top: conditionTagEdit.bottom
                anchors.left: parent.left
                anchors.topMargin: 0
                width: 190
                height: 40
                text: cardCondition
                selectByMouse: true
                font.pointSize: 20
                color: "#FECC04"
                background: Rectangle {
                    border.color: "#FECC04"
                    color: "#2E6EB6"
                    radius: 2
                }
                leftPadding: 8
                bottomPadding: 5
            }
        }
    }

    // Delete or Save
    Rectangle {
        id: deleteCardAreaEdit
        color: "Transparent"
        width: 200
        height: 60
        anchors.top: cardConditionAreaEdit.bottom
        anchors.left: parent.left
        anchors.topMargin: 50
        anchors.leftMargin: 25

        Rectangle {
            id: deleteCardEdit
            color: "#182752"
            height: 30
            width: 90
            radius: 5
            anchors.top: parent.top
            anchors.left: parent.left

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    cardInfoEdit.activeBackSide = "qrc:/Items/CardBackSideView.qml";
                    cardInfoEdit.nowShowing(cardInfoEdit.activeBackSide);
                }
            }

            Text {
                anchors.centerIn: parent
                text: "Cancel"
                font.pointSize: 12
                color: "White"
            }
        }

        Rectangle {
            id: modifyCardEdit
            height: 30
            width: 90
            radius: 5
            color: "Green"
            anchors.top: parent.top
            anchors.left: deleteCardEdit.right
            anchors.leftMargin: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {

                    cardsManager.setAlbumName(albumNameComboBoxEdit.currentText,cardID);
                    cardsManager.setCondition(conditionNameEdit.text,cardID);
                    cardsManager.setStatus(statusNameEdit.text,cardID);

                    cardInfoEdit.activeBackSide = "qrc:/Items/CardBackSideView.qml";
                    cardInfoEdit.nowShowing(cardInfoEdit.activeBackSide);
                }
            }

            Text {
                anchors.centerIn: parent
                text: "Save"
                font.pointSize: 12
                color: "White"
            }
        }


    }
}
