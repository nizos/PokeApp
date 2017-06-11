#include "albumsmanager.h"

AlbumsManager::AlbumsManager(QObject* parent) : QObject(parent)
{

}


void AlbumsManager::setDatabase(QSqlDatabase* database)
{
    this->database = database;
}

void AlbumsManager::setCardsManager(CardsManager* cardsManager)
{
    this->cardsManager = cardsManager;
}

void AlbumsManager::setViewManager(ViewManager* viewManager)
{
    this->viewManager = viewManager;
}

void AlbumsManager::addAlbum(QString albReq)
{
    int albID;
    QString insertAlbumCommand = "INSERT INTO [dbo].[Albums]([albumName],[albumAdded],[albumEdited]) VALUES(:albumName,:albumAdded,:albumEdited)";

    QSqlQuery qryAlbum;
    qryAlbum.prepare(insertAlbumCommand);
    qryAlbum.bindValue(":albumName",albReq);
    qryAlbum.bindValue(":albumAdded",QDateTime::currentDateTime());
    qryAlbum.bindValue(":albumEdited",QDateTime::currentDateTime());
    if(qryAlbum.exec())
    {
        albID = qryAlbum.lastInsertId().toInt();
        qDebug() << "Album " << albID << " Added";
        emit albumAdded(albID);
        viewManager->refreshAlbums();
    }
    else
    {
        qDebug() << "ERROR: Could not add Album: " << albReq << database->lastError();
    }
}


void AlbumsManager::removeAlbum(int albID)
{
    QString deleteAlbumCommand = "DELETE FROM Albums WHERE ID =:albID";
    QSqlQuery qryAlbum;
    qryAlbum.prepare(deleteAlbumCommand);
    qryAlbum.bindValue(":albID",albID);
    if(qryAlbum.exec())
    {
        // Album deleted
        qDebug() << "Album " << albID << " Removed.";
        emit albumRemoved(albID);
        viewManager->refreshAlbums();

        // If Album removed, remove cards
        int crdID;
        QString selectAlbumCardsCommand = "SELECT FROM Cards WHERE albumMID =:albID";
        QSqlQuery qrySelectCards;
        qrySelectCards.prepare(selectAlbumCardsCommand);
        qrySelectCards.bindValue(":albID",albID);
        while(qrySelectCards.next())
        {
            // Found Card in Album
            crdID = qrySelectCards.value(0).toInt();
//            qDebug() << "Card Found. Card: " << crdID << " in Album: " << albID << ".";

            // Delete Card
            QString deleteAlbumCardsCommand = "DELETE FROM Cards WHERE ID =:crdID";
            QSqlQuery qryCards;
            qryCards.prepare(deleteAlbumCardsCommand);
            qryCards.bindValue(":crdID",crdID);
            if(qryCards.exec())
            {
                // Card deleted
                qDebug() << "Card " << crdID << "Removed.";
                emit cardRemoved(albID, crdID);
            }
            else
            {
                // Coudln't delete Card
                qDebug() << "ERROR: Could not remove Card: " << crdID << " from Album: " << albID << ".";
                qDebug() << database->lastError();
            }
        }
        viewManager->refreshAlbums();
        viewManager->refreshCards();
        if(!qrySelectCards.exec())
        {
            // Couldn't delete Cards
            qDebug() << "ERROR: Could not delete Cards in Album: " << albID << ".";
            qDebug() << database->lastError();
        }
    }
    else
    {
        // Couldn't delete Album
        qDebug() << "ERROR: Could not delete Album: " << albID << ".";
        qDebug() << database->lastError();
    }
}

void AlbumsManager::addCard(QString albName, QString crdReq)
{
    qDebug() << "addCard requested for albName " << albName << " and crdReq " << crdReq;
    int albID = -1;
    QString findAlbumID = "SELECT ID FROM Albums WHERE albumName=:albName";
    QSqlQuery qryFind;
    qryFind.prepare(findAlbumID);
    qryFind.bindValue(":albName", albName);
    if(qryFind.exec())
    {
        if(qryFind.first())
        {
            // Retreived Album ID
            albID = qryFind.value(0).toInt();
//            qDebug() << "albName has ID:" << albID;
        }
    }
    else
    {
        qDebug() << "Error: Couldn't get ID for album: " << albName;
        qDebug() << database->lastError();
    }
//    if(nrOfCards == -1)
//    {
//        QString exc = "Error: Couldn't get nr. of Cards.";
//        throw exc;
//    }

    this->cardsManager->addCard(albID,crdReq);
}

void AlbumsManager::removeCard(int albID, int crdID)
{
    this->cardsManager->removeCard(albID,crdID);
}


