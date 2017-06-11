import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../Pages"

Item {
    id: sortSubMenu
    width: subMenu.width
    height: 40
    anchors.top: subMenu.bottom
    anchors.topMargin: 30
    z: 2

    Rectangle {
        id: sortSubMenuBanner
        radius: 2
        height: 40
        width: parent.width
        color: "#FFFFFF"
        RowLayout {
            id: viewRow
            height: 40
            width: parent.width
            spacing: 0

            // NAME
            Rectangle {
                id: sortByNameButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Name"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
//                        print("name clicked");
                        if(cardsPage.currentSortBy !== 0)
                        {
                            cardsPage.currentSortBy = 0;
                            cardsPage.sortBy(cardsPage.currentSortBy);
//                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortByNameButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByNameButton.ascendingOrder = true;
//                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByNameButton.ascendingOrder = false;
//                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // CONDITION
            Rectangle {
                id: sortByConditionButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Condition"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
//                        print("condition clicked");
                        if(cardsPage.currentSortBy != 1)
                        {
                            cardsPage.currentSortBy = 1;
                            cardsPage.sortBy(cardsPage.currentSortBy);
//                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortByConditionButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByConditionButton.ascendingOrder = true;
//                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByConditionButton.ascendingOrder = false;
//                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // STATUS
            Rectangle {
                id: sortByStatusButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Status"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
//                        print("status clicked");
                        if(cardsPage.currentSortBy != 2)
                        {
                            cardsPage.currentSortBy = 2;
                            cardsPage.sortBy(cardsPage.currentSortBy);
//                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortByStatusButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByStatusButton.ascendingOrder = true;
//                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByStatusButton.ascendingOrder = false;
//                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // ALBUM
            Rectangle {
                id: sortByAlbumMIDButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Album name"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
//                        print("albumMID clicked");
                        if(cardsPage.currentSortBy != 3)
                        {
                            cardsPage.currentSortBy = 3;
                            cardsPage.sortBy(cardsPage.currentSortBy);
//                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortByAlbumMIDButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByAlbumMIDButton.ascendingOrder = true;
//                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByAlbumMIDButton.ascendingOrder = false;
//                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // CARD ID
            Rectangle {
                id: sortByCardIDButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Card ID"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        print("cardID clicked");
                        if(cardsPage.currentSortBy != 4)
                        {
                            cardsPage.currentSortBy = 4;
                            cardsPage.sortBy(cardsPage.currentSortBy);
                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortByCardIDButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByCardIDButton.ascendingOrder = true;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByCardIDButton.ascendingOrder = false;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // SUBTYPE
            Rectangle {
                id: sortBySubtypeButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Subtype"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        print("subtype clicked");
                        if(cardsPage.currentSortBy != 5)
                        {
                            cardsPage.currentSortBy = 5;
                            cardsPage.sortBy(cardsPage.currentSortBy);
                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortBySubtypeButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortBySubtypeButton.ascendingOrder = true;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortBySubtypeButton.ascendingOrder = false;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // SUPERTYPE
            Rectangle {
                id: sortBySupertypeButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Supertype"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        print("supertype clicked");
                        if(cardsPage.currentSortBy != 6)
                        {
                            cardsPage.currentSortBy = 6;
                            cardsPage.sortBy(cardsPage.currentSortBy);
                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortBySupertypeButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortBySupertypeButton.ascendingOrder = true;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortBySupertypeButton.ascendingOrder = false;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // ARTIST
            Rectangle {
                id: sortByArtistButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Artist"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        print("artist clicked");
                        if(cardsPage.currentSortBy != 7)
                        {
                            cardsPage.currentSortBy = 7;
                            cardsPage.sortBy(cardsPage.currentSortBy);
                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortByArtistButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByArtistButton.ascendingOrder = true;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByArtistButton.ascendingOrder = false;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // RARITY
            Rectangle {
                id: sortByRarityButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Rarity"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        print("rarity clicked");
                        if(cardsPage.currentSortBy != 8)
                        {
                            cardsPage.currentSortBy = 8;
                            cardsPage.sortBy(cardsPage.currentSortBy);
                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortByRarityButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByRarityButton.ascendingOrder = true;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByRarityButton.ascendingOrder = false;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // SERIES
            Rectangle {
                id: sortBySeriesButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Series"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        print("series clicked");
                        if(cardsPage.currentSortBy != 9)
                        {
                            cardsPage.currentSortBy = 9;
                            cardsPage.sortBy(cardsPage.currentSortBy);
                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortBySeriesButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortBySeriesButton.ascendingOrder = true;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortBySeriesButton.ascendingOrder = false;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // SET
            Rectangle {
                id: sortBySetNameButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Set"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        print("setName clicked");
                        if(cardsPage.currentSortBy != 10)
                        {
                            cardsPage.currentSortBy = 10;
                            cardsPage.sortBy(cardsPage.currentSortBy);
                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortBySetNameButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortBySetNameButton.ascendingOrder = true;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortBySetNameButton.ascendingOrder = false;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // ADDED ON
            Rectangle {
                id: sortByCardAddedButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Added on"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        print("cardAdded clicked");
                        if(cardsPage.currentSortBy != 11)
                        {
                            cardsPage.currentSortBy = 11;
                            cardsPage.sortBy(cardsPage.currentSortBy);
                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortByCardAddedButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByCardAddedButton.ascendingOrder = true;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByCardAddedButton.ascendingOrder = false;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

            // EDITED ON
            Rectangle {
                id: sortByCardEditedButton
                property bool ascendingOrder: false
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Last edited"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        print("cardEdited clicked");
                        if(cardsPage.currentSortBy != 12)
                        {
                            cardsPage.currentSortBy = 12;
                            cardsPage.sortBy(cardsPage.currentSortBy);
                            print("Signal cardsPage.sortBy(" << cardsPage.currentSortBy << ") sent");
                        }
                        if(sortByCardEditedButton.ascendingOrder === false)
                        {
                            cardsPage.currentSortOrder = Qt.AscendingOrder;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByCardEditedButton.ascendingOrder = true;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                        else
                        {
                            cardsPage.currentSortOrder = Qt.DescendingOrder ;
                            cardsPage.sortOrder(cardsPage.currentSortOrder);
                            sortByCardEditedButton.ascendingOrder = false;
                            print("Signal cardsPage.sortOrder(" << cardsPage.currentSortOrder << ") sent");
                        }
                    }
                }
            }

        }
    }
    DropShadow {
        anchors.fill: sortSubMenuBanner
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: sortSubMenuBanner
        z: 3
    }
}


