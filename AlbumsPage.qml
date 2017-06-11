import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import PokeApp.Classes.Core 1.0
import "../Views"
import "../Items"

Rectangle {
    id: albumsPage
    property string currentView: "Table"
    property int currentSortBy: 0
    property int currentSortOrder: Qt.AscendingOrder
    property string searchFieldText: ""
    property bool slideDown: false
    signal sortBy(int currentSortBy)
    signal sortOrder(int currentSortOrder)
    signal search(string searchFieldText)
    anchors.top: parent.top
    anchors.topMargin: 0
    color: "transparent"
    function changeView(view)
    {
        albumsPage.currentView = view
        if(albumsPage.currentView === "Table")
        {
            albumsPageLoader.source = "qrc:/Views/AlbumsTableView.qml"
        }
        if(albumsPage.currentView === "Images")
        {
            albumsPageLoader.source = "qrc:/Views/AlbumsImageView.qml"
        }
    }

    Loader {
        id: albumsPageLoader
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: 40
        anchors.rightMargin: 50
        anchors.bottomMargin: 30
        anchors.leftMargin: 50
        source: "qrc:/Views/AlbumsTableView.qml"
    }

    // Connection
    Connections {
        id: albumsPageSearchConnection
        target: browseSubMenu
        onSubMenuTextChanged: {
            albumsPage.searchFieldText = browseSubMenu.subMenuSearchText
            albumsPage.search(albumsPage.searchFieldText);
        }
    }
}

