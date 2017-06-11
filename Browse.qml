import QtQuick 2.8
import QtQuick.Controls 2.1
import "../Views"
import "../Items"

Item {
    id: browsePage
    property int currentPage: 0
    property bool subMenuVisible: false
    property string subMenuSearchText: ""
    property int selectedOption: 0
    property string cardImageUrl: ""
    property string cardInAlbum: ""
    property string cardCondition: ""
    property string cardStatus: ""
    property int cardID;
    signal rowDoubleClicked(string cardImageUrl)
    signal optionSelected(int selectedOption)
    signal pageChanged(int currentPage)
    signal subMenuVisibilityChanged(bool subMenuVisible)
    signal subMenuTextChanged(string subMenuSearchText)
    function adjustHeight(subMenuVisible)
    {
        if(subMenuVisible === true)
        {
            browsePageSwipeView.y = 40;
        }
        else
        {
            browsePageSwipeView.y = 0;
        }
    }

    BrowseSubMenu {
        id: browseSubMenu
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.topMargin: 0
        anchors.rightMargin: 50
        anchors.leftMargin: 50
    }

    // SWIPVIEW
    SwipeView {
        id: browsePageSwipeView
        y: 0
        height: 880
        width: 1280

        // PAGE 0: AlbumsPage
        AlbumsPage {
            id: albumsPage
            anchors.topMargin: 0
            height: 680
            width: 1280
        }

        // PAGE 1: cardsPage
        CardsPage {
            id: cardsPage
            anchors.topMargin: 0
            height: 680
            width: 1280
        }
        Behavior on y {
            NumberAnimation {
                duration: 600
                easing.type: Easing.OutBounce
            }
        }

    }
    PageIndicator{
        id: browsePageIndicator
        currentIndex: browsePageSwipeView.currentIndex
        onCurrentIndexChanged: {
            browsePage.currentPage = browsePageSwipeView.currentIndex
            pageChanged(browsePage.currentPage)
        }

        // CONNECTIONS
        // Page indicator
        Connections {
            id: applicationWindowConnection
            target: quickNav
            onBrowseSection: {
                browsePageSwipeView.currentIndex = quickNav.activeSection;

            }
        }
        // Search box
        Connections {
            id: searchBoxConnection
            target: browseSubMenu
            onSubMenuTextChanged: {
                browsePage.subMenuSearchText = browseSubMenu.subMenuSearchText;
            }
        }

        // Sub menu choice
        Connections {
            id: subMenuOption
            target: browseSubMenu
            onOptionSelected: {
                browsePage.selectedOption = browseSubMenu.selectedOption;
                browsePage.optionSelected(browseSubMenu.selectedOption);
            }
            onSubMenuVisibilityChanged: {
                browsePage.subMenuVisible = browseSubMenu.subMenuVisible;
                browsePage.adjustHeight(browseSubMenu.subMenuVisible);
            }
        }

        // single card view
        Connections {
            id: singleCardViewBrowse
            target: cardsPage
            onRowDoubleClicked: {
                browsePage.cardImageUrl = cardsPage.cardImageUrl;
                browsePage.cardInAlbum = cardsPage.cardInAlbum;
                browsePage.cardCondition = cardsPage.cardCondition;
                browsePage.cardStatus = cardsPage.cardStatus;
                browsePage.cardID = cardsPage.cardID;
                browsePage.rowDoubleClicked(cardsPage.cardImageUrl);
            }
        }
    }
}
