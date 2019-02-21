import QtQuick 2.0
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.7 as Kirigami
import QtLocation 5.11
import QtPositioning 5.11

Kirigami.ApplicationWindow {
    id: root
    pageStack.initialPage: Kirigami.Page {
        id: page
        bottomPadding: 0
        globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        Kirigami.ColumnView.fillWidth: true

        default property alias content: itemCont.data
        readonly property bool empty: true

        Item {
            id: itemCont
            anchors.fill: parent

            Plugin {
                id: mapPlugin
                name: "osm" // "mapboxgl", "esri", ...
                // specify plugin parameters if necessary
                // PluginParameter {
                //     name:
                //     value:
                // }
            }

            Map {
                anchors.fill: parent
                plugin: mapPlugin
                center: QtPositioning.coordinate(59.91, 10.75) // Oslo
                zoomLevel: 14

            }
        }
    }

    Component.onCompleted: pageStack.push(page2);

    Kirigami.ScrollablePage {
        id: page2

        title: "Buttons"
        Kirigami.ColumnView.fillWidth: false

        Column{
            Repeater {
                model: 3
                delegate: Controls.Label { text: "text " + model.index }
            }
        }
    }
}
