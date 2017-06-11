import QtQuick 2.7
import QtQuick.Controls 1.4
import PokeApp.Classes.Core 1.0
import "../Delegates"

Item {
    anchors.fill: parent
    Rectangle {
        id: searchToolBar
        color: "lightBlue"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 80
        anchors.rightMargin: 50
        anchors.leftMargin: 50
        TextField {
            id: searchBox

            placeholderText: "Search..."
            inputMethodHints: Qt.ImhNoPredictiveText

            width: 400
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    // Albums GridView
    GridView{
        property int albumsInApp: albumsManager.getNrOfAlbums();
        id: albumsGridView
        header:  Rectangle { height: 30 }
        footer: Rectangle {height: 80}
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        width: Math.min(albumsInApp, Math.floor(parent.width/cellWidth))*cellWidth
        height: parent.height
        cellHeight: 310
        cellWidth: 250
        clip: true
        z: 0
        delegate: AlbumsView {}
        model: ProxyModel {
            id: albumsProxyModel
            source: albumsModel.count > 0 ? albumsModel : null

            sortOrder: albumsTableView.sortIndicatorOrder
            sortCaseSensitivity: Qt.CaseInsensitive
            sortRole: albumsModel.count > 0 ? albumsTableView.getColumn(albumsTableView.sortIndicatorColumn).role : ""

            filterString: "*" + searchBox.text + "*"
            filterSyntax: ProxyModel.Wildcard
            filterCaseSensitivity: Qt.CaseInsensitive
        }

    }
    Item {
        Connections {
            target: albumsManager
            onAlbumAdded:
            {
                albumsGridView.albumsInApp = albumsManager.getNrOfAlbums();
            }
            onAlbumRemoved:
            {
                albumsGridView.albumsInApp = albumsManager.getNrOfAlbums();
            }
        }
    }
}
