#include "fileio.h"
#include <QDebug>
#include <QFile>
#include <QTextStream>

namespace
{
    QFile file;
    QTextStream t;
}

FileIO::FileIO(QObject *parent) :
    QObject(parent)
{
}

QVariantMap FileIO::read()
{
    if (mSource.isEmpty()){
        emit error("source is empty");
        return QVariantMap();
    }

    QVariantMap fileContent;

    if (file.isOpen())
    {
        QString line;
//        t.setDevice(&file);
//        do {
            line = t.readLine();
//            fileContent += line;
//         } while (!line.isNull());

//            qInfo() << line << "\n";

            if (line == "")
            {
                file.close();
                return QVariantMap();
            }

            QStringList readRecord = line.split(";");
            if (readRecord.size() == 0)
                return QVariantMap();

            fileContent["id"] = readRecord[0].trimmed();
            fileContent["dateTime"] = readRecord[1].trimmed();
            fileContent["severity"] = readRecord[2].trimmed();
            fileContent["process"] = readRecord[3].trimmed();
            fileContent["message"] = readRecord[4].trimmed();
            fileContent["processId"] = readRecord[5].trimmed();
            fileContent["threadId"] = readRecord[6].trimmed();

            return fileContent;
    }

    if (!file.isOpen())
        file.setFileName(mSource);

    if ( file.open(QIODevice::ReadOnly) ) {
        QString line;
        t.setDevice(&file);
//        do {
            line = t.readLine();
//            fileContent += line;
//         } while (!line.isNull());

//            qInfo() << line << "\n";

            QStringList readRecord = line.split(";");
            fileContent["id"] = readRecord[0];
            fileContent["dateTime"] = readRecord[1];
            fileContent["severity"] = readRecord[2];
            fileContent["process"] = readRecord[3];
            fileContent["message"] = readRecord[4];
            fileContent["processId"] = readRecord[5];
            fileContent["threadId"] = readRecord[6];

//            qInfo() << readRecord[4] << "\n";

//        file.close();
    } else {
        emit error("Unable to open the file");
        return QVariantMap();
    }
    return fileContent;
}

bool FileIO::write(const QString& data)
{
    if (mSource.isEmpty())
        return false;

    QFile file(mSource);
    if (!file.open(QFile::WriteOnly | QFile::Truncate))
        return false;

    QTextStream out(&file);
    out << data;

    file.close();

    return true;
}
