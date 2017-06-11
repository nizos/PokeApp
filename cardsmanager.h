#ifndef CARDSMANAGER_H
#define CARDSMANAGER_H
#include "viewmanager.h"
#include "imageprovider.h"
#include <QSqlDatabase>
#include <QNetworkAccessManager>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QHash>
#include <QDateTime>
#include <QSignalMapper>
#include <QString>
#include <QObject>


class CardsManager : public QObject
{
    Q_OBJECT

public:
    CardsManager(QObject* parent = 0);
    void setDatabase(QSqlDatabase* database);
    void setImageProvider(ImageProvider* imageProvider);
    void setViewManager(ViewManager* viewManager);
    Q_INVOKABLE void addCard(int albID, QString crdReq);
    Q_INVOKABLE void removeCard(int crdID,int albID);

    // Getters
    Q_INVOKABLE int getAlbumMID(int crdID);
    Q_INVOKABLE QString getAlbumName(int crdID);
    Q_INVOKABLE QString getName(int crdID);
    Q_INVOKABLE QString getImageURL(int crdID);
    Q_INVOKABLE QString getSubtype(int crdID);
    Q_INVOKABLE QString getSupertype(int crdID);
    Q_INVOKABLE int getNumber(int crdID);
    Q_INVOKABLE QString getArtist(int crdID);
    Q_INVOKABLE QString getRarity(int crdID);
    Q_INVOKABLE QString getSeries(int crdID);
    Q_INVOKABLE QString getSet(int crdID);
    Q_INVOKABLE QString getSetcode(int crdID);
    Q_INVOKABLE QString getCondition(int crdID);
    Q_INVOKABLE QString getStatus(int crdID);
    Q_INVOKABLE bool getLoaded(int crdID);
    Q_INVOKABLE QDateTime getAdded(int crdID);
    Q_INVOKABLE QDateTime getEdited(int crdID);

    // Setters
    Q_INVOKABLE void setAlbumMID(int albumMID,int crdID);
    Q_INVOKABLE void setAlbumName(QString albumName,int crdID);
    Q_INVOKABLE void setCondition(QString condition,int crdID);
    Q_INVOKABLE void setStatus(QString status,int crdID);

signals:
    void cardAdded(int crdID,int albID);
    void cardUpdated(int crdID,int albID);
    void cardRemoved(int crdID,int albID);
    void albumUpdated(int albID);
    void mapped(int crdID,int albID);

public slots:
    void cardImageAdded(int crdID,int albID);
    void cardPlaceHolderAdded(int crdID,int albID);
    void mappedReply(int crdID);

private:
    QSqlDatabase* database;
    QSignalMapper m_mapper;
    CardsModel* cardsModel;
    QNetworkAccessManager *networkManager;

    QHash<int, QNetworkReply*> m_replies;
    ImageProvider* imageProvider;
    ViewManager* viewManager;
};

#endif // CARDSMANAGER_H
