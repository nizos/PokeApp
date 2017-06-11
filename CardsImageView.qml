import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import PokeApp.Classes.Core 1.0
import QtGraphicalEffects 1.0
import "../Delegates"
import "../Pages"

Item {
    id: cardsImageView
    property string searchBoxText: ""
    property int cId: 0
    property string fullScreenCard
    anchors.fill: parent
    z: 15

    // Page
    Rectangle {
        id: imagesArea
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        color: "#FFFFFF"
        radius: 2
        state: "GridView"
        z: 15
        clip: true

        // Cards GridView
        GridView{
            property int cardsInAlbum: albumsManager.getNrOfCards()
            id: cardsGridView
            header:  Rectangle { height: 30 }
            footer: Rectangle {height: 80}
            anchors.top: parent.top
            anchors.bottomMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            width: Math.min(cardsInAlbum, Math.floor(parent.width/cellWidth))*cellWidth
            height: parent.height
            cellHeight: 350
            cellWidth: 253
            clip: true
            z: 20
            delegate: CardsView {id: cardsView}
            model: ProxyModel {
                id: cardsProxyModel
                source: cardsModel.count > 0 ? cardsModel : null

                sortOrder: tableView.sortIndicatorOrder
                sortCaseSensitivity: Qt.CaseInsensitive
                sortRole: cardsModel.count > 0 ? tableView.getColumn(tableView.sortIndicatorColumn).role : ""

                filterString: "*" + cardsImageView.searchBoxText + "*"
                filterSyntax: ProxyModel.Wildcard
                filterCaseSensitivity: Qt.CaseInsensitive
            }
        }



        Item {
            Connections {
                target: albumsManager
                onCardAdded:
                {
                    cardsGridView.cardsInAlbum = albumsManager.getNrOfCards(applicationWindow.currentAlbum);
                }
                onCardRemoved:
                {
                    cardsGridView.cardsInAlbum = albumsManager.getNrOfCards(applicationWindow.currentAlbum);
                }
            }
        }
        // Connection
        Connections {
            id: cardsImageSortByConnection
            target: cardsPage
            onSortBy: {
//                print("onSortyBy received signal: " + cardsPage.currentSortBy);
                cardsTabelView.sortIndicatorColumn = cardsPage.currentSortBy;
            }
        }
        Connections {
            id: cardsImageSortOrderConnection
            target: cardsPage
            onSortOrder: {
//                print("onSortOrder received signal: " + cardsPage.currentSortOrder);
                cardsTabelView.sortIndicatorOrder = cardsPage.currentSortOrder;
            }
        }
    }

    DropShadow {
        anchors.fill: imagesArea
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: imagesArea
        z: 3
    }

    // Connection
    Connections {
        id: cardsImageViewConnection
        target: cardsPage
        onSearch: {
            cardsImageView.searchBoxText = cardsPage.searchFieldText
        }
    }
}
