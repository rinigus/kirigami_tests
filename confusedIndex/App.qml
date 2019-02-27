import QtQuick 2.9
import QtQuick.Controls 2.2 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.7 as Kirigami
import QtLocation 5.11
import QtPositioning 5.11

Kirigami.ApplicationWindow {
    id: root
    pageStack.initialPage:  Kirigami.ScrollablePage {
        title: "init"
        Column{
            Repeater {
                model: 3
                delegate: Controls.Label { text: "text " + model.index }
            }
        }
    }

    property var dynpage

    Kirigami.Page {
        id: pagemap
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

                Controls.Button {
                    text: "CLICK ME"
                    anchors.centerIn: parent
                    onClicked: {
                        if (!dynpage) {
                            var pc = Qt.createComponent(Qt.resolvedUrl("PageOne.qml"));
                            dynpage = pc.createObject(root)
                        }
                        pageStack.push(dynpage);
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("Replacing page. Depth: " + pageStack.depth + " / currentIndex: " + pageStack.currentIndex)
        pageStack.replace(pagemap)
        console.log("Page replaced")
    }

    Connections {
        target: pageStack
        onCurrentIndexChanged: root.processCurrentIndex()
        onDepthChanged: console.log("Depth changed: " + pageStack.depth)
    }

    function processCurrentIndex() {
        console.log("currentIndex changed: " + pageStack.currentIndex + " / depth: " + pageStack.depth)
        if (pageStack.currentIndex === 0 && pageStack.depth > 1) {
            pageStack.pop(pageStack.get(0));
        }
    }
}
