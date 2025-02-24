#include "dames.h"

Dames::Dames(): DamierExc(10, 10, 3) {
    InitJeu();
}

Dames::Dames(Dames &D):DamierExc(D) { // par recopie
}

Dames& Dames::operator=(Dames& D) { // affectation
    this -> DamierExc::operator=(D);
    attr2 = C.attr2;
    return *this;
}
