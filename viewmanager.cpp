#include "viewmanager.h"

ViewManager::ViewManager(QObject* parent) : QObject(parent)
{

}

void ViewManager::setAlbumsModel(AlbumsModel* albumsModel)
{
    this->albumsModel = albumsModel;
}

void ViewManager::setCardsModel(CardsModel* cardsModel)
{
    this->cardsModel = cardsModel;
}

void ViewManager::setProxyModel(ProxyModel* proxyModel)
{
    this->proxyModel = proxyModel;
}

void ViewManager::refreshCards()
{
    this->cardsModel->setTable("Cards");
    this->cardsModel->setRelation(1, QSqlRelation("Albums", "ID", "albumName"));
    this->cardsModel->select();
    qDebug() << "refreshCards done.";
}

void ViewManager::refreshAlbums()
{
    this->albumsModel->setTable("Albums");
    this->albumsModel->select();
    qDebug() << "refreshAlbums done.";
}

