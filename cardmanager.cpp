#include "cardsmanager.h"

CardsManager::CardsManager(QObject* parent): QObject(parent)
{
    this->networkManager = new QNetworkAccessManager(this);
    connect(&m_mapper, SIGNAL(mapped(int)), this,
    SLOT(mappedReply(int)));
}

void CardsManager::setDatabase(QSqlDatabase* database)
{
    this->database = database;
}

void CardsManager::setImageProvider(ImageProvider* imageProvider)
{
    this->imageProvider = imageProvider;
}

void CardsManager::setViewManager(ViewManager* viewManager)
{
    this->viewManager = viewManager;
}

void CardsManager::addCard(int albID, QString crdReq)
{
    qDebug() << "CardsSQLManager's addCard called for CardReq: " << crdReq << " in Album " << albID;
    QString insertCardCommand = "INSERT INTO [dbo].[Cards]([albumMID],[imageURL],[loaded],[cardAdded],[cardEdited]) VALUES(:albumMID,:imageURL,:loaded,:cardAdded,:cardEdited)";
    int crdID;
    QSqlQuery qryCard;
    qryCard.prepare(insertCardCommand);
    qryCard.bindValue(":albumMID",albID);
    qryCard.bindValue(":imageURL", ":/gui/GUI/emptyCard.png");
    qryCard.bindValue(":loaded",false);
    qryCard.bindValue(":cardAdded",QDateTime::currentDateTime());
    qryCard.bindValue(":cardEdited",QDateTime::currentDateTime());
    if(qryCard.exec())
    {
        crdID = qryCard.lastInsertId().toInt();
        qDebug() << "CardsManager's addCard added Partial data for crdReq: " << crdReq << ". cardReq is now Card: " << crdID << " and it has been added to Album: " << albID;
        this->imageProvider->addPlaceHolderImage(":/gui/GUI/emptyCard.png",crdID,albID);
    }
    else
    {
        qDebug() << "ERROR: CardsSQLManager's addCard couldn't add crdReq: " << crdReq << " to Album: " << albID << " using query: " << insertCardCommand;
        qDebug() << database->lastError();
    }

    // Make Network Request
    QString requestURL = "https://api.pokemontcg.io/v1/cards/";
    requestURL.append(crdReq);
    QNetworkReply* reply = networkManager->get(QNetworkRequest(QUrl(requestURL)));
    connect(reply, SIGNAL(finished()), &m_mapper, SLOT(map()));
    m_replies.insert(crdID, reply);
    m_mapper.setMapping(reply, crdID);
}


void CardsManager::removeCard(int crdID, int albID)
{

    QString removeCardCommand = "DELETE FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(removeCardCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        // Update  Album last edited
        qDebug() << "Card " << crdID << " deleted.";
        emit cardRemoved(albID,crdID);

        QString updateAlbum = "UPDATE Albums SET albumEdited=:albumEdited WHERE ID=:albID";
        QSqlQuery qryAlbum;
        qryAlbum.prepare(updateAlbum);
        qryAlbum.bindValue(":albID", albID);
        qryAlbum.bindValue(":albumEdited", QDateTime::currentDateTime());
        if(qryAlbum.exec())
        {
            qDebug() << "Album " << albID << ": lastEdited updated.";
            emit albumUpdated(albID);
        }
        else
        {
            qDebug() << "Couldn't update Album " << albID << ": lastEdited.";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't remove Card " << crdID << ".";
        qDebug() << database->lastError();
    }
    this->viewManager->refreshCards();
    this->viewManager->refreshAlbums();
}


// Getters
int CardsManager::getAlbumMID(int crdID)
{
    int albumMID;
    QString getAlbumMIDCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getAlbumMIDCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            albumMID = qryCard.value(1).toInt();
//            qDebug() << "Card " << crdID << " has albumMID: " << albumMID << ".";
        }
        else
        {
            qDebug() << "Couldn't get albumMID for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get albumMID for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return albumMID;
}

