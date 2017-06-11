#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "pokeapp.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Poke App
    qmlRegisterType<PokeApp>("PokeApp.Classes.Core", 1, 0, "PokeApp");
    PokeApp pokeApp;

    // Image Provider
    engine.addImageProvider(QLatin1String("imgp"), pokeApp.getImageProvider());

    QQmlContext *ctxt0 = engine.rootContext();
    ctxt0->setContextProperty("pokeApp", &pokeApp);
    QQmlContext *ctxt1 = engine.rootContext();
    ctxt1->setContextProperty("mousePosition", pokeApp.getMousePosProvider());
    QQmlContext *ctxt2 = engine.rootContext();
    ctxt2->setContextProperty("albumsModel", pokeApp.getAlbumsModel());
    QQmlContext *ctxt3 = engine.rootContext();
    ctxt3->setContextProperty("cardsModel", pokeApp.getCardsModel());
    QQmlContext *ctxt5 = engine.rootContext();
    ctxt5->setContextProperty("albumsManager", pokeApp.getAlbumsManager());
    QQmlContext *ctxt6 = engine.rootContext();
    ctxt6->setContextProperty("cardsManager", pokeApp.getCardsManager());
    QQmlContext *ctxt7 = engine.rootContext();
    ctxt7->setContextProperty("viewManager", pokeApp.getViewManager());

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    return app.exec();
}
