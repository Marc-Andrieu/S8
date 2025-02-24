#ifndef DAMES_H
#define DAMES_H

#include "damierexc.h"

class Dames : public DamierExc  {
    public:
        Dames();
        Dames(&D);
        void operator=(Dames& D);
    protected:
        InitJeu();
};

#endif // DAMES_H
