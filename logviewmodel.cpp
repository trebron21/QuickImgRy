#include <logviewmodel.h>

LogViewModel::LogViewModel(QObject *parent)
: QAbstractTableModel(parent)
{
}

QHash<int, QByteArray> LogViewModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[TypeRole] = "type";
    roles[SizeRole] = "size";
    roles[BgRole] = "bgrole";

    return roles;
}

void LogViewModel::appendLogToView(quint64 id, QString message)
{
    appendLog(Log(id, message));
}

QVariant LogViewModel::data(const QModelIndex &index, int role) const
{
    qInfo() << "index: " << index << " role: " << role;

//            int row = index.row();
//            int col = index.column();
//            // generate a log message when this method gets called
//            qDebug() << QString("row %1, col%2, role %3")
//                .arg(row).arg(col).arg(role);

    if (index.row() < 0 || index.row() >= m_logQueue.count())
        return QVariant();

    const Log &log = m_logQueue[index.row()];
    if (role == TypeRole)
    {
        return log.getMessage();
    }
    else if (role == SizeRole)
    {
        return log.getId();
    }
    else if (role == BgRole)
    {
        if (log.getId() == 0)
            return QColor("#00aaff");
        else if (log.getId() == 1)
            return QColor(Qt::lightGray);
        else if (log.getId() == 2)
            return QColor(Qt::gray);
        else if (log.getId() == 3)
            return QColor("#ffb35c");
        else if (log.getId() == 4)
            return QColor(Qt::yellow);

        return QColor(Qt::white);
    }
    else if (role == Qt::DisplayRole)
    {
//        int row = index.row();
//        int col = index.column();
//        if (row == 0 && col == 1) return QString("<--left");
//        if (row == 1 && col == 1) return QString("right-->");
        return QColor(Qt::red);
    }
    else if (role == Qt::BackgroundRole)
    {
        qInfo() << "BackgroundColorRole";
        return QColor(Qt::red);
    }

    return QVariant();
}

bool LogViewModel::insertRows(int position, int rows, const QModelIndex &index)
{
    Q_UNUSED(index);
    beginInsertRows(QModelIndex(), position, position + rows - 1);

    m_logQueue << Log(210, "insertRows");

    endInsertRows();
    return true;
}

void LogViewModel::appendLog(Log const & log)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());

    m_logQueue << log;

    endInsertRows();

    setData(index(0, 0), index(0, 0));

//    insertRows(0, 1, QModelIndex());

//    QModelIndex index = this->index(0, 0, QModelIndex());
//    setData(index, QVariant(), Qt::EditRole);
//    index = this->index(0, 1, QModelIndex());
//    setData(index, QVariant(), Qt::EditRole);

//            emit dataChanged(index(1, 0), index(1, 1), roles);
}

bool LogViewModel::setData(const QModelIndex & index, const QVariant & value, int role)
{
//    if (index.isValid() && role == Qt::EditRole) {
//        int row = index.row();

//        QPair<QString, QString> p = listOfPairs.value(row);

//        if (index.column() == 0)
//            p.first = value.toString();
//        else if (index.column() == 1)
//            p.second = value.toString();
//        else
//            return false;

//        listOfPairs.replace(row, p);
//        emit(dataChanged(index, index));

//        return true;
//    }

//    m_logQueue.append(Log(2341, "setData"));
//    emit dataChanged(index, index);
    emit dataChanged(QModelIndex(), QModelIndex());
//    qInfo() << "dataChanged";

    return false;
}
