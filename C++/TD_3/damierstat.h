#ifndef DAMIERSTAT_H
#define DAMIERSTAT_H

#include <iostream>
using namespace std;

class DamierStat
{
public:
    DamierStat();
    void Init(int value);
    void Set(int x, int y, int value);
    void Print();
private:
    int D[4][5];
};

#endif // DAMIERSTAT_H
