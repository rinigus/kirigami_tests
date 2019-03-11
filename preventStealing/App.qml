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
        title: "You should not see this title"
        bottomPadding: 0
        globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        Kirigami.ColumnView.fillWidth: true
        Kirigami.ColumnView.preventStealing: true
        
        default property alias content: itemCont.data
        readonly property bool empty: true

        Item {
            id: itemCont
            anchors.fill: parent

            property string state: "Pan: " + ma.__isPanning + " " + "  Touch: " + ma. __isTouching + "  X/Y: " + ma.__lastX + " " + ma.__lastY

            Text {
                text: "TO USE: press and drag the mouse.\nYou should see coordinates updated below\n\n" + parent.state
                anchors.centerIn: parent
            }

            MouseArea {
                id: ma
                
                //! Property used to indicate if panning the map
                property bool __isPanning: false
                
                //! Property used to indicate if touching the map
                property bool __isTouching: false

                //! Last pressed X and Y position
                property int __lastX: -1
                property int __lastY: -1

                //! Required distance to be detected as panning
                property int __panningThreshold: Screen.pixelDensity * 3

                anchors.fill : parent
                
                //! When pressed, indicate that touching has been started and update saved X and Y values
                onPressed: {
                    __isPanning = false
                    __isTouching = true
                    __lastX = mouse.x
                    __lastY = mouse.y
                }
                
                //! When released, indicate that touching has finished
                onReleased: {
                    __isTouching = false;
                }
                
                //! Move the map when panning
                onPositionChanged: {
                    if (__isTouching) {
                        var dx = mouse.x - __lastX
                        var dy = mouse.y - __lastY
                        var dist = Math.sqrt(dx * dx + dy * dy)
                        if (!__isPanning && dist > __panningThreshold)
                            __isPanning = true
                        if (__isPanning) {
                            __lastX = mouse.x
                            __lastY = mouse.y
                        }
                    }
                }
                
                //! When canceled, indicate that panning has finished
                onCanceled: {
                    __isTouching = false;
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
