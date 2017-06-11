import QtQuick 2.7
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.2
import PokeApp.Classes.Core 1.0
import "../"

Item {
    id: albumsTableView
    property string searchBoxText: ""
    z: 20

    Rectangle {
        id: tableArea
        anchors.fill: parent
        color: "#FFFFFF"
        radius: 2

        TableView {
            id: tableView
            objectName: "albumsModel"
            frameVisible: false
            sortIndicatorVisible: true
            z: 20
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            style: TableViewStyle  {
                headerDelegate: Rectangle {
                    height: 30
                    width: headerTextItem.implicitWidth
                    color: "#FFFFFF"
                    Text {
                        id: headerTextItem
                        anchors.fill: parent
                        font.family: "Quicksand"
                        font.pointSize: 12
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: styleData.textAlignment
                        anchors.leftMargin: 6
                        text: styleData.value
                        elide: Text.ElideRight
                        color: "#474747"
                        renderType: Text.NativeRendering
                    }
                    Rectangle {
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 1
                        anchors.topMargin: 1
                        width: 1
                        color: "#ccc"
                    }
                }
                rowDelegate: Rectangle {
                    color: styleData.selected ? "#63beff" : (styleData.alternate? "#f4f4f4" : "#fff")
                }
            }

            TableViewColumn {
                id: albumNameRole
                role: "albumName"
                title: "Name"
                width: 180
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }
            TableViewColumn {
                title: "Cards in album"
                width: 140
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: albumsManager.getNrOfCards(model.ID);
                }

            }
            TableViewColumn {
                role: "albumAdded"
                title: "Created"
                width: 180
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: Qt.formatDateTime(albumsManager.getAlbumAdded(model.ID),'dd/MMM/yy HH:mm')
                }
            }
            TableViewColumn {
                role: "albumEdited"
                title: "Last modified"
                width: 180
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: Qt.formatDateTime(albumsManager.getAlbumEdited(model.ID),'dd/MMM/yy HH:mm')
                }
            }
            model: ProxyModel {
                id: albumsProxyModel
                source: albumsModel.count > 0 ? albumsModel : null

                sortOrder: tableView.sortIndicatorOrder
                sortCaseSensitivity: Qt.CaseInsensitive
                sortRole: albumsModel.count > 0 ? tableView.getColumn(tableView.sortIndicatorColumn).role : ""
                filterString: "*" + albumsTableView.searchBoxText + "*"
                filterSyntax: ProxyModel.Wildcard
                filterCaseSensitivity: Qt.CaseInsensitive
            }
        }
    }
    DropShadow {
        id: tableAreaShadow
        anchors.fill: tableArea
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: tableArea
        z: 3
    }
    // Connection
    Connections {
        id: albumsTableViewConnection
        target: albumsPage
        onSearch: {
            albumsTableView.searchBoxText = albumsPage.searchFieldText
        }
    }
}
