import QtQuick 2.0
import PokeApp.Classes.Core 1.0

// Albums Deligate
Item {
    id: albumsDeligate
    Rectangle {
        id: album
        height: 400
        width: 300
        color: 'Transparent'

        Rectangle {
            id: info
            color: "Transparent"
            height: 70
            width: 230
            Rectangle {
                anchors.centerIn: parent
                color: "#16a085"
                width: 130
                height: 55
                Column {
                    anchors.fill: parent
                    anchors.topMargin: 10
                    Text {
                        text: model.albumName
                        font.pointSize: 12
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: "Cards in album: " + albumsSQLManager.getNrOfCards(model.ID);
                        font.pointSize: 9
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mainApp.currentAlbumChanged(model.ID)
                        mainApp.showAlbum(model.ID);
                        swipeView.currentIndex = 3;
                        appWindow.currentAlbum = model.ID;
                    }
                }
            }
        }
    }
}
