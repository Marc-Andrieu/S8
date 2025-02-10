#ifndef DAMIERDYN_H
#define DAMIERDYN_H

class DamierDyn { // OK
    public:
        DamierDyn(int l, int k, int n = 0);
        ~DamierDyn(); // destructeur
        DamierDyn(const DamierDyn &d); // constructeur par copie
        DamierDyn & operator=(const DamierDyn &damier); //opérateur d'=té

        void Init (int n);
        void Set (int i, int j, int n);
        void Print();
        void Redim(int l, int k);
    private:
        int **damier;
        int l; // #lignes
        int k; // #colonnes
};

#endif // DAMIERDYN_H







