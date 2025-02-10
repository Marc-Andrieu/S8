#ifndef DAMIERSTAT_H
#define DAMIERSTAT_H

class DamierStat {
    public:
        DamierStat();
        void Init (int n);
        void Set (int i, int j, int n);
        void Print();
    private:
        int damier[4][5];

};

#endif // DAMIERSTAT_H
