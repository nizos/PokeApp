import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: browseSubMenu
    property string subMenuSearchText: ""
    property bool subMenuVisible: false
    property int fieldHeight: parent.height
    property int fieldWidth: parent.width
    property int selectedOption: 0
    signal optionSelected(int selectedOption)
    signal subMenuTextChanged(string subMenuSearchText)
    signal subMenuVisibilityChanged(bool subMenuVisible)
    height: fieldHeight
    width: fieldWidth
    z:80

    Rectangle {
        id: subMenu
        radius: 2
        height: 30
        color: "#FFFFFF"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left

        RowLayout {
            id: subMenuRow
            anchors.fill: parent

            // VIEW
            Rectangle {
                id: changeViewButton
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumWidth: 60
                z: 35
                Text {
                    text: "View"
                    color: "#474747"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(viewSubMenu.showSubMenu === false)
                        {
                            viewSubMenu.showSubMenu = true;
                            viewSubMenu.visible = true;
                            viewSubMenu.enabled = true;
                            browseSubMenu.subMenuVisible = true;
                            browseSubMenu.subMenuVisibilityChanged(browseSubMenu.subMenuVisible);
                            viewSubMenu.y = (viewSubMenu.y + 40);
                        }
                        else
                        {
                            viewSubMenu.showSubMenu = false;
                            viewSubMenuTimer.restart();
                            viewSubMenu.enabled = false;
                            browseSubMenu.subMenuVisible = false;
                            browseSubMenu.subMenuVisibilityChanged(browseSubMenu.subMenuVisible);
                            viewSubMenu.y = (viewSubMenu.y - 40)
                        }
                    }
                }

            }

            // SORT
            Rectangle {
                id: changeSortButton
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumWidth: 60
                z: 35
                Text {
                    text: "Sort"
                    color: "#474747"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(viewSubMenu.showSubMenu === false)
                        {
                            viewSubMenu.showSubMenu = true;
                            viewSubMenu.visible = true;
                            viewSubMenu.enabled = true;
                            browseSubMenu.subMenuVisible = true;
                            browseSubMenu.subMenuVisibilityChanged(browseSubMenu.subMenuVisible);
                            viewSubMenu.y = (viewSubMenu.y + 40);
                        }
                        else
                        {
                            viewSubMenu.showSubMenu = false;
                            viewSubMenuTimer.restart();
                            viewSubMenu.enabled = false;
                            browseSubMenu.subMenuVisible = false;
                            browseSubMenu.subMenuVisibilityChanged(browseSubMenu.subMenuVisible);
                            viewSubMenu.y = (viewSubMenu.y - 40)
                        }
                    }
                }
            }



            // SEARCH
            Rectangle {
                id: searchToolBar
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumWidth: 400
                Layout.rightMargin: 20
                z: 35
                TextField {
                    id: searchBox
                    z: 35
                    placeholderText: "Search..."
                    inputMethodHints: Qt.ImhNoPredictiveText

                    width: 400
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    onTextChanged: {
                        browseSubMenu.subMenuSearchText = searchBox.text
                        browseSubMenu.subMenuTextChanged(browseSubMenu.subMenuSearchText);
//                        print("searchTextChanged signal sent: " << browseSubMenu.searchText)
                    }
                }

            }
        }

    }

    // VIEW SUB MENU
    ViewSubMenu {
        id: viewSubMenu
        property bool showSubMenu: false
        visible: false
        enabled: false
        focus: false
        y: 0
        Timer {
            id: viewSubMenuTimer
            interval: 600
            repeat: false
            running: false
            onTriggered: {
                viewSubMenu.visible = false;
            }
        }
        Behavior on y {
            NumberAnimation {
                duration: 600
                easing.type: Easing.OutBounce
            }
        }
    }


    DropShadow {
        anchors.fill: subMenu
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: subMenu
        z: 3
    }

    // CONNECTIONS
    // Sub menu choice
    Connections {
        id: subMenuOption
        target: viewSubMenu
        onOptionSelected: {
            browseSubMenu.selectedOption = viewSubMenu.selectedOption;
            browseSubMenu.optionSelected(viewSubMenu.selectedOption);
            console.log("BrowseSubMenu received signal from viewSubMenu option: " + browseSubMenu.selectedOption);
        }
    }

}
