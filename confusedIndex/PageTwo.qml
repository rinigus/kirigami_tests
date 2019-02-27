import QtQuick 2.9
import QtQuick.Controls 2.2 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.7 as Kirigami
import QtLocation 5.11
import QtPositioning 5.11

Kirigami.ScrollablePage {
    id: page2

    actions {
        main: Kirigami.Action {
            text: "Click me: pop page"
            onTriggered: applicationWindow().pageStack.pop()
        }
    }

    Kirigami.ColumnView.fillWidth: false

    Column{
        spacing: 5
        Repeater {
            model: 5
            delegate: Rectangle {
                color: "blue"
                width: lab.width
                height: lab.height
                Controls.Label {
                    id: lab
                    text: "List of items " + model.index
                }
            }
        }
    }

    Timer {

    }
}
