#include "pokeapp.h"

PokeApp::PokeApp(QObject *parent): QObject(parent)
{

    // Register Types
    qmlRegisterType<AlbumsModel>("PokeApp.Classes.Core", 1, 0, "AlbumsModel");
    qmlRegisterType<CardsModel>("PokeApp.Classes.Core", 1, 0, "CardsModel");
    qmlRegisterType<ProxyModel>("PokeApp.Classes.Core", 1, 0, "ProxyModel");
    qmlRegisterType<AlbumsManager>("PokeApp.Classes.Core", 1, 0, "AlbumsManager");
    qmlRegisterType<CardsManager>("PokeApp.Classes.Core", 1, 0, "CardsManager");
    qmlRegisterType<ImageProvider>("PokeApp.Classes.Core", 1, 0, "ImageProvider");
    qmlRegisterType<CursorPosProvider>("PokeApp.Classes.Core", 1, 0, "CursorPosProvider");
    qmlRegisterType<ViewManager>("PokeApp.Classes.Core", 1, 0, "ViewManager");


    // Database
    QString serverName = "DESKTOP-MAIN\\SQLEXPRESS";
    QString dbName = "pokeManager";
    this->database = QSqlDatabase::addDatabase("QODBC");
    this->database.setConnectOptions();
    QString dsn = QString("DRIVER={SQL SERVER};SERVER=%1;DATABASE=%2;Trusted_Connection=Yes;").arg(serverName).arg(dbName);
    database.setDatabaseName(dsn);
    if(database.open())
    {
        qDebug() << "Connection to database opened.";
    }
    else
    {
        qDebug() << "ERROR: Couldn't connect to database!\n" << database.lastError();
    }

    // View Manager
    this->viewManager = new ViewManager();

    // Album Manager
    this->albumsManager = new AlbumsManager();
    this->albumsManager->setDatabase(&database);
    this->albumsManager->setViewManager(viewManager);

    // Card Manager
    this->cardsManager = new CardsManager();
    this->cardsManager->setDatabase(&database);
    this->cardsManager->setViewManager(viewManager);

    // Albums Model
    this->albumsModel = new AlbumsModel(0,database.database());
    this->albumsModel->setTable("Albums");
    this->albumsModel->select();

    // Cards Model
    this->cardsModel = new CardsModel(0,database.database());
    this->cardsModel->setTable("Cards");
    this->cardsModel->setRelation(1, QSqlRelation("Albums", "ID", "albumName"));
    this->cardsModel->select();

    // Proxy Model
    this->proxyModel = new ProxyModel();

    // Image Provider
    this->imageProvider = new ImageProvider();

    // Cursor Pos Provider
    this->mousePosProvider = new CursorPosProvider();

    // View Manager
    this->viewManager->setAlbumsModel(albumsModel);
    this->viewManager->setCardsModel(cardsModel);
    this->viewManager->setProxyModel(proxyModel);

    // Connect
    this->albumsManager->setCardsManager(cardsManager);
    this->cardsManager->setImageProvider(imageProvider);
}


// Getters
QSqlDatabase* PokeApp::getDatabase() const
{
    return const_cast<QSqlDatabase*>(&database);
}

AlbumsManager* PokeApp::getAlbumsManager() const
{
    return albumsManager;
}

CardsManager* PokeApp::getCardsManager() const
{
    return cardsManager;
}

AlbumsModel* PokeApp::getAlbumsModel() const
{
    return albumsModel;
}

CardsModel* PokeApp::getCardsModel() const
{
    return cardsModel;
}

ProxyModel* PokeApp::getProxyModel() const
{
    return proxyModel;
}

ImageProvider* PokeApp::getImageProvider() const
{
    return imageProvider;
}

CursorPosProvider* PokeApp::getMousePosProvider() const
{
    return mousePosProvider;
}

ViewManager* PokeApp::getViewManager() const
{
    return viewManager;
}


PokeApp::~PokeApp()
{
    this->database.close();
    qDebug() << "Connection to database closed.";
}
