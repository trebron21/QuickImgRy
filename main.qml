import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.5
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4
import imageresizer 1.0
import logviewmodel 1.0
import fileio 1.0

ApplicationWindow {
    visible: true
    visibility: Window.Maximized

    title: "Log Viewer"
    objectName: "Log Viewer"
    color: "lightgray"

    Action {
        id: openFileAction
        text: "Open File"
        shortcut: StandardKey.Open
        iconName: "openFile"
        onTriggered: openFile.open()
    }

    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = true;
        timer.triggered.connect(cb);
        timer.start();
    }

    Action {
        id: simulateLogAction
        text: "Simulate log"
        shortcut: StandardKey.Refresh
        iconName: "SimulateLog"
        onTriggered: {
            if (timer.running) {
                timer.stop()
                return
            }

            delay(1, function(){
                for (var i = 0; i < 10; ++i) {
    //            logViewModel.appendLogToView(textField1.text, textField2.text);
                    var logRecord = myFile.read()

                    if (logRecord["id"] === "")
                        return

                    mainForm.tableListModel.insert(mainForm.tableListModel.count,
//                    mainForm.tableListModel.insert(0,
                                          {
                                              id: logRecord["id"],
                                              time: logRecord["dateTime"],
                                              severity: logRecord["severity"],
                                              process: logRecord["process"],
                                              message: logRecord["message"]
                                          });
                }

                mainForm.tableView.positionViewAtRow(mainForm.tableListModel.count - 1, ListView.End)
//                mainForm.tableView.positionViewAtRow(0, ListView.End)
            })
//            for (var i = 0; i < 10; ++i) {
////            logViewModel.appendLogToView(textField1.text, textField2.text);
//                tableListModel.insert(tableListModel.count, {id: i % 7, time: "2018.02.06 11:05", message: txt});
//            }
//            tableView.positionViewAtRow(tableListModel.count - 1 , ListView.End)
        }
    }

    menuBar: MenuBar {
        id: menuBar

        Menu {
            title: "File"

            MenuItem { action: openFileAction }

            MenuItem {
                text: "Exit"
                onTriggered: Qt.quit()
            }
        }

        style: MenuBarStyle {
            padding {
                left: 8
                right: 8
                top: 3
                bottom: 3
            }

            background: Rectangle {
                color: "gray"
            }

            itemDelegate: Rectangle {                          // the menu items in the menubar
                implicitWidth: menuBarLabel.contentWidth * 1.5 // adjusting width
                implicitHeight: menuBarLabel.contentHeight     // adjusting height
                color: styleData.selected || styleData.open ? "lightgray" : "gray"
                Label {
                    id: menuBarLabel
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: styleData.selected  || styleData.open ? "gray" : "lightgray"
                    font.pixelSize: 14
                    text: styleData.text
                }
            }


            menuStyle: MenuStyle { // the menu items in the dropdown list
                itemDelegate {
                    background: Rectangle {
                        color: styleData.selected ? "lightgray" : "gray"
                    }
                    label: Label {
                        id: menuLabel
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 14
                        text: styleData.text
                        color: styleData.selected ? "gray" : "lightgray"
                    }
                }
            }
        }
    }

    FileDialog {
        id: openFile
        title: "Open log file"
        nameFilters: ["Log files (*.csv *.txt)", "All files (*)"]

        onAccepted: {
            var path = openFile.fileUrl.toString()
            // remove prefixed "file:///"
            path = path.replace(/^(file:\/{3})/,"")
            // unescape html codes like '%23' for '#'
            var cleanPath = decodeURIComponent(path)
            console.log(cleanPath)
            myFile.source = cleanPath
        }
    }

    MainForm {
        id: mainForm

        FileIO {
            id: myFile
            source: "c:\\workspaces\\ofi\\BMW_KGH_GD_2015\\Deployment\\logProInspect\\logProInspect_2017-10-10_00025.csv"
//            onError: console.log(msg)
        }

        ImageResizer {
            id: imageResizer
            onEmitTrace: {
                mainForm.tableListModel.insert(0, {id: 0, message: text});
//                logViewModel.appendLogToView(0, text)
            }
        }



//        tableView.model: logViewModel
//        tableView.parent: mainForm
//        btnConvert.onClicked: imageResizer.start("c:/Users/njakab/Downloads/images/sony_a6000_black_20170817/resized_Copy", 2)


//        btnAddItem.onClicked: {
//            if (timer.running) {
//                timer.stop()
//                return
//            }

//            delay(1, function(){
//                for (var i = 0; i < 10; ++i) {
//    //            logViewModel.appendLogToView(textField1.text, textField2.text);
//                    var logRecord = myFile.read()

//                    if (logRecord["id"] === "")
//                        return

//                    tableListModel.insert(tableListModel.count,
//                                          {
//                                              id: logRecord["id"],
//                                              time: logRecord["dateTime"],
//                                              severity: logRecord["severity"],
//                                              process: logRecord["process"],
//                                              message: logRecord["message"]
//                                          });
//                }

//                tableView.positionViewAtRow(tableListModel.count - 1 , ListView.End)
//            })
////            for (var i = 0; i < 10; ++i) {
//////            logViewModel.appendLogToView(textField1.text, textField2.text);
////                tableListModel.insert(tableListModel.count, {id: i % 7, time: "2018.02.06 11:05", message: txt});
////            }
////            tableView.positionViewAtRow(tableListModel.count - 1 , ListView.End)
//        }

        anchors.fill: parent
//        mouseArea.onClicked: {
//            Qt.quit();
//        }
    }
}