QString CardsManager::getAlbumName(int crdID)
{
    int albumMID;
    QString albumName;
    QString getAlbumMIDCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getAlbumMIDCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            albumMID = qryCard.value(1).toInt();
//            qDebug() << "Card " << crdID << " has albumMID: " << albumMID << ".";
        }
        else
        {
            qDebug() << "Couldn't get albumMID for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get albumMID for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }


    QString getAlbumNameCommand = "SELECT FROM Albums WHERE ID =:albumMID";
    QSqlQuery qryAlbum;
    qryAlbum.prepare(getAlbumNameCommand);
    qryAlbum.bindValue(":albumMID", albumMID);
    if(qryAlbum.exec())
    {
        if(qryAlbum.first())
        {
            albumName = qryAlbum.value(1).toString();
//            qDebug() << "Card " << crdID << " has albumName: " << albumName << ".";
        }
        else
        {
            qDebug() << "Couldn't get albumName for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get albumName for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return albumName;

}

QString CardsManager::getName(int crdID)
{
    QString name;
    QString getNameCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getNameCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            name = qryCard.value(3).toString();
//            qDebug() << "Card " << crdID << " has name: " << name << ".";
        }
        else
        {
            qDebug() << "Couldn't get name for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get name for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return name;
}

QString CardsManager::getImageURL(int crdID)
{
    QString imageURL;
    QString getImageURLCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getImageURLCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            imageURL = qryCard.value(4).toString();
//            qDebug() << "Card " << crdID << " has imageURL: " << imageURL << ".";
        }
        else
        {
            qDebug() << "Couldn't get imageURL for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get imageURL for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return imageURL;
}

QString CardsManager::getSubtype(int crdID)
{
    QString subtype;
    QString getSubtypeCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getSubtypeCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            subtype = qryCard.value(5).toString();
//            qDebug() << "Card " << crdID << " has subtype: " << subtype << ".";
        }
        else
        {
            qDebug() << "Couldn't get subtype for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get subtype for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return subtype;
}

QString CardsManager::getSupertype(int crdID)
{
    QString supertype;
    QString getSupertypeCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getSupertypeCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            supertype = qryCard.value(6).toString();
//            qDebug() << "Card " << crdID << " has supertype: " << supertype << ".";
        }
        else
        {
            qDebug() << "Couldn't get supertype for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get supertype for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return supertype;
}

int CardsManager::getNumber(int crdID)
{
    int number;
    QString getNumberCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getNumberCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            number = qryCard.value(7).toInt();
//            qDebug() << "Card " << crdID << " has number: " << number << ".";
        }
        else
        {
            qDebug() << "Couldn't get number for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get number for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return number;
}

QString CardsManager::getArtist(int crdID)
{
    QString artist;
    QString getArtistCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getArtistCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            artist = qryCard.value(8).toString();
//            qDebug() << "Card " << crdID << " has artist: " << artist << ".";
        }
        else
        {
            qDebug() << "Couldn't get artist for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get artist for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return artist;
}

QString CardsManager::getRarity(int crdID)
{
    QString rarity;
    QString getCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            rarity = qryCard.value(9).toString();
//            qDebug() << "Card " << crdID << " has rarity: " << rarity << ".";
        }
        else
        {
            qDebug() << "Couldn't get rarity for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get rarity for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return rarity;
}

QString CardsManager::getSeries(int crdID)
{
    QString series;
    QString getCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            series = qryCard.value(10).toString();
//            qDebug() << "Card " << crdID << " has series: " << series << ".";
        }
        else
        {
            qDebug() << "Couldn't get series for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get series for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return series;
}

QString CardsManager::getSet(int crdID)
{
    QString set;
    QString getCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            set = qryCard.value(11).toString();
//            qDebug() << "Card " << crdID << " has set: " << set << ".";
        }
        else
        {
            qDebug() << "Couldn't get set for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get set for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return set;
}

QString CardsManager::getSetcode(int crdID)
{
    QString setcode;
    QString getCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            setcode = qryCard.value(12).toString();
//            qDebug() << "Card " << crdID << " has setcode: " << setcode << ".";
        }
        else
        {
            qDebug() << "Couldn't get setcode for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get setcode for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return setcode;
}

QString CardsManager::getCondition(int crdID)
{
    QString condition;
    QString getCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            condition = qryCard.value(13).toString();
//            qDebug() << "Card " << crdID << " has condition: " << condition << ".";
        }
        else
        {
            qDebug() << "Couldn't get condition for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get condition for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return condition;
}

QString CardsManager::getStatus(int crdID)
{
    QString status;
    QString getCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            status = qryCard.value(14).toString();
//            qDebug() << "Card " << crdID << " has status: " << status << ".";
        }
        else
        {
            qDebug() << "Couldn't get status for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get status for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return status;
}

bool CardsManager::getLoaded(int crdID)
{
    bool loaded;
    QString getCommand = "SELECT FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            loaded = qryCard.value(15).toBool();
            if(loaded == 0)
            {
                loaded = true;
            }
            else {
                loaded = false;
            }

//            qDebug() << "Card " << crdID << " has loaded: " << loaded << ".";
        }
        else
        {
            qDebug() << "Couldn't get loaded for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get loaded for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return loaded;
}

QDateTime CardsManager::getAdded(int crdID)
{
    QDateTime added;
    QString getCommand = "SELECT cardAdded FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            added = qryCard.value(0).toDateTime();
//            qDebug() << "Card " << crdID << " has added: " << added << ".";
        }
        else
        {
            qDebug() << "Couldn't get added for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get added for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    return added;
}

QDateTime CardsManager::getEdited(int crdID)
{
    QDateTime edited;
    QString getCommand = "SELECT cardEdited FROM Cards WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(getCommand);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            edited = qryCard.value(0).toDateTime();
            qDebug() << "Card " << crdID << " has edited: " << edited << ".";
        }
        else
        {
            qDebug() << "Couldn't get edited for Card: " << crdID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get edited for Card:" << crdID << ".";
        qDebug() << database->lastError();
    }
    return edited;
}


// Setters
void CardsManager::setAlbumMID(int albumMID,int crdID)
{
    QString setCommand = "UPDATE Cards SET albumMID=:albumMID WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(setCommand);
    qryCard.bindValue(":albumMID", albumMID);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {

        qDebug() << "albumMID for cardID " << crdID << " has been changed to : " << albumMID << ".";

    }
    else
    {
        qDebug() << "Couldn't change albumMID for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    this->viewManager->refreshCards();
    this->viewManager->refreshAlbums();
}

void CardsManager::setAlbumName(QString albumName,int crdID)
{
    qDebug() << "setAlbumName requested for crdID " << crdID << ".";
    int albumMID = -1;
    QString findAlbumID = "SELECT ID FROM Albums WHERE albumName=:albumName";
    QSqlQuery qryFind;
    qryFind.prepare(findAlbumID);
    qryFind.bindValue(":albumName", albumName);
    if(qryFind.exec())
    {
        if(qryFind.first())
        {
            // Retreived Album ID
            albumMID = qryFind.value(0).toInt();
            qDebug() << "albumName has albumMID:" << albumMID;
        }
    }
    else
    {
        qDebug() << "Error: Couldn't get albumMID for album: " << albumName;
        qDebug() << database->lastError();
    }

    QString setCommand = "UPDATE Cards SET albumMID=:albumMID WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(setCommand);
    qryCard.bindValue(":albumMID", albumMID);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {

        qDebug() << "albumMID for cardID " << crdID << " has been changed to : " << albumMID << ".";

    }
    else
    {
        qDebug() << "Couldn't change albumMID for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    this->viewManager->refreshCards();
    this->viewManager->refreshAlbums();
}

void CardsManager::setCondition(QString condition, int crdID)
{
    QString setCommand = "UPDATE Cards SET condition=:condition WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(setCommand);
    qryCard.bindValue(":condition", condition);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {

        qDebug() << "condition for cardID " << crdID << " has been changed to : " << condition << ".";

    }
    else
    {
        qDebug() << "Couldn't change condition for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    this->viewManager->refreshCards();
    this->viewManager->refreshAlbums();
}

void CardsManager::setStatus(QString status, int crdID)
{
    QString setCommand = "UPDATE Cards SET status=:status WHERE ID =:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(setCommand);
    qryCard.bindValue(":status", status);
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {

        qDebug() << "status for cardID " << crdID << " has been changed to : " << status << ".";

    }
    else
    {
        qDebug() << "Couldn't change status for Card: " << crdID << ".";
        qDebug() << database->lastError();
    }
    this->viewManager->refreshCards();
    this->viewManager->refreshAlbums();
}



void CardsManager::mappedReply(int crdID)
{
    int albID;
    qDebug() << "CardsSQLManager's mappedReply received for card " << crdID;
    QNetworkReply *reply = m_replies.take(crdID);
    const QByteArray data = reply->readAll();

    // Open JSON document
    QString val = data;
    QJsonDocument jsonDocument = QJsonDocument::fromJson(val.toUtf8());
    QJsonObject rootObject = jsonDocument.object();
    QJsonValue value = rootObject.value(QString("card"));
    QJsonObject cardRootValues = value.toObject();

    // Get Album ID
    QString selectAlbumCardsCommand = "SELECT * FROM Cards WHERE ID=:crdID";
    QSqlQuery qrySelectCards;
    qrySelectCards.prepare(selectAlbumCardsCommand);
    qrySelectCards.bindValue(":crdID",crdID);
    if(qrySelectCards.exec())
    {
        if(qrySelectCards.first())
        {
            // Retreived Album ID
            albID = qrySelectCards.value(1).toInt();
            qDebug() << "CardsSQLManager's mappedReply retreived albID:" << albID << " for Card " << crdID;
        }
        else
        {
            qDebug() << "CardsSQLManager's mappedReply coudln't find albID for Card: " << crdID << " in the Cards database using query:" << selectAlbumCardsCommand;
        }

    }
    else
    {
        // Failed to retreive Album ID
        qDebug() << "CardsSQLManager's mappedReply coudln't retreived albID for Card " << crdID << " using query: " << selectAlbumCardsCommand;
        qDebug() << database->lastError();
    }

    QString insertCardCommand = "UPDATE Cards SET cardID=:cardID, name=:name, imageURL=:imageURL, subtype=:subtype, supertype=:supertype, number=:number, artist=:artist, rarity=:rarity, series=:series, setName=:setName, setCode=:setCode, condition=:condition, status=:status, cardEdited=:cardEdited WHERE ID=:crdID";
    QSqlQuery qryCard;
    qryCard.prepare(insertCardCommand);
    qryCard.bindValue(":cardID",cardRootValues.value("id").toString());
    qryCard.bindValue(":name",cardRootValues.value("name").toString());
    qryCard.bindValue(":imageURL",cardRootValues.value("imageUrl").toString());
    qryCard.bindValue(":subtype",cardRootValues.value("subtype").toString());
    qryCard.bindValue(":supertype",cardRootValues.value("supertype").toString());
    qryCard.bindValue(":number",cardRootValues.value("number").toInt());
    qryCard.bindValue(":artist",cardRootValues.value("artist").toString());
    qryCard.bindValue(":rarity",cardRootValues.value("rarity").toString());
    qryCard.bindValue(":series",cardRootValues.value("series").toString());
    qryCard.bindValue(":setName",cardRootValues.value("set").toString());
    qryCard.bindValue(":setCode",cardRootValues.value("setCode").toString());
    qryCard.bindValue(":condition","Not specified");
    qryCard.bindValue(":status","Not specified");
    qryCard.bindValue(":cardEdited",QDateTime::currentDateTime());
    qryCard.bindValue(":crdID", crdID);
    if(qryCard.exec())
    {
        // Update  Album last edited
        qDebug() << "CardsSQLManager's mappedReply updated Card " << crdID << " in Album " << albID << " with received values from network reply.";
        this->imageProvider->addCardImage(cardRootValues.value("imageUrl").toString(), crdID, albID);
        this->viewManager->refreshCards();


        QString updateAlbum = "UPDATE Albums SET albumEdited=:albumEdited WHERE ID=:albID";
        QSqlQuery qryAlbum;
        qryAlbum.prepare(updateAlbum);
        qryAlbum.bindValue(":albID", albID);
        qryAlbum.bindValue(":albumEdited", QDateTime::currentDateTime());
        if(qryAlbum.exec())
        {
            qDebug() << "CardsSQLManager's mappedReply updated Album " << albID << "'s lastEdited.";
            emit albumUpdated(albID);
            this->viewManager->refreshAlbums();
        }
        else
        {
            qDebug() << "CardsSQLManager's mappedReply couldn't update Album " << albID << "'s lastEdited with query: " << updateAlbum;
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "CardsSQLManager's mappedReply couldn't update Card " << crdID <<  " in Album " << albID << " with query: " << insertCardCommand;
        qDebug() << database->lastError();
    }
    reply->deleteLater();

}


void CardsManager::cardImageAdded(int crdID, int albID)
{
    qDebug() << "CardsSQLManager's cardImageAdded has received signal for Card " << crdID << " in Album " << albID;
    QString updateCard = "UPDATE Cards SET loaded=:loaded WHERE ID=:crdID";
    QSqlQuery qry;
    qry.prepare(updateCard);
    qry.bindValue(":loaded", true);
    qry.bindValue(":ID", crdID);
    if(qry.exec())
    {
        qDebug() << "CardsSQLManager's cardImageAdded has set Card " << crdID << " in Album " << albID << " as loaded.";
        emit albumUpdated(albID);
        emit cardUpdated(crdID,albID);
        this->viewManager->refreshCards();
        this->viewManager->refreshAlbums();
    }
    else
    {
        qDebug() << "CardsSQLManager's cardImageAdded couldn't set Card " << crdID << " in Album " << albID << " as loaded using query: " << updateCard;
        qDebug() << database->lastError();
    }
}

void CardsManager::cardPlaceHolderAdded(int crdID, int albID)
{
    qDebug() << "CardsSQLManager's cardPlaceHolderAdded has received signal for Card " << crdID << " in Album " << albID;
    emit albumUpdated(albID);
    emit cardUpdated(crdID,albID);
    this->viewManager->refreshCards();
    this->viewManager->refreshAlbums();

}
