#ifndef ALBUMSMODEL_H
#define ALBUMSMODEL_H
#include <QSqlRelationalTableModel>

class AlbumsModel : public QSqlRelationalTableModel
{
    Q_OBJECT
    Q_PROPERTY( int count READ rowCount() NOTIFY countChanged())

public:

    explicit AlbumsModel(const AlbumsModel &other, QObject *parent = 0);

    explicit AlbumsModel(QObject *parent = 0, QSqlDatabase db = QSqlDatabase());

    ~AlbumsModel();

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

#endif // ALBUMSMODEL_H
