import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.XmlListModel 2.0
import QtQuick.Window 2.1
import QtCharts 2.2
import "../Delegates"

// PAGE 0: HOMEPAGE
Rectangle {
    id: homePage
    color: "#F6F7FB"
    z: 2

    // STATS CARD
    Rectangle {
        id: stats
        color: "#FFFFFF"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 0
        anchors.leftMargin: 50
        width: 700
        height: 400
        radius: 2
        z:2
        Text {
            id: statsIconA
            text: "\uf200"
            color: "#777777"
            font.pointSize: 10
            font.family: fontAwesome.name
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
        Text {
            id: statsIconText
            text: "Quick stats"
            color: "#777777"
            font.pointSize: 10
            font.family: "Quicksand"
            anchors.top: parent.top
            anchors.topMargin: 4
            anchors.left: statsIconA.right
            anchors.leftMargin: 6
        }
        Rectangle {
            id: statsCardSplitter
            height: 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 24
            color: "#d6d6d6"
        }
        ChartView {
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 300
            height: 200
            theme: ChartView.ChartThemeBlueNcs
            plotAreaColor: "#F6F7FB"
            antialiasing: true

            StackedBarSeries  {

                id: pieSeries
                axisX: BarCategoryAxis { categories: ["Base", "Gen", "Origins", "Sun & Moon"] }
                BarSet  { label: "Base Set"; values: [5, 1, 2, 4, 1, 7] }
                BarSet { label: "Generations"; values: [5, 1, 2, 4, 1, 7] }
                BarSet { label: "Ancient Origins"; values: [3, 5, 8, 13, 5, 8] }
                BarSet { label: "Sun & Moon"; values: [2, 1, 3, 5, 1, 6] }
            }
        }
    }
    DropShadow {
        anchors.fill: stats
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: stats
        z: 2
    }

    // NEWS CARD
    Rectangle {
        id: quickFeed
        color: "#FFFFFF"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: stats.right
        anchors.leftMargin: 30
        anchors.topMargin: 0
        anchors.rightMargin: 50
        height: 400
        radius: 2
        z:2
        Text {
            id: newsIconA
            text: "\uf1ea"
            color: "#777777"
            font.pointSize: 10
            font.family: fontAwesome.name
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
        Text {
            id: newsIconText
            text: "News feed"
            color: "#777777"
            font.pointSize: 10
            font.family: "Quicksand"
            anchors.top: parent.top
            anchors.topMargin: 4
            anchors.left: newsIconA.right
            anchors.leftMargin: 6
        }
        Rectangle {
            id: newsFeedCardSplitter
            height: 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 24
            color: "#d6d6d6"
        }
        ListView {
            id: newsList

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 24
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.bottomMargin: 10
            clip: true
            model: feedModel
            header: Rectangle{ width: parent.width; height: 10; color: "Transparent"}
            delegate: NewsDelegate {}
        }
        XmlListModel {
            id: feedModel
            source: "http://pokemondb.net/news/feed"
            query: "/rss/channel/item"
            XmlRole { name: "title"; query: "title/string()" }
            XmlRole { name: "link"; query: "link/string()" }
        }

    }
    DropShadow {
        anchors.fill: quickFeed
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: quickFeed
        z: 2
    }

    // ALBUMS SCROLL
    Rectangle {
        width: 47
        anchors.left: parent.left
        anchors.top: quickFeed.bottom
        height: scrollFeed.height
        color:  "#F6F7FB"
        z: 3
    }
    Rectangle {
        width: 47
        anchors.right: parent.right
        anchors.top: quickFeed.bottom
        height: scrollFeed.height
        color:  "#F6F7FB"
        z: 3
    }
    Rectangle{
        id: scrollFeed
        width: parent.width
        anchors.top: quickFeed.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 30
        height: 250
        color: "transparent"
        clip: true
        z:2

        ListView {
            z:2
            width: parent.width
            height: 150
            spacing: 200
            orientation: ListView.Horizontal
            model: albumsModel
            delegate: CardDelegate {}
            header: Rectangle{
                color: "transparent"
                width: 50
            }
            footer: Rectangle{
                color: "transparent"
                width: 230
            }
        }
    }
}
