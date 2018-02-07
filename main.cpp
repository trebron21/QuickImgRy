#include <imageresizer.h>
#include <logviewmodel.h>
#include <fileio.h>
#include <sortfilterproxymodel.h>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<ImageResizer>("imageresizer", 1, 0, "ImageResizer");
    qmlRegisterType<LogViewModel>("logviewmodel", 1, 0, "LogViewModel");
    qmlRegisterType<FileIO, 1>("fileio", 1, 0, "FileIO");
    qmlRegisterType<SortFilterProxyModel>("SortFilterProxyModel", 0, 1, "SortFilterProxyModel");

    QQmlApplicationEngine engine;
    LogViewModel * logViewModel = new LogViewModel;
    logViewModel->appendLog(Log(0, "message0"));
    logViewModel->appendLog(Log(1, "message1"));
    logViewModel->appendLog(Log(2, "message2"));

//    engine.rootContext()->setContextProperty("logViewModel", logViewModel);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
