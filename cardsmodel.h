#ifndef CARDSMODEL_H
#define CARDSMODEL_H
#include <QSqlRelationalTableModel>

class CardsModel : public QSqlRelationalTableModel
{
    Q_OBJECT
    Q_PROPERTY( int count READ rowCount() NOTIFY countChanged())

public:

    explicit CardsModel(const CardsModel &other, QObject *parent = 0);

    explicit CardsModel(QObject *parent = 0, QSqlDatabase db = QSqlDatabase());

    ~CardsModel();

    Q_INVOKABLE QVariant data(const QModelIndex &index, int role=Qt::DisplayRole ) const;

    virtual void setTable ( const QString &table_name );

    virtual QHash<int, QByteArray> roleNames() const;

    void generateRoleNames();

signals:
    void countChanged();

private:
    int count;
    QHash<int, QByteArray> roles;
};

#endif // CARDSMODEL_H
