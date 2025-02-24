#include "damierdyn.h"

DamierDyn::DamierDyn(int l, int c, int vd)
{
    Alloc(l, c);
    Init(vd);
}

DamierDyn::DamierDyn(const DamierDyn &D)
{
    Alloc(D.L, D.C);
    for(int i=0; i<L; i++)
        for(int j=0; j<C; j++)
            T[i][j] = D.T[i][j];
}


DamierDyn::~DamierDyn(){
    if (T != NULL) {
        Free();
        T = NULL;
    }
}

void DamierDyn::Free(){
    for (int i=0; i<L; i++) {
        delete [] T[i];
    }
    delete [] T;
}

void DamierDyn::Alloc(int l, int c){
    L = l;
    C = c;
    T = new int*[L];
    for(int i=0; i<L; i++)
        T[i] = new int[C];
}

void DamierDyn::Print(){
    cout << endl;
    for(int i=0; i<L; i++) {
        cout << endl;
        for(int j=0; j<C; j++)
            cout << T[i][j] << ", ";
    }
}

void DamierDyn::Init(int value){
    for(int i=0; i<L; i++)
        for(int j=0; j<C; j++)
            T[i][j]=value;
}

void DamierDyn::Set(int l, int c, int value) {
    if ((l>=0) && (l<L) && (c>=0) & (c<C))
        T[l][c]=value;
}


void DamierDyn::ReDim(int l, int c, int vd) {
    Free();
    Alloc(l, c);
    Init(vd);
}

DamierDyn& DamierDyn::operator= (const DamierDyn &D){
    if ( this != &D) { // protection autoréférence
        Free();
        Alloc(D.L, D.C);
        for(int i=0; i<L; i++)
            for(int j=0; j<C; j++)
                T[i][j] = D.T[i][j];
    }
    return *this;
}
