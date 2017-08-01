#include <logviewmodel.h>

LogViewModel::LogViewModel(QObject *parent)
: QAbstractTableModel(parent)
{
}

QHash<int, QByteArray> LogViewModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[TypeRole] = "type";
    roles[SizeRole] = "size";
    return roles;
}

void LogViewModel::appendLogToView()
{
    appendLog(Log(10, "appended"));
}
