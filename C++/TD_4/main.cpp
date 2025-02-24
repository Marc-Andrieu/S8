#include <iostream>

using namespace std;

#include "damierstat.h"
#include "damierdyn.h"

int main()
{
    // DamierStat alloué statiquement
    DamierStat Da;
    Da.Init(7);
    Da.Set(2, 4, -2);   // Modification de la case (2, 4) avec la valeur -2
    Da.Print();

    // DamierStat alloué dynamiquement
    DamierStat* Db = new DamierStat();
    Db->Init(0);
    (*Db).Init(0);
    Db->Set(0, 0, -1);
    Db->Print();
    delete Db;

    // DamierDyn alloué statiquement
    DamierDyn D2(3, 5, 0);
    D2.Init(-10);
    D2.Set(1,1, -343);
    D2.Print();
    DamierDyn D3(D2);
    D3.Set(1,1, 20000);
    D2.Print();
    D3.Print();

    D3.ReDim(2,4);
    D3.Print();

    D2 = D3;
    D2.Print();

    // DamierDyn alloué dynamiquement
    DamierDyn* pointDamier = new DamierDyn(3, 5, -8);
    pointDamier->Print();
    delete pointDamier;

    return 0;
}
