#include "cardsmodel.h"

CardsModel::CardsModel(const CardsModel &other, QObject *parent)
: QSqlRelationalTableModel(parent,other.database())
{

}

CardsModel::CardsModel(QObject *parent, QSqlDatabase db)
: QSqlRelationalTableModel(parent,db)
{

}

CardsModel::~CardsModel()
{

}

QVariant CardsModel::data( const QModelIndex & index, int role ) const
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

void CardsModel::generateRoleNames()
{
    roles.clear();
    for (int i = 0; i < columnCount(); i++)
    {
        roles[Qt::UserRole + i + 1] = QVariant(headerData(i, Qt::Horizontal).toString()).toByteArray();
    }
}

QHash<int, QByteArray> CardsModel::roleNames() const
{
    return roles;
}

void CardsModel::setTable ( const QString &table_name )
{
    QSqlRelationalTableModel::setTable(table_name);
    generateRoleNames();
}
