#pragma once

#include <QObject>
#include <QVariantMap>

class FileIO : public QObject
{
    Q_OBJECT

public:
    Q_PROPERTY(QString source
               READ source
               WRITE setSource
               NOTIFY sourceChanged)

    Q_PROPERTY(QVariantMap logRecord
               READ logRecord)

    explicit FileIO(QObject *parent = 0);

    Q_INVOKABLE QVariantMap read();
    Q_INVOKABLE bool write(const QString& data);

    QString source() { return mSource; }

    QVariantMap logRecord() { return mLogRecord; }

public slots:
    void setSource(const QString& source) { mSource = source; }

signals:
    void sourceChanged(const QString& source);
    void error(const QString& msg);

private:
    QString mSource;

    QVariantMap mLogRecord;
};
