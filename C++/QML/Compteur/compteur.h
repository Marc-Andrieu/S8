#ifndef COMPTEUR_H
#define COMPTEUR_H

#include <QObject>

class Compteur : public QObject
{
    Q_OBJECT
    public:
        explicit Compteur(QObject *parent = nullptr, int fCompteur = 0);
        Q_INVOKABLE void increment();
        Q_INVOKABLE void decrement();
        Q_PROPERTY(QString cptQML READ readCompteur NOTIFY cptChanged)
    private:
        int fCompteur;
        QString readCompteur();

    signals:
        void cptChanged();
};

#endif // COMPTEUR_H
