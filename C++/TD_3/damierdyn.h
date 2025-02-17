#ifndef DAMIERDYN_H
#define DAMIERDYN_H

#include <iostream>
using namespace std;

class DamierDyn
{
public:
    DamierDyn(int l, int c, int vd);
    DamierDyn(const DamierDyn &D);
    ~DamierDyn();

    DamierDyn& operator=(const DamierDyn &D); // opérateur d'affectation
    friend DamierDyn operator+(const DamierDyn &A, const DamierDyn &B);
    DamierDyn& operator+=(const DamierDyn &D);
    friend ostream& operator<< (ostream& sortie, DamierDyn &D);


    void Print();
    void Init(int value);
    void Set(int x, int y, int value);
    void ReDim(int l, int c, int vd = -7);

private:
    int L;
    int C;
    int** T;

    // Méthode privée (factorisation  de code)
    void Alloc(int l, int c);
    void Free();
};

#endif // DAMIERDYN_H
