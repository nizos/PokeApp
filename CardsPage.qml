import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import PokeApp.Classes.Core 1.0
import "../Views"
import "../Items"

Rectangle {
    id: cardsPage
    property int currentView: 0
    property int currentSortBy: 0
    property int currentSortOrder: Qt.AscendingOrder
    property string searchFieldText: ""
    property bool slideDown: false
    property string cardImageUrl: ""
    property string cardInAlbum: ""
    property string cardCondition: ""
    property string cardStatus: ""
    property int cardID
    signal rowDoubleClicked(string cardImageUrl)
    signal cardSelected(string cardImageUrl)
    signal sortBy(int currentSortBy)
    signal sortOrder(int currentSortOrder)
    signal search(string searchFieldText)
    anchors.top: parent.top
    anchors.topMargin: 0
    color: "transparent"
    function changeView(view)
    {
        if(cardsPage.currentView === 0)
        {
            cardsPageLoader.source = "qrc:/Views/CardsTableView.qml"
        }
        if(cardsPage.currentView === 1)
        {
            cardsPageLoader.source = "qrc:/Views/CardsImageView.qml"
        }
    }

    Loader {
        id: cardsPageLoader
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: 40
        anchors.rightMargin: 50
        anchors.bottomMargin: 30
        anchors.leftMargin: 50
        source: "qrc:/Views/CardsTableView.qml"
    }

    // Connection
    Connections {
        id: cardsPageSearchConnection
        target: browseSubMenu
        onSubMenuTextChanged: {
            cardsPage.searchFieldText = browseSubMenu.subMenuSearchText
            cardsPage.search(cardsPage.searchFieldText);
        }
    }
    Connections {
        id: cardsPageSlideDown
        target: quickNav
        onAddNewCardBarVisibilityChanged: {
            cardsPage.anchors.topMargin = 100
        }
    }

    // Get double clicked row from cardsTableView and send imageURL to main
    Connections {
        id: cardsPageRowDoubleClicked
        target: cardsPageLoader.item
        onRowDoubleClicked: {
            cardsPage.cardImageUrl = cardsPageLoader.item.cardImageUrl;
            cardsPage.cardInAlbum = cardsPageLoader.item.cardInAlbum;
            cardsPage.cardCondition = cardsPageLoader.item.cardCondition;
            cardsPage.cardStatus = cardsPageLoader.item.cardStatus;
            cardsPage.cardID = cardsPageLoader.item.cardID;
            cardsPage.cardSelected(cardsPage.cardImageUrl);
        }
    }

    // Sub menu choice
    Connections {
        id: changeViewConnection
        target: browsePage
        onOptionSelected: {
            cardsPage.currentView = browsePage.selectedOption;
            cardsPage.changeView(browsePage.selectedOption);
        }
    }
    // Sub menu choice
    Connections {
        id: tableRowSelectionLoader
        target: cardsPageLoader.item
        onRowDoubleClicked: {
            cardsPage.cardImageUrl = cardsPageLoader.item.cardImageUrl;
            cardsPage.cardInAlbum = cardsPageLoader.item.cardInAlbum;
            cardsPage.cardCondition = cardsPageLoader.item.cardCondition;
            cardsPage.cardStatus = cardsPageLoader.item.cardStatus;
            cardsPage.cardID = cardsPageLoader.item.cardID;
            cardsPage.rowDoubleClicked(cardsPageLoader.item.cardImageUrl);
        }
    }
}
