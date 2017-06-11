#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H
#include "cardsmodel.h"
#include <QQuickImageProvider>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QEventLoop>
#include <QSqlQuery>
#include <QSqlError>
#include <QBuffer>
#include <QObject>
#include <QPixmap>
#include <QImage>
#include <QHash>
#include <QSignalMapper>

class ImageProvider : public QObject, public QQuickImageProvider
{
    Q_OBJECT

public:
    ImageProvider(QObject *parent = 0);
    ~ImageProvider();

    QImage requestImage(const QString & imageURL, QSize * size, const QSize & requestedSize);
    void setDatabase(QSqlDatabase* database);
    void addCardImage(QString imageURL, int crdID, int albID);
    void addPlaceHolderImage(QString imageURL, int crdID, int albID);

signals:
    void cardAdded(QString imageURL);
    void cardUpdated(QString imageURL);
    void cardRemoved(QString imageURL);
    void mapped(QString imageURL);
    void cardImageAdded(int crdID, int albID);
    void cardPlaceHolderAdded(int crdID, int albID);

public slots:
    void mappedReply(QString);

protected:
    CardsModel* cardsModel;
    QSqlDatabase* database;
    QSignalMapper m_mapper;
    QHash<QString, QNetworkReply*> m_replies;
    QNetworkAccessManager *networkManager;
};

#endif // IMAGEPROVIDER_H
