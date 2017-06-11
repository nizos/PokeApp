#include "imageprovider.h"

ImageProvider::ImageProvider(QObject *parent)  :QQuickImageProvider(QQuickImageProvider::Image), QObject(parent)
{
    this->networkManager = new QNetworkAccessManager(this);
    connect(&m_mapper, SIGNAL(mapped(QString)), this,
    SLOT(mappedReply(QString)));
}

ImageProvider::~ImageProvider()
{
    delete this->networkManager;
}

void ImageProvider::setDatabase(QSqlDatabase* database)
{
    this->database = database;
}

QImage ImageProvider::requestImage(const QString &imageURL, QSize *size, const QSize &requestedSize)
{
    // Check for image in database
    qDebug() << "ImageProvider's requestImage called for imageURL: " << imageURL;
    QString qslSelect = "SELECT * FROM CardImages WHERE imageURL=:imageURL";
    QSqlQuery findCard;
    findCard.prepare(qslSelect);
    findCard.bindValue(":imageURL",imageURL);
    if(findCard.exec())
    {
        if(findCard.first())
        {
            // Image found in database
            qDebug() << "ImageProvider's requestImage found imageData in the CardImages db for " << imageURL;
            QByteArray outByteArray = findCard.value(1).toByteArray();
            QPixmap outPixmap = QPixmap();
            outPixmap.loadFromData( outByteArray );
            QImage cardImage;
            cardImage = outPixmap.toImage();
            return cardImage;
        }
        else
        {
            // Image not found in database
            qDebug() << "ImageProvider's requestImage couldn't find imageURL: " << imageURL << " in the CardImages database.";

            // Get crdID & albID for the card that the imageURL belongs to
            QString getCard = "SELECT * FROM Cards WHERE imageURL=:imageURL";
            QSqlQuery qryCard;
            qryCard.prepare(getCard);
            qryCard.bindValue(":imageURL",imageURL);
            if(qryCard.exec())
            {
                if(qryCard.first())
                {
                    // Retreive crdID & albID
                    int crdID = qryCard.value(0).toInt();
                    int albID = qryCard.value(1).toInt();
                    qDebug() << "ImageProvider's requestImage retreived crdID for Card " << crdID << " & albID " << albID << " for imageURL: " << imageURL << " from the CardImages database.";

//                    // Add PlaceHolder imageData for Card
//                    addPlaceHolderImage(imageURL, crdID, albID);

//                    // Request imageData from network
//                    QUrl url(imageURL);
//                    QNetworkReply* reply = networkManager->get(QNetworkRequest(url));
//                    reply->setProperty("crdID",crdID);
//                    reply->setProperty("albID",albID);
//                    connect(reply, SIGNAL(finished()), &m_mapper, SLOT(map()));
//                    m_replies.insert(imageURL, reply);
//                    m_mapper.setMapping(reply, imageURL);

                    // Return temporary placeHolder imgage;
                    QPixmap placeHolderPixmap;
                    placeHolderPixmap.load(":/gui/GUI/emptyCard.png");
                    QImage placeHolder;
                    placeHolder = placeHolderPixmap.toImage();
                    return placeHolder;
                }
                else
                {
                    qDebug() << "ERROR: ResourceImageProvider's requestImage Couldn't find crdID & albID for requested URL: " << imageURL << " from the CardImages database using query: " << getCard;

                    // Return temporary placeHolder imgage;
                    QPixmap placeHolderPixmap;
                    placeHolderPixmap.load(":/gui/GUI/emptyCard.png");
                    QImage placeHolder;
                    placeHolder = placeHolderPixmap.toImage();
                    return placeHolder;
                }
            }
            else
            {
                qDebug() << "ERROR: ResourceImageProvider's requestImage Couldn't retreive crdID & albID for imageURL: " << imageURL << " from the CardImages database using query: " << getCard;
                qDebug() << database->lastError();

                // Return temporary placeHolder imgage;
                QPixmap placeHolderPixmap;
                placeHolderPixmap.load(":/gui/GUI/emptyCard.png");
                QImage placeHolder;
                placeHolder = placeHolderPixmap.toImage();
                return placeHolder;
            }

        }
    }
    else
    {
        // Couldn't perform SQLQuery
        qDebug() << "Error: ResourceImageProvider's requestImage Couldn't perform SQLQuery: " << qslSelect;
        qDebug() << database->lastError();
        QPixmap tempPixmap;
        tempPixmap.load(":/gui/GUI/emptyCard.png");
        QImage temp;
        temp = tempPixmap.toImage();
        return temp;
    }
}