int AlbumsManager::getNrOfCards(int albID)
{
    int nrOfCards = 0;
    QSqlQuery qry;
    qry.prepare("SELECT * FROM Cards WHERE albumMID=:albID");
    qry.bindValue(":albID",albID);
    if(qry.exec())
    {
        while(qry.next())
        {
            nrOfCards++;
        }
    }
    else
    {
        qDebug() << "Error: Couldn't get nr. of Cards in Album " << albID << ".";
        qDebug() << database->lastError();
    }
//    if(nrOfCards == -1)
//    {
//        QString exc = "Error: Couldn't get nr. of Cards.";
//        throw exc;
//    }
//    qDebug() << "Cards in Album: " << albID << " = " << nrOfCards;
    return nrOfCards;
}


int AlbumsManager::getNrOfCards(QString albName)
{
    // Get Album Name from Album ID
    int albID = -1;
    QString findAlbumID = "SELECT ID FROM Albums WHERE albumName=:albName";
    QSqlQuery qryFind;
    qryFind.prepare(findAlbumID);
    qryFind.bindValue(":albName", albName);
    if(qryFind.exec())
    {
        if(qryFind.first())
        {
            // Retreived Album ID
            albID = qryFind.value(0).toInt();
//            qDebug() << "Album " << albName << " has ID:" << albID;
        }
    }
    else
    {
        qDebug() << "Error: Couldn't get ID for album: " << albName;
        qDebug() << database->lastError();
    }

    // Get nr. of Cards in Album
    int nrOfCards = 0;
    QSqlQuery qry;
    qry.prepare("SELECT Count(ID) FROM Cards WHERE albumMID=:albID");
    qry.bindValue(":albID",albID);
    if(qry.exec())
    {
        nrOfCards = qry.value(0).toInt();
//        qDebug() << "Nr. of Cards in Album " << albID << ": " << nrOfCards << ".";
    }
    else
    {
        qDebug() << "Error: Couldn't get nr. of Cards in Album " << albID << ".";
        qDebug() << database->lastError();
    }
    return nrOfCards;
}

int AlbumsManager::getNrOfCards()
{
    int nrOfCards = 0;
    QSqlQuery qry;
    qry.prepare("SELECT * FROM Cards");
    if(qry.exec())
    {
        while(qry.next())
        {
            nrOfCards++;
        }
    }
    else
    {
        qDebug() << "Error: Couldn't get total nr. of cards.";
        qDebug() << database->lastError();
    }
//    if(nrOfCards == -1)
//    {
//        QString exc = "Error: Couldn't get nr. of Cards.";
//        throw exc;
//    }
//    qDebug() << "Total cards: " << nrOfCards;
    return nrOfCards;
}

int AlbumsManager::getNrOfAlbums()
{
    int nrOfAlbums = 0;
    QSqlQuery qry;
    qry.prepare("SELECT * FROM Albums");
    if(qry.exec())
    {
        while(qry.next())
        {
            nrOfAlbums++;
        }
    }
    else
    {
        qDebug() << "Error: Couldn't get nr. of Albums.";
        qDebug() << database->lastError();
    }
//    if(nrOfAlbums == -1)
//    {
//        QString exc = "Error: Couldn't get nr. of Albums.";
//        throw exc;
//    }
//    qDebug() << "Nr of Albums = " << nrOfAlbums;
    return nrOfAlbums;
}


QDateTime AlbumsManager::getAlbumAdded(int albID)
{
    QDateTime added;
    QString getCommand = "SELECT albumAdded FROM Albums WHERE ID =:albID";
    QSqlQuery qryCard;
    qryCard.prepare(getCommand);
    qryCard.bindValue(":albID", albID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            added = qryCard.value(0).toDateTime();
//            qDebug() << "Album " << albID << " has added: " << added << ".";
        }
        else
        {
            qDebug() << "Couldn't get added for Album: " << albID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get added for Album: " << albID << ".";
        qDebug() << database->lastError();
    }
    return added;
}

QDateTime AlbumsManager::getAlbumEdited(int albID)
{
    QDateTime edited;
    QString getCommand = "SELECT albumEdited FROM Albums WHERE ID =:albID";
    QSqlQuery qryCard;
    qryCard.prepare(getCommand);
    qryCard.bindValue(":albID", albID);
    if(qryCard.exec())
    {
        if(qryCard.first())
        {
            edited = qryCard.value(0).toDateTime();
            qDebug() << "Album " << albID << " has edited: " << edited << ".";
        }
        else
        {
            qDebug() << "Couldn't get edited for Album: " << albID << ".";
            qDebug() << database->lastError();
        }

    }
    else
    {
        qDebug() << "Couldn't get edited for Album:" << albID << ".";
        qDebug() << database->lastError();
    }
    return edited;
}
