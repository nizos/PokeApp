import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: quickNav
    color: "Transparent"
    height: 30
    anchors.topMargin: 30
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    z: 4
    property int receivedValue: 0
    property int currentPage: 0
    property int indexC: 0
    property int activeSection: 0
    signal message(int indexC)
    signal browseSection(int activeSection)
    signal addNewCardBarVisibilityChanged(bool slideDown)
    function toggleIcons(i)
    {
        quickNav.currentPage = i;
        if(quickNav.currentPage == 0)
        {
            myRect1.active = false;
            myRect2.active = false;
        }
        if(quickNav.currentPage == 1)
        {
            myRect1.active = true;
            myRect2.active = false;
        }
        if(quickNav.currentPage == 2)
        {
            myRect1.active = false;
            myRect2.active = true;
        }
    }
    Behavior on height {
        NumberAnimation {
            duration: 600
            easing.type: Easing.OutBounce
        }
    }

    Row {
        id: quickNavRow
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0
        z: 4


        // ALBUMS BUTTON
        Rectangle {
            id: myRect1
            property bool active: false
            height: 30
            width: 120
            color: "Transparent"
            z: 7
            Rectangle {
                id: roundRect
                color: myRect1.active == true? "#d6d6d6" : "#FFFFFF"
                height: 30
                width: 120
                radius: 2
                z: 7
                Text {
                    id: albumsIconA
                    text: "\uf02d"
                    color: "#474747"
                    font.pointSize: 12
                    font.family: fontAwesome.name
                    anchors.top: parent.top
                    anchors.topMargin: 6
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                }
                Text {
                    id: albumsIconText
                    text: "Albums"
                    color: "#474747"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    anchors.left: albumsIconA.right
                    anchors.leftMargin: 6
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        quickNav.indexC = 1;
                        quickNav.activeSection = 0;
                        message(quickNav.indexC);
                        browseSection(quickNav.activeSection);
                        quickNav.toggleIcons(1);
                    }
                }
            }
            DropShadow {
                anchors.fill: roundRect
                horizontalOffset: 0
                verticalOffset: 1
                radius: 5.0
                samples: 17
                color: "#22000000"
                source: roundRect
                visible: !myRect1.active
                z: 2
            }
            Rectangle {
                id: squareRect
                color: myRect1.active == true? "#d6d6d6" : "#FFFFFF"
                width: roundRect.radius
                anchors.bottom: roundRect.bottom
                anchors.top: roundRect.top
                anchors.right: roundRect.right
                z: 7

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        quickNav.indexC = 1;
                        quickNav.activeSection = 0;
                        message(quickNav.indexC);
                        browseSection(quickNav.activeSection);
                        quickNav.toggleIcons(1);
                    }
                }
            }
            DropShadow {
                anchors.fill: squareRect
                horizontalOffset: 0
                verticalOffset: 1
                radius: 5.0
                samples: 17
                color: "#22000000"
                source: squareRect
                visible: !myRect1.active
                z: 2
            }
        }

        // CARDS BUTTON
        Rectangle {
            id: myRect2
            property bool active: false
            height: 30
            width: 120
            color: "Transparent"
            z: 7
            Rectangle {
                id: roundRect2
                color: myRect2.active == true? "#d6d6d6" : "#FFFFFF"
                height: 30
                width: 120
                radius: 2
                z: 7
                Text {
                    id: cardsIconA
                    text: "\uf00a"
                    color: "#474747"
                    font.pointSize: 10
                    font.family: fontAwesome.name
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    anchors.left: parent.left
                    anchors.leftMargin: 25
                    transform: Rotation { origin.x: (cardsIconA.width/2); origin.y: (cardsIconA.height/2); angle: 90}
                }
                Text {
                    id: cardsIconText
                    text: "Cards"
                    color: "#474747"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    anchors.left: cardsIconA.right
                    anchors.leftMargin: 6
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled : true
                    onClicked: {
                        quickNav.indexC = 1;
                        quickNav.activeSection = 1;
                        message(quickNav.indexC);
                        browseSection(quickNav.activeSection);
                        quickNav.toggleIcons(2);
                    }
                }
            }
            DropShadow {
                anchors.fill: roundRect2
                horizontalOffset: 0
                verticalOffset: 1
                radius: 5.0
                samples: 17
                color: "#22000000"
                source: roundRect2
                visible: !myRect2.active
                z: 2
            }
            Rectangle {
                id: squareRect2
                color: myRect2.active == true? "#d6d6d6" : "#FFFFFF"
                width: roundRect2.radius
                anchors.bottom: roundRect2.bottom
                anchors.top: roundRect2.top
                anchors.left: roundRect2.left
                z: 7
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        quickNav.indexC = 1;
                        quickNav.activeSection = 1;
                        message(quickNav.indexC);
                        browseSection(quickNav.activeSection);
                        quickNav.toggleIcons(2);
                    }
                }
            }
            DropShadow {
                anchors.fill: squareRect2
                horizontalOffset: 0
                verticalOffset: 1
                radius: 5.0
                samples: 17
                color: "#22000000"
                source: squareRect2
                visible: !myRect2.active
                z: 2
            }
        }
    }
    // HOMEPAGE BUTTON
    Rectangle {
        id: leftNav
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 50
        color: "#FFFFFF"
        height: 30
        width: 100
        radius: 2
        z: 7
        Text {
            id: homeIconA
            text: "\uf015"
            color: "#474747"
            font.pointSize: 12
            font.family: fontAwesome.name
            anchors.top: parent.top
            anchors.topMargin: 7
            anchors.left: parent.left
            anchors.leftMargin: 14
        }
        Text {
            id: homeIconText
            text: "Home"
            color: "#474747"
            font.pointSize: 12
            font.family: "Quicksand"
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.left: homeIconA.right
            anchors.leftMargin: 10
        }

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onClicked: swipeView.currentIndex = 0;
        }
    }
    DropShadow {
        anchors.fill: leftNav
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: leftNav
        z: 3
    }


    // ADD NEW BUTTON
    Rectangle {
        id: rightNav
        property bool showAddBar: false
        color: "#FFFFFF"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 50
        height: 30
        width: 100
        radius: 2
        z: 7
        Text {
            id: newIconA
            text: "\uf067"
            color: "#474747"
            font.pointSize: 12
            font.family: fontAwesome.name
            anchors.top: parent.top
            anchors.topMargin: 7
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
        Text {
            id: newIconText
            text: "New"
            color: "#474747"
            font.pointSize: 12
            font.family: "Quicksand"
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.left: newIconA.right
            anchors.leftMargin: 10
        }
        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onClicked: {
                if(quickNav.currentPage === 2)
                {
                    if(rightNav.showAddBar === false)
                    {
                        rightNav.showAddBar = true;
                        addNewCardBarloader.source = "AddNewCard.qml"
                        quickNav.height = 80
                        addNewCardBarloader.y = (addNewCardBarloader.y + 50)
                        addNewCardBarHider.z = 1
                    }
                    else if(rightNav.showAddBar === true)
                    {
                        rightNav.showAddBar = false;
                        addNewCardBarloader.height = 0
                        quickNav.height = 30
                        addNewCardBarloader.y = (addNewCardBarloader.y - 50)
                        addNewCardBarHider.z = 4

                    }
                }
                else if(quickNav.currentPage === 1)
                {
                    if(rightNav.showAddBar === false)
                    {
                        rightNav.showAddBar = true;
                        addNewCardBarloader.source = "AddNewAlbum.qml"
                        quickNav.height = 80
                        addNewCardBarloader.y = (addNewCardBarloader.y + 50)
                        addNewCardBarHider.z = 1
                    }
                    else if(rightNav.showAddBar === true)
                    {
                        rightNav.showAddBar = false;
                        addNewCardBarloader.height = 0
                        quickNav.height = 30
                        addNewCardBarloader.y = (addNewCardBarloader.y - 50)
                        addNewCardBarHider.z = 4

                    }
                }


            }
        }

    }
    Rectangle {
        id: addNewCardBarHider
        property bool isVisible: true
        color: "#F6F7FB"
        y: rightNav.y - 30
        anchors.right: parent.right
        anchors.rightMargin: 45
        height: 60
        width: 410
        radius: 0
        z: 4
    }

    DropShadow {
        anchors.fill: rightNav
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: rightNav
        z: 5
    }


    Loader {
        id: addNewCardBarloader
        focus: true
        height: 30
        width: 400
        y: rightNav.y - 10
        anchors.right: rightNav.right
        Behavior on y {
            NumberAnimation {
                duration: 600
                easing.type: Easing.OutBounce
            }
        }

    }


    // Connection
    Connections {
        id: quickNavConnecttion
        target: pageIndicator
        onCurrentIndexChanged: {
            quickNav.receivedValue = applicationWindow.indexC
            quickNav.toggleIcons(applicationWindow.indexC)
        }
    }
    Connections {
        id: quickNavBrowseConnecttion
        target: browsePage
        onPageChanged: {
            quickNav.toggleIcons(browsePage.currentPage+1)
        }
    }
}
