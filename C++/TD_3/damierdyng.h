#ifndef DAMIERDYNG_H
#define DAMIERDYNG_H

#include <iostream>
using namespace std;

template <class G> // Template qui s'appuie sur une classe de type T
class DamierDynG
{
public:
    DamierDynG(int l, int c, int vd);
    DamierDynG(const DamierDynG &D);
    ~DamierDynG();

    DamierDynG<G>& operator=(const DamierDynG<G> &D); // opérateur d'affectation
    template<class B> friend DamierDynG<G> operator+(const DamierDynG<G> &A, const DamierDynG<G> &B);
    DamierDynG<G>& operator+=(const DamierDynG<G> &D);
    template<class B>friend ostream& operator<< (ostream& sortie, DamierDynG<G> &D);


    void Print();
    void Init(G value);
    void Set(int x, int y, G value);
    void ReDim(int l, int c, G vd = -7);

private:
    int L;
    int C;
    G** T;

    // Méthode privée (factorisation  de code)
    void Alloc(int l, int c);
    void Free();
};

template<class G>
DamierDynG<G>::DamierDynG(int l, int c, G vd)
{
    Alloc(l, c);
    Init(vd);
}

template<class G>
DamierDynG<G>::DamierDynG(const DamierDynG &D)
{
    Alloc(D.L, D.C);
    for(int i=0; i<L; i++)
        for(int j=0; j<C; j++)
            T[i][j] = D.T[i][j];
}

template<class G>
DamierDynG<G>::~DamierDynG(){
    if (T != NULL) {
        Free();
        T = NULL;
    }
}

template<class G>
void DamierDynG<G>::Free(){
    for (int i=0; i<L; i++) {
        delete [] T[i];
    }
    delete [] T;
}

template<class G>
void DamierDynG<G>::Alloc(int l, int c){
    L = l;
    C = c;
    T = new int*[L];
    for(int i=0; i<L; i++)
        T[i] = new int[C];
}

template<class G>
void DamierDynG<G>::Print(){
    cout << endl;
    for(int i=0; i<L; i++) {
        cout << endl;
        for(int j=0; j<C; j++)
            cout << T[i][j] << ", ";
    }
}

template<class G>
void DamierDynG<G>::Init(G value){
    for(int i=0; i<L; i++)
        for(int j=0; j<C; j++)
            T[i][j]=value;
}

template<class G>
void DamierDynG<G>::Set(int l, int c, G value) {
    if ((l>=0) && (l<L) && (c>=0) & (c<C))
        T[l][c]=value;
}

template<class G>
void DamierDynG<G>::ReDim(int l, int c, G vd) {
    Free();
    Alloc(l, c);
    Init(vd);
}

template<class G>
DamierDynG<G>& DamierDynG<G>::operator=(const DamierDynG &D){
    if ( this != &D) { // protection autoréférence
        Free();
        Alloc(D.L, D.C);
        for(int i=0; i<L; i++)
            for(int j=0; j<C; j++)
                T[i][j] = D.T[i][j];
    }
    return *this;
}

template<class G>
DamierDynG<G> operator+(const DamierDynG<G> &A, const DamierDynG<G> &B) {
    if (A.C == B.C && A.L == B.L) {
        DamierDynG C(A.L, A.C, 0);

        for (int i = 0; i < A.L; i++) {
            for (int j = 0; j < A.C; j++) {
                C.Set(i, j, A.T[i][j] + B.T[i][j]);
            }
        }
        return C;
    } else {
        cerr << "Pas les mêmes dimensions" << endl;
        exit(1);
    }
}

template<class G>
DamierDynG<G>& DamierDynG<G>::operator+=(const DamierDynG<G> &D) {
    if (C == D.C && L == D.L) {

        for (int i = 0; i < L; i++) {
            for (int j = 0; j < C; j++) {
                Set(i, j, T[i][j] + D.T[i][j]);
            }
        }
        return *this;
    } else {
        cerr << "Pas les mêmes dimensions" << endl;
        exit(1);
    }
}

template<class G>
ostream& operator<< (ostream& sortie, DamierDynG<G> &D) {
    for (int i = 0; i < D.L; i++) {
        for (int j = 0; j < D.C; j++) {
            sortie << D.T[i][j] << " ";
        }
        sortie << endl;
    }
    sortie << endl;
    return sortie;
}

#endif // DAMIERDYNG_H
