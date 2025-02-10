#include <iostream>
#include "damierstat.h"
#include <iomanip> // pr le setw
using namespace std;

DamierStat::DamierStat() { // OK
    Init(0);
}

void DamierStat::Init(int n) { // OK
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 5; j++) {
            damier[i][j] = n;
        }
    }
}

void DamierStat::Set (int i, int j, int n) { // OK
    if ( // C pas memory-safe, donc t'as vrmt intérêt à mettre ce garde-fou
        i >= 0
        && i < 4
        && j >= 0
        && j < 5
    )
        damier[i][j] = n;
    else
        cout << "Indices hors bornes" << endl;
}

void DamierStat::Print() {
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 5; j++) {
            cout << setw(4) << damier[i][j] << " ";
            // setw pr ut exactement 4 char pr chaque int
        }
        cout << endl;
    }
    cout << endl;
}
