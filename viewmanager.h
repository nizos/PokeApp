#ifndef VIEWMANAGER_H
#define VIEWMANAGER_H
#include "albumsmodel.h"
#include "cardsmodel.h"
#include "proxymodel.h"
#include <QObject>
#include <QDebug>

class ViewManager : public QObject
{
    Q_OBJECT

public:
    ViewManager(QObject* parent = 0);
    void setAlbumsModel(AlbumsModel* albumsModel);
    void setCardsModel(CardsModel* cardsModel);
    void setProxyModel(ProxyModel* proxyModel);
    void refreshCards();
    void refreshAlbums();

private:
    AlbumsModel* albumsModel;
    CardsModel* cardsModel;
    ProxyModel* proxyModel;
};

#endif // VIEWMANAGER_H
