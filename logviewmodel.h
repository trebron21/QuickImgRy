#ifndef LOGVIEWMODEL_H
#define LOGVIEWMODEL_H

#include <QAbstractTableModel>

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
            SizeRole
        };

        LogViewModel(QObject *parent = 0);

        virtual QHash<int, QByteArray> roleNames() const override;

        // QAbstractItemModel boilerplate
        QVariant data(const QModelIndex &index, int role) const override
        {
            if (index.row() < 0 || index.row() >= m_logQueue.count())
                    return QVariant();

                const Log &log = m_logQueue[index.row()];
                if (role == TypeRole)
                    return log.getMessage();
                else if (role == SizeRole)
                    return log.getId();
                return QVariant();
        }

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
            return 2;
        }

        void appendLog(Log const & log)
        {
            beginInsertRows(QModelIndex(), rowCount(), rowCount());
            m_logQueue << log;
            endInsertRows();
        }

        Q_INVOKABLE void appendLogToView();

    private:
        QList<Log> m_logQueue;
};

#endif // LOGVIEWMODEL_H
