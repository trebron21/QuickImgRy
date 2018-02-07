import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.1
import logviewmodel 1.0
import SortFilterProxyModel 0.1

Rectangle {
    id: rectangle1

    anchors.fill: parent

    color: "lightgray"
//    property alias textField2: textField2
//    property alias textField1: textField1
//    property alias btnAddItem: btnAddItem
    clip: false
    property alias tableView: tableView
//    property alias btnConvert: btnConvert
//    property alias logViewModel: logViewModel
    property alias tableListModel: tableListModel



//    Button {
//        id: btnAddItem
//        x: 0
//        y: 0
//        text: qsTr("Add item")
//        //            onClicked: logViewModel.appendLogAsString("appended", 10)
//    }

    ListModel {
        id: tableListModel
    }

    function selectRowColor(selected, severity) {
        if (selected) {
            return "lightblue";
        }
        else {
            if (severity === "fatal")
                return "red"
            else if (severity === "error")
                return "orange"
            else if (severity === "call")
                return "gray"
            else if (severity === "debug")
                return "lightgray"
            else if (severity === "warning")
                return "yellow"
//            else if (severity === "")
//                return "lightblue"
//            else if (severity === "")
//                return "lightgreen"
            else if (severity === "info")
                return "white"
        }

        return "transparent"
    }

SplitView {
        anchors.fill: parent
        orientation: Qt.Vertical

    TableView {
        id: tableView
        selectionMode: 1
//        anchors.fill: parent
//        Layout.minimumHeight: 800
//        Layout.preferredHeight: 800
//        Layout.fillHeight: true
        anchors.right: parent.right
//        anchors.rightMargin: 77
        anchors.left: parent.left
//        anchors.leftMargin: 70
        anchors.bottom: selectedRecord.top
//        anchors.bottomMargin: 50
        anchors.top: parent.top
//        anchors.topMargin: 30

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

        __listView.spacing: 1
//        __listView.pixelAligned: true

//        model: SortFilterProxyModel {
//            id: proxyModel
//            source: tableListModel.count > 0 ? tableListModel : null

//            sortOrder: tableView.sortIndicatorOrder
//            sortCaseSensitivity: Qt.CaseInsensitive
//            sortRole: tableListModel.count > 0 ?
//                      tableView.getColumn(tableView.sortIndicatorColumn).role : ""

////            filterString: "*" + searchBox.text + "*"
////            filterSyntax: SortFilterProxyModel.Wildcard
//            filterCaseSensitivity: Qt.CaseInsensitive
//        }

//        onSelectionChanged: selectedRecord.text = (model) ? model.message : ""

        itemDelegate:
            Rectangle
            {
//                border.width: 0.5
//                border.color: "#a29c9c"
                //                color: styleData.selected ? "#aa1122" : model.bgrole
                color: selectRowColor(styleData.selected, (model) ? model.severity : "info")
//                    styleData.selected ? "#aa1122" : "#92dd41"

                Text
                {
                    id: itemText
                    color: "#383232"
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    text: switch (styleData.column){
                            case 0: (model) ? model.id : ""; break;
                            case 1: (model) ? model.time : ""; break;
                            case 2: (model) ? model.severity : ""; break;
                            case 3: (model) ? model.process: ""; break;
                            case 4: (model) ? model.message: ""; break;
                            default: "Implementation error."; break;
                          }
                    font.family: "Arial"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10
                }
            }

        TableViewColumn {
            id: idColumn
            title: "Id"
            role: "id"
            movable: false
            resizable: true
            width: tableView.viewport.width / 40
        }

        TableViewColumn {
            id: timestampColumn
            title: "Time"
            role: "time"
            movable: false
            resizable: true
            width: tableView.viewport.width / 10
        }

        TableViewColumn {
            id: severityColumn
            title: "Severity"
            role: "severity"
            movable: false
            resizable: true
            width: tableView.viewport.width / 30
        }

        TableViewColumn {
            id: processColumn
            title: "Process"
            role: "process"
            movable: false
            resizable: true
            width: tableView.viewport.width / 15
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

//    LogViewModel
//    {
//       id: logViewModel
//    }

    TextArea {
        id: selectedRecord
//        Layout.minimumHeight: 100
//        anchors.top: tableView.bottom
//        anchors.bottom: parent.bottom
//        anchors.left: parent.left
//        anchors.right: parent.right
    }
}
    Connections {
       target: tableView.selection
       onSelectionChanged:
       {
           tableView.selection.forEach(function(rowIndex) {
                           var row = tableView.model.get(rowIndex)
                           if (row && row.message)  selectedRecord.text = row.message
                       })
       }

   }

//    Button {
//        id: btnConvert
//        x: 8
//        y: 44
//        width: 77
//        text: qsTr("Convert")
//    }

//    TextField {
//        id: textField1
//        x: 100
//        y: 0
//        placeholderText: qsTr("Severity")
//    }

//    TextField {
//        id: textField2
//        x: 200
//        y: 0
//        placeholderText: qsTr("Message")
//    }
}
