import QtQuick 2.6
import QtQuick.Window 2.2
import imageresizer 1.0

Window {
    visible: true
    width: 1200
    height: 700

    MainForm {
        id: mainForm

        ImageResizer {
            id: imageResizer
            onEmitTrace: {
                mainForm.traceViewer.text += '\n' + text;
            }
        }

//        tableView.model: logViewModel
//        delegate: Text { text: "Animal: " + type + ", " + size }


        btnConvert.onClicked: imageResizer.start("E:/kepek/dropbox/sony_1_Copy", 2)
        btnAddItem.onClicked: logViewModel.appendLogToView()

//        anchors.fill: parent
//        mouseArea.onClicked: {
//            Qt.quit();
//        }
    }
}
