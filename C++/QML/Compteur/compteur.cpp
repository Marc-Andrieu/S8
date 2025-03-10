#include "compteur.h"

Compteur::Compteur(QObject *parent, int fCompteur) : QObject{parent} {}

void Compteur::increment(){
    fCompteur++;
    emit cptChanged();
}

void Compteur::decrement(){
    fCompteur--;
    emit cptChanged();
}

QString Compteur::readCompteur() {
    return QString::number(fCompteur);
    emit cptChanged();
}
