#include <iostream>
#include "damierdyn.h"
using namespace std;


DamierDyn::DamierDyn(int l, int k, int n) {
    Redim(l, k);
    Init(n);
}

void DamierDyn::Redim(int l, int k) {
    if (damier) {
        for (int i = 0; i < l; i++) {
            delete [] damier[i];
        }
        delete [] damier;
    }

    damier = new int*[l];
    for (int i = 0; i < l; i++) {
        damier[i] = new int[k];
    }
    Init(0);
}

void DamierDyn::Init(int n) {
    for (int i = 0; i < l; i++) {
        for (int j = 0; j < k; j++) {
            damier[i][j] = n;
        }
        cout << endl;
    }
}

void DamierDyn::Set (int i, int j, int n) { // OK
    if ( // C pas memory-safe, donc t'as vrmt intérêt à mettre ce garde-fou
        i >= 0
        && i < l
        && j >= 0
        && j < k
        )
        damier[i][j] = n;
    else
        cout << "Indices hors bornes" << endl;
}

void DamierDyn::Print() {
    for (int i = 0; i < l; i++) {
        for (int j = 0; j < k; j++) {
            cout << damier[i][j] << " ";
        }
        cout << endl;
    }
    cout << endl;
}
