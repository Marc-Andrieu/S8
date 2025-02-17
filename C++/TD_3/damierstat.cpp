#include "damierstat.h"

DamierStat::DamierStat()
{

}

void DamierStat::Init(int value){
    for(int i=0; i<4; i++)
        for(int j=0; j<5; j++)
            D[i][j]=value;
}

void DamierStat::Set(int x, int y, int value) {
    D[x][y]=value;
}

void DamierStat::Print(){
    for(int i=0; i<4; i++) {
        cout << endl;
        for(int j=0; j<5; j++){
            cout << D[i][j] << ", ";
        }
    }
}