void ImageProvider::addPlaceHolderImage(QString imageURL, int crdID, int albID)
{
    qDebug() << "ImageProvider's addPlaceHolder called for Card " << crdID << " in Album " << albID;
    QPixmap tempPixmap;
    tempPixmap.load(":/gui/GUI/emptyCard.png");
    QByteArray placeHolder;
    QBuffer buffer(&placeHolder);
    buffer.open(QIODevice::WriteOnly);
    tempPixmap.save(&buffer, "PNG");


    // Find if there already is a record
    QString findImageURL = "SELECT * FROM CardImages WHERE imageURL=:imageURL";
    QSqlQuery findQry;
    findQry.prepare(findImageURL);
    findQry.bindValue(":imageURL",imageURL);
    if(findQry.exec())
    {
        if(findQry.first()) // If true, update
        {
            qDebug() << "ImageProvider's addPlaceHolder found record for imageURL " << imageURL << " in the CardImages database.";
            qDebug() << "ImageProvider's addPlaceHolder will now update it's imageData to imageData for placeHolder.";
            QString updateImageData = "UPDATE CardImages SET imageData=:imageData WHERE imageURL=:imageURL";
            QSqlQuery updateCardImage;
            updateCardImage.prepare(updateImageData);
            updateCardImage.bindValue(":imageURL",imageURL);
            updateCardImage.bindValue(":imageData",placeHolder);
            if(updateCardImage.exec())
            {
                qDebug() << "ImageProvider's addPlaceHolder added placeHolder imageData to the CardImages database for Card " << crdID << " in Album " << albID << " with URL " << imageURL;
                emit cardPlaceHolderAdded(crdID,albID);

            }
            else
            {
                qDebug() << "ERROR: ImageProvider's addPlaceHolder couldn't update placeHolder imageData for Card " << crdID << " in Album " << albID << " with URL " << imageURL << " using query:" << updateImageData;
                qDebug() << database->lastError();
            }

        }
        else // If false, Insert
        {
            qDebug() << "ImageProvider's addPlaceHolder coudln't find previous record for imageURL " << imageURL << " in the CardImages database.";
            qDebug() << "ImageProvider's addPlaceHolder will now insert a new record with the placeHolder imageData using imageURL: " << imageURL;

            QString insertImage = "INSERT INTO CardImages ([imageURL],[imageData]) VALUES(:imageURL,:imageData)";
            QSqlQuery qryInsert;
            qryInsert.prepare(insertImage);
            qryInsert.bindValue(":imageURL",imageURL);
            qryInsert.bindValue(":imageData",placeHolder);
            if(qryInsert.exec())
            {
                qDebug() << "ImageProvider's addPlaceHolder added placeHolder imageData to to a new record in the CardImages database for Card " << crdID << " in Album " << albID << " with URL " << imageURL;
                emit cardPlaceHolderAdded(crdID,albID);
            }
            else
            {
                qDebug() << "ImageProvider's addPlaceHolder couldn't add a new record for the placeHolder in the CardImages database for Card " << crdID << " in Album " << albID << " with URL " << imageURL << "using query: " << insertImage;
                qDebug() << database->lastError();
            }

        }
    }
    else
    {
        qDebug() << "ImageProvider's addPlaceHolder couldn't perform search query in the CardImages database for Card " << crdID << " in Album " << albID << " with URL " << imageURL << "using query: " << findImageURL;
        qDebug() << database->lastError();
    }

}

