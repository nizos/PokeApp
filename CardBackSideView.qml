import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

Rectangle {
    id: cardInfo
    property string activeBackSide: "qrc:/Items/CardBackSideView.qml"
    signal nowShowing(string activeBackSide)
    color: "Transparent"
    width: 245
    height: 342


    // Album
    Rectangle {
        id: cardInAlbumArea
        color: "Transparent"
        width: 200
        height: 60
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 30
        anchors.leftMargin: 25

        // Album Tag
        Rectangle {
            id: albumTag
            color: "Transparent"
            anchors.fill: parent

            Text {
                id: albumNameTag
                text: "Album:"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 8
                font.pointSize: 12
                color: "#FFFFFF"
            }
            Text {
                id: albumNameText
                text: cardInAlbum
                font.pointSize: 20
                color: "#FECC04"
                anchors.top: albumNameTag.bottom
                anchors.left: parent.left
                anchors.topMargin: 2
                anchors.leftMargin: 8
            }
        }
    }

    // Status
    Rectangle {
        id: cardStatusArea
        color: "Transparent"
        width: 200
        height: 60
        anchors.top: cardInAlbumArea.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 25

        // Status Tag
        Rectangle {
            id: statusTagArea
            color: "Transparent"
            anchors.fill: parent

            Text {
                id: statusTag
                text: "Status:"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 8
                font.pointSize: 12
                color: "#FFFFFF"
            }
            Text {
                id: statusName
                text: cardStatus
                font.pointSize: 20
                color: "#FECC04"
                anchors.top: statusTag.bottom
                anchors.left: parent.left
                anchors.topMargin: 2
                anchors.leftMargin: 8
            }
        }
    }

    // Condition
    Rectangle {
        id: cardConditionArea
        color: "Transparent"
        width: 200
        height: 60
        anchors.top: cardStatusArea.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 25

        // Condition Tag
        Rectangle {
            id: ctatusTagArea
            color: "Transparent"
            anchors.fill: parent

            Text {
                id: conditionTag
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 8
                text: "Condition:"
                font.pointSize: 12
                color: "#FFFFFF"
            }
            Text {
                id: conditionName
                text: cardCondition
                font.pointSize: 20
                color: "#FECC04"
                anchors.top: conditionTag.bottom
                anchors.left: parent.left
                anchors.topMargin: 2
                anchors.leftMargin: 8
            }
        }
    }

    // Delete or Save
    Rectangle {
        id: deleteCardArea
        color: "Transparent"
        width: 200
        height: 60
        anchors.top: cardConditionArea.bottom
        anchors.left: parent.left
        anchors.topMargin: 50
        anchors.leftMargin: 25

        Rectangle {
            id: deleteCard
            color: "Red"
            height: 30
            width: 90
            radius: 5
            anchors.top: parent.top
            anchors.left: parent.left

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    cardsManager.removeCard(cardID,cardsManager.getAlbumMID(cardID));
                }
            }

            Text {
                anchors.centerIn: parent
                text: "Delete"
                font.pointSize: 12
                color: "White"
            }
        }

        Rectangle {
            id: modifyCard
            height: 30
            width: 90
            radius: 5
            color: "#182752"
            anchors.top: parent.top
            anchors.left: deleteCard.right
            anchors.leftMargin: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    cardInfo.activeBackSide = "qrc:/Items/CardBackSideEdit.qml";
                    cardInfo.nowShowing(cardInfo.activeBackSide);
                }
            }

            Text {
                anchors.centerIn: parent
                text: "Edit"
                font.pointSize: 12
                color: "White"
            }
        }


    }
}
