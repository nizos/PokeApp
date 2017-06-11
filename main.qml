import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import Qt.labs.platform 1.0
import "./Pages"
import "./Items"
import "./Views"

// Main application window
ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1280
    height: 880
    flags: (Qt.Window |  Qt.FramelessWindowHint);
    title: qsTr("PokéManager")
    color: "Transparent"
    property int indexC: 0
    property int receivedValue: 0
    property int currentAlbum: 0
    property bool showingCard: false
    property int cardID
    property string cardImageURL: ""
    property string cardInAlbum: ""
    property string cardCondition: ""
    property string cardStatus: ""
    signal message(int indexC)

    // Icons font loader
    FontLoader {
        id: fontAwesome;
        source: "qrc:/Icons/Icons/fontawesome-webfont.ttf"
    }

    // Window borders
    Rectangle {
        id: bottomBorder
        color: "#474747"
        height: 1
        width: parent.width
        anchors.bottom: parent.bottom
        z:40
    }
    Rectangle {
        id: leftBorder
        color: "#474747"
        width: 1
        anchors.left: parent.left
        anchors.top: titleBar.bottom
        anchors.bottom: bottomBorder.top
        z:40
    }
    Rectangle {
        id: rightBorder
        color: "#474747"
        width: 1
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: bottomBorder.top
        z:40
    }

    // Loader: Single page view
    Loader {
            id: viewSingleCardLoader
            focus: true
            visible: false
            height: parent.height
            width: parent.width
            anchors.top: parent.top
            anchors.left: parent.left
            source: "qrc:/Views/SingleCardView.qml"
            z: 35
        }

    // Title bar
    TitleBar {
        id: titleBar
        height: 20
        container: applicationWindow
    }


    // Window area
    Page {
        id: window
        property int sideBarWidth: 300
        property int sideBarPos: -sideBarWidth
        property int currentPage: 0

        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: bottomBorder.top

        function showSideBar(i)
        {
            if(i === 0)
            {
                window.sideBarPos = -window.sideBarWidth
                viewMouseArea.zIndex = 1;
            }
            else
            {
                window.sideBarPos = 0
                viewMouseArea.zIndex = 3;
            }
        }

        // Header
        MainBar
        {
            id: mainBar
            color: "#FFFFFF"
            height: 60
            width: parent.width
            anchors.top: parent.top
            z:3
        }
        DropShadow {
            anchors.fill: mainBar
            horizontalOffset: 0
            verticalOffset: 1
            radius: 8.0
            samples: 17
            color: "#22000000"
            source: mainBar
            z: 2
        }

        // SIDEBAR
        SideBar
        {
            id: sideBar
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: window.sideBarWidth
            visible: true
            x: window.sideBarPos
            z:50
            MouseArea {
                anchors.fill: parent
                onClicked: window.showSideBar(1)
            }

            // ANIMATION
            Behavior on x { NumberAnimation { duration: 300; easing.type: Easing.OutQuart } }
        }

        // Top shadow
        DropShadow {
            anchors.top: sideBar.top
            anchors.right: sideBar.right
            anchors.bottom: mainBar.bottom
            anchors.left: sideBar.left
            horizontalOffset: 1
            verticalOffset: 0
            radius: 5.0
            samples: 17
            color: "#22000000"
            source: sideBar
            z: 8
        }

        //  Bottom shadow
        DropShadow {
            anchors.top: mainBar.bottom
            anchors.right: sideBar.right
            anchors.bottom: sideBar.bottom
            anchors.left: sideBar.left
            horizontalOffset: 2
            verticalOffset: 1
            radius: 8.0
            samples: 17
            color: "#22000000"
            source: sideBar
            z: 5
        }

        // PAGE WINDOW
        Rectangle {
            id: view
            z:1
            color: "#F6F7FB"
            anchors.top: mainBar.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            width: parent.width
            MouseArea {
                id: viewMouseArea
                property int zIndex: 1
                anchors.fill: parent
                onClicked: window.showSideBar(0);
                z:viewMouseArea.zIndex;
            }


            // QUICK NAV
            QuickNav{
                id: quickNav
                color: "Transparent"
                height: 30
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
            }

            // SWIPVIEW
            SwipeView {
                id: swipeView
                signal message(int indexC)
                anchors.top: quickNav.bottom
                anchors.left: view.left
                anchors.right: view.right
                anchors.bottom: view.bottom
                anchors.topMargin: 10
                currentIndex: window.currentPage
                z:2

                // PAGE 0: HOMEPAGE
                HomePage {
                    id: homePage
                }

                // PAGE 1: BROWSE
                Browse {
                    id: browsePage
                }
            }
            PageIndicator{
                id: pageIndicator
                currentIndex: swipeView.currentIndex
                onCurrentIndexChanged: {
                    applicationWindow.indexC = currentIndex
                    message(applicationWindow.indexC)
                }
            }
        }

    }
    // Connection: Page indicator
    Connections {
        id: applicationWindowConnection
        target: quickNav
        onMessage: {
            swipeView.currentIndex = quickNav.indexC

        }
    }

    // Connection: Single card view
    Connections {
        id: cardsTableConnection
        target: browsePage
        onRowDoubleClicked: {
            applicationWindow.cardImageURL = browsePage.cardImageUrl;
            applicationWindow.cardInAlbum = browsePage.cardInAlbum;
            applicationWindow.cardCondition = browsePage.cardCondition;
            applicationWindow.cardStatus = browsePage.cardStatus;
            applicationWindow.cardID = browsePage.cardID;
            viewSingleCardLoader.visible = true;
            viewSingleCardLoader.item.opacity = 1;
            viewSingleCardLoader.item.imageURL = browsePage.cardImageUrl;
            viewSingleCardLoader.item.cardInAlbum = browsePage.cardInAlbum;
            viewSingleCardLoader.item.cardCondition = browsePage.cardCondition;
            viewSingleCardLoader.item.cardStatus = browsePage.cardStatus;
            viewSingleCardLoader.item.cardID = browsePage.cardID;
        }
    }
}
