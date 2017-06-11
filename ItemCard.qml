import QtQuick 2.7
import QtGraphicalEffects 1.0

Item {
    Rectangle {
        id: card
        color: "#FFFFFF"
        height: 240
        width: 180
        radius: 2
        z:2
        MouseArea {
            id: cardMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: cardAlbumMenuIcon.visible = true
            onExited: cardAlbumMenuIcon.visible = false
        }

        Text {
            id: cardAlbumName
            text: model.albumName
            font.family: "Quicksand"
            color: "Black"
            font.pixelSize: 16
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: cardAlbumMenuIcon
            text: "\uf142"
            color: "#777777"
            visible: false
            font.pointSize: 12
            font.family: fontAwesome.name
            anchors.top: parent.top
            anchors.topMargin: 16
            anchors.right: parent.right
            anchors.rightMargin: 20
        }
        Rectangle {
            id: cardInfoTopSplitter
            height: 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 40
            color: "#d6d6d6"
        }
        Rectangle {
            id: albumThumbs
            anchors.top: cardInfoTopSplitter.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            height: 90
            color: "transparent"
            Image {
                id: thumb1
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.left: parent.left
                anchors.leftMargin: 2
                height: 42
                width: 30
                mipmap: true
                source: "qrc:/Cards/gui/cards/1.png"
                fillMode: Image.PreserveAspectFit
            }
            Image {
                id: thumb1b
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.left: thumb1.right
                anchors.leftMargin: 5
                height: 42
                width: 30
                mipmap: true
                source: "qrc:/Cards/gui/cards/2.png"
                fillMode: Image.PreserveAspectFit
            }
            Image {
                id: thumb2
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.right: parent.right
                anchors.rightMargin: 2
                height: 42
                width: 30
                mipmap: true
                source: "qrc:/Cards/gui/cards/3.png"
                fillMode: Image.PreserveAspectFit
            }
            Image {
                id: thumb2b
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.right: thumb2.left
                anchors.rightMargin: 5
                height: 42
                width: 30
                mipmap: true
                source: "qrc:/Cards/gui/cards/12.png"
                fillMode: Image.PreserveAspectFit
            }
            Image {
                id: thumb3
                anchors.top: thumb1.bottom
                anchors.topMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 2
                height: 42
                width: 30
                mipmap: true
                source: "qrc:/Cards/gui/cards/13.png"
                fillMode: Image.PreserveAspectFit
            }
            Image {
                id: thumb3b
                anchors.top: thumb1.bottom
                anchors.topMargin: 5
                anchors.left: thumb3.right
                anchors.leftMargin: 5
                height: 42
                width: 30
                mipmap: true
                source: "qrc:/Cards/gui/cards/14.png"
                fillMode: Image.PreserveAspectFit
            }
            Image {
                id: thumb4
                anchors.top: thumb2.bottom
                anchors.topMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 2
                height: 42
                width: 30
                mipmap: true
                source: "qrc:/Cards/gui/cards/15.png"
                fillMode: Image.PreserveAspectFit
            }
            Image {
                id: thumb4b
                anchors.top: thumb2.bottom
                anchors.topMargin: 5
                anchors.right: thumb4.left
                anchors.rightMargin: 5
                height: 42
                width: 30
                mipmap: true
                source: "qrc:/Cards/gui/cards/21.png"
                fillMode: Image.PreserveAspectFit
            }

        }

        Rectangle {
            id: cardInfoBotSplitter
            height: 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 154
            color: "#d6d6d6"
        }

        Rectangle {
            id: thumbs

        }
        Text {
            id: cardInfoTitle
            text: " Total cards in album: " + albumsManager.getNrOfCards(model.ID);
            font.family: "Quicksand"
            color: "grey"
            font.pixelSize: 10
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 170
        }
    }
    DropShadow {
        anchors.fill: card
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: card
        z: 2
    }
}
