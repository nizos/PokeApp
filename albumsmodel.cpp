#include "albumsmodel.h"


AlbumsModel::AlbumsModel(const AlbumsModel &other, QObject *parent)
: QSqlRelationalTableModel(parent,other.database())
{

}

AlbumsModel::AlbumsModel(QObject *parent, QSqlDatabase db)
: QSqlRelationalTableModel(parent,db)
{

}

AlbumsModel::~AlbumsModel()
{

}

QVariant AlbumsModel::data( const QModelIndex & index, int role ) const
{

    if(index.row() >= rowCount())
    {
        return QString("");
    }
    if(role < Qt::UserRole)
    {
        return QSqlRelationalTableModel::data(index, role);
    }

    QModelIndex modelIndex = this->index(index.row(), role - Qt::UserRole - 1 );
    return QSqlQueryModel::data(modelIndex, Qt::EditRole);
}

void AlbumsModel::generateRoleNames()
{
    roles.clear();
    for (int i = 0; i < columnCount(); i++)
    {
        roles[Qt::UserRole + i + 1] = QVariant(headerData(i, Qt::Horizontal).toString()).toByteArray();
    }
}

QHash<int, QByteArray> AlbumsModel::roleNames() const
{
    return roles;
}


void AlbumsModel::setTable ( const QString &table_name )
{
    QSqlRelationalTableModel::setTable(table_name);
    generateRoleNames();
}
