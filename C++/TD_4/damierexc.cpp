#include "damierexc.h"

DamierExc::DamierExc(int l, int c, int b)
{
    Alloc(l, c);
    B = b;
    Init(0);
}

DamierExc::DamierExc(const DamierExc &D)
{
    Alloc(D.L, D.C);
    B = D.B;
    for(int i=0; i<L; i++)
        for(int j=0; j<C; j++)
            T[i][j] = D.T[i][j];
}


DamierExc::~DamierExc(){
    if (T != NULL) {
        Free();
        T = NULL;
    }
}

void DamierExc::Free(){
    for (int i=0; i<L; i++) {
        delete [] T[i];
    }
    delete [] T;
}

void DamierExc::Alloc(int l, int c){
    L = l;
    C = c;
    T = new int*[L];
    for(int i=0; i<L; i++)
        T[i] = new int[C];
}

void DamierExc::Print(){
    cout << endl;
    for(int i=0; i<L; i++) {
        cout << endl;
        for(int j=0; j<C; j++)
            cout << T[i][j] << ", ";
    }
}

void DamierExc::Init(int value){
    if (value > B) {
        string fichier(__FILE_NAME__);
        string fn(__PRETTY_FUNCTION__);
        ExceptionDamier e(B, value, fichier, fn);
        throw e;
    }
    for(int i=0; i<L; i++)
        for(int j=0; j<C; j++)
            T[i][j]=value;
}

void DamierExc::Set(int l, int c, int value) {

    if ((l>0) && (l<L) && (c>=0) && (c<C))
        T[l][c]=value;
    else {
        string fichier(__FILE_NAME__);
        string fn(__PRETTY_FUNCTION__);
        ExceptionDamier e(B, value, fichier, fn);
        throw e;
    }
}


void DamierExc::ReDim(int l, int c, int vd) {
    Free();
    Alloc(l, c);
    Init(vd);
}

DamierExc& DamierExc::operator= (const DamierExc &D){
    if ( this != &D) { // protection autoréférence
        Free();
        Alloc(D.L, D.C);
        for(int i=0; i<L; i++)
            for(int j=0; j<C; j++)
                T[i][j] = D.T[i][j];
    }
    return *this;
}
