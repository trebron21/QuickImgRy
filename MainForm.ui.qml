import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.1

Rectangle {
    property alias mouseArea: mouseArea

    width: 800
    height: 600
    color: "#16ca5a"
    property alias btnAddItem: btnAddItem
    property alias traceViewer: traceViewer
    clip: false
    property alias tableView: tableView
    property alias btnConvert: btnConvert

    MouseArea {
        id: mouseArea
        width: 460
        height: 370
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Button {
            id: btnConvert
            x: 8
            y: 44
            width: 77
            text: qsTr("Convert")
        }

        TableView {
            id: tableView
            x: 268
            y: 85
            width: 100
            height: 100
            model: logViewModel
            anchors.rightMargin: 8
            anchors.bottomMargin: 8
            anchors.leftMargin: 268
            anchors.topMargin: 85
//            currentRow: -2

            frameVisible: false
            sortIndicatorVisible: true

            anchors.fill: parent

            Layout.minimumWidth: 800
            Layout.minimumHeight: 600
            Layout.preferredWidth: 800
            Layout.preferredHeight: 600

            TableViewColumn {
                id: titleColumn
                title: "Message"
                role: "type"
                movable: false
                resizable: true
                width: tableView.viewport.width - authorColumn.width
            }

            TableViewColumn {
                id: authorColumn
                title: "Id"
                role: "size"
                movable: false
                resizable: true
                width: tableView.viewport.width / 3
            }
        }

        Text {
            id: traceViewer
            x: 14
            y: 116
            width: 208
            height: 400
            text: qsTr("Text")
            font.pixelSize: 12
        }

        Button {
            id: btnAddItem
            x: 268
            y: 44
            text: qsTr("Add item")
//            onClicked: logViewModel.appendLogAsString("appended", 10)
        }
    }
}
