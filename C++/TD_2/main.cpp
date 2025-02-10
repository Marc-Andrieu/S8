#include "damierstat.h"
#include "damierdyn.h"

using namespace std;

int main()
{
    DamierStat D1;      // Création du Damier et initialisation des cases à 0
    D1.Init(7);         // Initialisation de toutes les cases à 7
    D1.Print();
    D1.Set(2, 4, -2);   // Modification de la case (2, 4) avec la valeur -2
    D1.Print();         // Affichage du tableau

    DamierStat *D2;
    D2 = new DamierStat;
    D2 -> Print();

    DamierDyn D3(3, 2, 42);
    D3.Print();
}