void ImageProvider::addCardImage(QString imageURL, int crdID, int albID)
{
    qDebug() << "ImageProvider's addCardImage called for Card " << crdID << " in Album " << albID << " with imageURL: " << imageURL;
    QUrl url(imageURL);
    QNetworkReply* reply = networkManager->get(QNetworkRequest(url));
    reply->setProperty("crdID", crdID);
    reply->setProperty("albID", albID);
    connect(reply, SIGNAL(finished()), &m_mapper, SLOT(map()));
    m_replies.insert(imageURL, reply);
    m_mapper.setMapping(reply, imageURL);

}

void ImageProvider::mappedReply(QString imageURL)
{
    QNetworkReply *reply = m_replies.take(imageURL);
    int albID = reply->property("albID").toInt();
    int crdID = reply->property("crdID").toInt();
    const QByteArray data = reply->readAll();

    QImage img;
    if(img.loadFromData(data,"PNG"))
    {

        // Find if there already is a record
        QString findImageURL = "SELECT * FROM CardImages WHERE imageURL=:imageURL";
        QSqlQuery findQry;
        findQry.prepare(findImageURL);
        findQry.bindValue(":imageURL",imageURL);
        if(findQry.exec())
        {
            if(findQry.first()) // If true, update
            {
                qDebug() << "ImageProvider's mappedReply found record for imageURL " << imageURL << " in the CardImages database.";
                qDebug() << "ImageProvider's mappedReply will now update it's imageData to imageData from reply.";
                QString updateImageData = "UPDATE CardImages SET imageData=:imageData WHERE imageURL=:imageURL";
                QSqlQuery updateCardImage;
                updateCardImage.prepare(updateImageData);
                updateCardImage.bindValue(":imageURL",imageURL);
                updateCardImage.bindValue(":imageData",data);
                if(updateCardImage.exec())
                {
                    qDebug() << "ImageProvider's mappedReply added imageData to the CardImages database for Card " << crdID << " in Album " << albID << " with URL " << imageURL;
                    emit cardImageAdded(crdID,albID);

                }
                else
                {
                    qDebug() << "ERROR: ImageProvider's mappedReply couldn't update imageData for Card " << crdID << " in Album " << albID << " with URL " << imageURL << " using query:" << updateImageData;
                    qDebug() << database->lastError();
                }

            }
            else // If false, Insert
            {
                qDebug() << "ImageProvider's mappedReply coudln't find previous record for imageURL " << imageURL << " in the CardImages database.";
                qDebug() << "ImageProvider's mappedReply will now insert a new record with the imageData from the network reply using imageURL: " << imageURL;

                QString insertImage = "INSERT INTO CardImages ([imageURL],[imageData]) VALUES(:imageURL,:imageData)";
                QSqlQuery qryInsert;
                qryInsert.prepare(insertImage);
                qryInsert.bindValue(":imageURL",imageURL);
                qryInsert.bindValue(":imageData",data);
                if(qryInsert.exec())
                {
                    qDebug() << "ImageProvider's mappedReply added imageData to to a new record in the CardImages database for Card " << crdID << " in Album " << albID << " with URL " << imageURL;
                }
                else
                {
                    qDebug() << "ImageProvider's mappedReply couldn't add a new record in the CardImages database for Card " << crdID << " in Album " << albID << " with URL " << imageURL << "using query: " << insertImage;
                    qDebug() << database->lastError();
                }

            }
        }
        else
        {
            qDebug() << "ImageProvider's mappedReply couldn't search the CardImages database for Card " << crdID << " in Album " << albID << " with URL " << imageURL << "using query: " << findImageURL;
            qDebug() << database->lastError();
        }
    }
    else
    {
        qDebug() << "ERROR: ImageProvider's mappedReply couldn't load image from reply for Card " << crdID << " in Album " << albID << " with URL " << imageURL << " using function: img.loadFromData(data,'PNG').";
    }
    reply->deleteLater();
}
