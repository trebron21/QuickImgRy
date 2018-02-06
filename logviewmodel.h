#ifndef LOGVIEWMODEL_H
#define LOGVIEWMODEL_H

#include <QAbstractTableModel>
#include <QBrush>
#include <QDebug>

class Log
{
    public:

        Log(size_t id, QString message) :
            id(id),
            message(message)
        { /* empty */ }

        size_t getId() const { return id; }
        QString getMessage() const { return message; }

    private:
        size_t id;
        QString message;
};

class LogViewModel : public QAbstractTableModel
{
    Q_OBJECT

    public:
        enum LogViewRoles {
            TypeRole = Qt::UserRole + 1,
            SizeRole,
            BgRole
        };

        LogViewModel(QObject * parent = 0);

        virtual QHash<int, QByteArray> roleNames() const override;

        // QAbstractItemModel boilerplate
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

        bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::EditRole) override;

        bool insertRows(int position, int rows, const QModelIndex &index) override;

        Qt::ItemFlags flags(const QModelIndex &index) const override { return index.flags(); }

        QVariant headerData(int section, Qt::Orientation orientation,
                            int role = Qt::DisplayRole) const override { return 0; }

        QModelIndex index(int row, int column,
                          const QModelIndex &parent = QModelIndex()) const override
        {
            return createIndex(row, column);
        }

        QModelIndex parent(const QModelIndex &index) const override { return index.parent(); }

        int rowCount(const QModelIndex &parent = QModelIndex()) const override
        {
            Q_UNUSED(parent);
            return m_logQueue.count();
        }

        int columnCount(const QModelIndex &parent = QModelIndex()) const override
        {
            Q_UNUSED(parent);
            return 2;
        }

        void appendLog(Log const & log);


        Q_INVOKABLE void appendLogToView(quint64 id, QString message);

    private:
        QList<Log> m_logQueue;
};

#endif // LOGVIEWMODEL_H
