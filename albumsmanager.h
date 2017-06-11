#ifndef ALBUMSMANAGER_H
#define ALBUMSMANAGER_H
#include "cardsmanager.h"
#include "viewmanager.h"
#include <QSqlDatabase>
#include <QDateTime>
#include <QObject>
#include <QDebug>


class AlbumsManager : public QObject
{
    Q_OBJECT

public:
    AlbumsManager(QObject* parent = 0);
    void setDatabase(QSqlDatabase* database);
    void setCardsManager(CardsManager* cardsManager);
    void setViewManager(ViewManager* viewManager);
    Q_INVOKABLE void addAlbum(QString albReq);
    Q_INVOKABLE void removeAlbum(int albID);
    Q_INVOKABLE void addCard(QString albName, QString crdReq);
    Q_INVOKABLE void removeCard(int albID, int crdID);

    Q_INVOKABLE int getNrOfCards(int albID);
    Q_INVOKABLE int getNrOfCards(QString albName);
    Q_INVOKABLE int getNrOfCards();
    Q_INVOKABLE int getNrOfAlbums();
    Q_INVOKABLE QDateTime getAlbumAdded(int albID);
    Q_INVOKABLE QDateTime getAlbumEdited(int albID);

signals:
    void albumAdded(int albID);
    void albumUpdated(int albID);
    void albumRemoved(int albID);
    void cardAdded(int albID, int crdID);
    void cardUpdated(int albID, int crdID);
    void cardRemoved(int albID, int crdID);

private:
    QSqlDatabase* database;
    CardsManager *cardsManager;
    ViewManager* viewManager;
};

#endif // ALBUMMANAGER_H
