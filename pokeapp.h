#ifndef POKEAPP_H
#define POKEAPP_H
#include <QSqlError>
#include <QObject>
#include <QDebug>
#include "viewmanager.h"
#include "cardsmodel.h"
#include "albumsmodel.h"
#include "proxymodel.h"
#include "albumsmanager.h"
#include "cardsmanager.h"
#include "imageprovider.h"
#include "cursorposprovider.h"

class PokeApp: public QObject
{
    Q_OBJECT

    // Data
    Q_PROPERTY(QSqlDatabase *database READ getDatabase)
    // Managers
    Q_PROPERTY(AlbumsManager *albumsManager READ getAlbumsManager)
    Q_PROPERTY(CardsManager *cardsManager READ getCardsManager)
    // Models
    Q_PROPERTY(AlbumsModel *albumsModel READ getAlbumsModel)
    Q_PROPERTY(CardsModel *cardsModel READ getCardsModel)
    Q_PROPERTY(ProxyModel *proxyModel READ getProxyModel)
    // Providers
    Q_PROPERTY(ImageProvider *imageProvider READ getImageProvider)
    Q_PROPERTY(CursorPosProvider *mousePosProvider READ getMousePosProvider)
    Q_PROPERTY(ViewManager *viewManager READ getViewManager)

public:
    explicit PokeApp(QObject *parent = 0);
    ~PokeApp();

    // Getters
    QSqlDatabase* getDatabase() const;
    AlbumsManager* getAlbumsManager() const;
    CardsManager* getCardsManager() const;
    AlbumsModel* getAlbumsModel() const;
    CardsModel* getCardsModel() const;
    ProxyModel* getProxyModel() const;
    ImageProvider* getImageProvider() const;
    CursorPosProvider* getMousePosProvider() const;
    ViewManager* getViewManager() const;

private:
    QSqlDatabase database;
    AlbumsManager* albumsManager;
    CardsManager* cardsManager;
    AlbumsModel* albumsModel;
    CardsModel* cardsModel;
    ProxyModel* proxyModel;
    ImageProvider* imageProvider;
    CursorPosProvider* mousePosProvider;
    ViewManager* viewManager;
};

#endif // !POKEAPP_H
