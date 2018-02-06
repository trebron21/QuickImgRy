import QtQuick 2.6
import QtQuick.Window 2.2
import imageresizer 1.0
import logviewmodel 1.0
import fileio 1.0

Window {
    visible: true
    width: 1200
    height: 700

    MainForm {
        id: mainForm

        FileIO {
            id: myFile
            source: "c:\\work\\ofi\\_bugs_\\ProInspect\\konturberechnungsfehler\\20170622_Fehlstelle_gespalten\\files.txt"
            onError: console.log(msg)
        }

        ImageResizer {
            id: imageResizer
            onEmitTrace: {
                mainForm.tableListModel.insert(0, {id: 0, message: text});
//                logViewModel.appendLogToView(0, text)
            }
        }

        Timer {
            id: timer
        }

        property int iterCounter: 0

        function delay(delayTime, cb) {
            timer.interval = delayTime;
            timer.repeat = true;
            timer.triggered.connect(cb);
            timer.start();
        }

//        tableView.model: logViewModel
//        tableView.parent: mainForm
//        btnConvert.onClicked: imageResizer.start("c:/Users/njakab/Downloads/images/sony_a6000_black_20170817/resized_Copy", 2)
        btnAddItem.onClicked: {
            if (timer.running) {
                timer.stop()
                return
            }

            var txt = myFile.read()

            delay(200, function(){
                for (var i = 0; i < 10; ++i) {
    //            logViewModel.appendLogToView(textField1.text, textField2.text);
                    tableListModel.insert(tableListModel.count, {id: i % 7, time: "2018.02.06 11:05", message: txt});
                }

                ++iterCounter
                if (iterCounter === 2) {
                    iterCounter = 0
                    tableListModel.insert(tableListModel.count, {id: 10, time: "2018.02.06 11:05", message: txt})
                    tableListModel.insert(tableListModel.count, {id: 10, time: "2018.02.06 11:05", message: txt})
                }

                tableView.positionViewAtRow(tableListModel.count - 1 , ListView.End)
            })
//            for (var i = 0; i < 10; ++i) {
////            logViewModel.appendLogToView(textField1.text, textField2.text);
//                tableListModel.insert(tableListModel.count, {id: i % 7, time: "2018.02.06 11:05", message: txt});
//            }
//            tableView.positionViewAtRow(tableListModel.count - 1 , ListView.End)
        }

        anchors.fill: parent
//        mouseArea.onClicked: {
//            Qt.quit();
//        }
    }
}
