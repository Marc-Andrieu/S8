import matplotlib.pyplot as plt
import random as rnd
import numpy as np

def sortie(X: float, Y: float, B: float = 2):
    parie: bool = rnd.uniform(0, 1) < X
    appelle: bool = rnd.uniform(0, 1) < Y
    if parie:
        if appelle:
            if X > Y:
                return 1 + B
            elif X < Y:
                return -1 - B
            else:
                return 0
        else:
            return 1
    else:
        return -1

def gain_1(X: float, Y: list[float]):
    return sum(sortie(X, y) for y in Y)
def gain_2(X:list[float], Y: float):
    return -sum(sortie(x, Y) for x in X)

# joueur 1 (p) : parie, ou pas
# joueur 2 (q) : appelle, ou se couche

def saturation(x: float):
    if abs(x) < 1:
        return x
    if x < -1:
        return -1
    if x > 1:
        return 1

def collabo(
    prec_1: float,
    prec_2: float,
    N_1: int,
    N_2: int,
    p_M_1: int,
    p_M_2: int,
    p_m_1: int,
    p_m_2: int,
    e_m_1: float,
    e_m_2: float,
):
    p_s_1: int = N_1 - p_m_1 - p_M_1 - 1
    p_s_2: int = N_2 - p_m_2 - p_M_2 - 1
    popul_1: list[float] = [np.random.rand(10, 1) for _ in range(N_1)]
    popul_2: list[float] = [np.random.rand(10, 1) for _ in range(N_2)]
    popul_1: list[float] = sorted(popul_1, key=lambda x: gain_1(x, popul_2))
    popul_2: list[float] = sorted(popul_2, key=lambda y: gain_2(popul_1, y))
    best_1 = popul_1[-1]
    best_2 = popul_2[-1]
    hall_of_fame_1: list[float] = [best_1]
    hall_of_fame_2: list[float] = [best_2]

    le_premier: bool = True
    compteur = 0
    while compteur < 100 or le_premier or (abs(gain_1(best_1, popul_2) - gain_1(hall_of_fame_1[-2], popul_2)) > prec_1 and abs(gain_2(popul_1, best_2) - gain_2(popul_1, hall_of_fame_2[-2])) > prec_2):
        compteur +=1
        le_premier = False
        popul_1 = sorted(
            [rnd.uniform(0, 1) for _ in range(p_M_1)] +
            [saturation(best_1 + rnd.uniform(-e_m_1, e_m_1)) for _ in range(p_m_1)] +
              [(popul_1[i] + best_1) / 2 for i in range(-2, -p_s_1 - 2, -1)] +
            [best_1],
            key=lambda x: gain_1(x, popul_2)
        )
        best_1 = popul_1[-1]
        hall_of_fame_1.append(best_1)
        popul_2 = sorted(
            [rnd.uniform(0, 1) for _ in range(p_M_2)] +
            [saturation(best_2 + rnd.uniform(-e_m_2, e_m_2)) for _ in range(p_m_2)] +
            [(popul_2[i] + best_2) / 2 for i in range(-2, -p_s_2 - 2, -1)] +
            [best_2],
            key=lambda y: gain_2(popul_1, y)
        )
        best_2 = popul_2[-1]
        hall_of_fame_2.append(best_2)
    return best_1, gain_1(best_1, popul_2), hall_of_fame_1, best_2, gain_2(popul_1, best_2), hall_of_fame_2

if __name__ == "__main__":
    best_1, f_best_1, hall_of_fame_1, best_2, f_best_2, hall_of_fame_2 = collabo(
        prec_1=1e-25,
        prec_2=1e-25,
        N_1=10,
        N_2=10,
        p_M_1=0,
        p_M_2=0,
        p_m_1=5,
        p_m_2=5,
        e_m_1=.01,
        e_m_2=.01,
    )
    #plt.plot([gain_1(indiv, best_2) for indiv in hall_of_fame_1])
    #plt.plot([-gain_1(best_1, indiv) for indiv in hall_of_fame_2])
    plt.plot(hall_of_fame_1)
    plt.plot(hall_of_fame_2)
    plt.show()