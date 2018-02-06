import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.1
import logviewmodel 1.0

Rectangle {
    id: rectangle1

    width: 800
    height: 600
    color: "#16ca5a"
    property alias textField2: textField2
    property alias textField1: textField1
    property alias btnAddItem: btnAddItem
    clip: false
    property alias tableView: tableView
//    property alias btnConvert: btnConvert
    property alias logViewModel: logViewModel
    property alias tableListModel: tableListModel



    Button {
        id: btnAddItem
        x: 0
        y: 0
        text: qsTr("Add item")
        //            onClicked: logViewModel.appendLogAsString("appended", 10)
    }

    ListModel {
        id: tableListModel
    }

    function selectRowColor(selected, id) {
        if (selected) {
            return "yellow";
        }
        else {
            if (id === 0)
                return "lightgreen"
            else if (id === 1)
                return "orange"
            else if (id === 2)
                return "gray"
            else if (id === 3)
                return "lightgray"
            else if (id === 4)
                return "yellow"
            else if (id === 5)
                return "lightblue"
            else if (id === 6)
                return "white"
        }

        return "white"
    }

    TableView {
        id: tableView
        selectionMode: 1
        anchors.right: parent.right
//        anchors.rightMargin: 77
        anchors.left: parent.left
//        anchors.leftMargin: 70
        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 30

        transformOrigin: Item.Center
        alternatingRowColors: false
//        model: logViewModel
        model: tableListModel


        frameVisible: false
        sortIndicatorVisible: true

//        Layout.minimumWidth: 800
//        Layout.minimumHeight: 600
//        Layout.preferredWidth: 800
//        Layout.preferredHeight: 600

        itemDelegate:
            Rectangle
            {        
//                border.width: 1
//                border.color: "#000000"
//                color: styleData.selected ? "#aa1122" : model.bgrole
                color: selectRowColor(styleData.selected, (model) ? model.id : 0)
//                    styleData.selected ? "#aa1122" : "#92dd41"

                Text
                {
                    id: itemText
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    text: switch (styleData.column){
                            case 0: (model) ? model.id : ""; break;
                            case 1: (model) ? model.time : ""; break;
                            case 2: (model) ? model.message: ""; break;
                            default: "Qt implementation error."; break;
                          }
                }
            }

        TableViewColumn {
            id: severityColumn
            title: "Severity"
            role: "id"
            movable: false
            resizable: true
            width: tableView.viewport.width / 10
        }

        TableViewColumn {
            id: timestampColumn
            title: "Time"
            role: "time"
            movable: false
            resizable: true
            width: tableView.viewport.width / 5
        }

        TableViewColumn {
            id: messageColumn
            title: "Message"
            role: "message"
            movable: false
            resizable: true
            width: tableView.viewport.width/* - severityColumn.width - timestampColumn.width*/
        }
    }

    LogViewModel
    {
       id: logViewModel
    }

//    Button {
//        id: btnConvert
//        x: 8
//        y: 44
//        width: 77
//        text: qsTr("Convert")
//    }

    TextField {
        id: textField1
        x: 100
        y: 0
        placeholderText: qsTr("Severity")
    }

    TextField {
        id: textField2
        x: 200
        y: 0
        placeholderText: qsTr("Message")
    }
}
