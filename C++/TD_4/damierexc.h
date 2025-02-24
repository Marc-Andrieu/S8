#ifndef DAMIEREXC_H
#define DAMIEREXC_H

#include <iostream>
using namespace std;
#include <exceptiondamier.h>

class DamierExc
{
public:
    DamierExc(int l, int c, int vd);
    DamierExc(const DamierExc &D);
    ~DamierExc();

    DamierExc& operator=  (const DamierExc &D); // opérateur d'affectation

    void Print();
    void Init(int value);
    void Set(int x, int y, int value);
    void ReDim(int l, int c, int vd = -7);

protected:
    int L;
    int C;
    int** T;
    int B;
    virtual void InitJeu() = 0; // rend abstraite DamierExc
    // et force les classes filles à l'implémenter

private:
    // Méthode privée (factorisation  de code)
    void Alloc(int l, int c);
    void Free();
};

#endif // DAMIEREXC_H
