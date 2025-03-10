#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>                // <-- AJOUT ICI
#include "compteur.h"                 // <-- AJOUT ICI

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    Compteur aCompteur ;               // <-- AJOUT ICI

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("vueObjetCpt", &aCompteur); // <-- AJOUT ICI
    engine.loadFromModule("compteur", "Main");

    return app.exec();
}
