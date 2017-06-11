import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import "../Pages"
import "../Items"

Item {
    id: viewSingleCard
    objectName: "viewSingleCard"
    property int cardID
    property string imageURL: "https://images.pokemontcg.io/xy7/41.png"
    property string cardInAlbum: "Not set"
    property string cardCondition: "Not set"
    property string cardStatus: "Not set"
    property bool viewVisible: true
    anchors.top: parent.top
    opacity: 1
    z: 40

    // Dark Screen
    Rectangle {
        id: screenArea
        anchors.fill: parent
        color: "Black"
        opacity: 0.9
        z: 40

        // Close Button
        Rectangle {
            height: 30
            width: 100
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 30
            anchors.rightMargin: 30
            z: 60
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Close"
                z: 70
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    viewSingleCard.viewVisible = false
                    viewSingleCard.opacity = 0
                }
            }
        }

        // Items in View
        Row {
            id: singleCardViewRow
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            // Pokemon Card Image
            Image {
                id: cardPic
                source: "image://imgp/" + imageURL
                width: 245
                height: 342
                opacity: 1
                cache: false
                visible: true
                z:50
                MouseArea {
                    anchors.fill: parent
                }
            }

            // Pokemon Card Info Box
            Image {
                id: cardBackSide
                source: "qrc:/Cards/gui/Cards/card_backside.png"
                width: 245
                height: 342
                opacity: 1
                cache: false
                visible: true
                z:50

                MouseArea {
                    anchors.fill: parent
                }
                Loader {
                    id: cardBackSideLoader
                    source: "qrc:/Items/CardBackSideView.qml"
                }
                Connections {
                    id: cardBackSideConnection
                    target: cardBackSideLoader.item
                    onNowShowing: {
                        cardBackSideLoader.source = activeBackSide;
                    }

                }
            }
        }
    }
    Behavior on opacity {
        PropertyAnimation {
            duration: 400
            easing.type: Easing.OutQuad
        }
    }
}
