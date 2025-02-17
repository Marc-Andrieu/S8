
import random as rnd
import matplotlib.pyplot as plt

def gain_1(p_11, p_12):
    p_21 = 1 - p_11
    p_22 = 1 - p_12
    return p_11 * p_12 + p_21 * p_22 - p_11 * p_22 - p_12 * p_21

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
    popul_1: list[float] = [rnd.uniform(0, 1) for _ in range(N_1)]
    popul_2: list[float] = [rnd.uniform(0, 1) for _ in range(N_2)]
    popul_1: list[float] = sorted(popul_1, key=lambda x: gain_1(x, popul_2[-1]))
    popul_2: list[float] = sorted(popul_2, key=lambda x: -gain_1(popul_1[-1], x))
    best_1 = popul_1[-1]
    best_2 = popul_2[-1]
    hall_of_fame_1: list[float] = [best_1]
    hall_of_fame_2: list[float] = [best_2]

    le_premier: bool = True
    while le_premier or (abs(gain_1(best_1, best_2) - gain_1(hall_of_fame_1[-2], hall_of_fame_2[-2])) > prec_1 and abs(-gain_1(best_2, best_1) + gain_1(hall_of_fame_2[-2], hall_of_fame_1[-2])) > prec_2):
        le_premier = False
        popul_1 = sorted(
            [rnd.uniform(0, 1) for _ in range(p_M_1)] +
            [best_1 + rnd.uniform(-e_m_1, e_m_1) for _ in range(p_m_1)] +
            [(popul_1[i] + best_1) / 2 for i in range(-2, -p_s_1 - 2, -1)] +
            [best_1],
            key=lambda x: gain_1(x, popul_2[-1])
        )
        best_1 = popul_1[-1]
        hall_of_fame_1.append(best_1)
        popul_2 = sorted(
            [rnd.uniform(0, 1) for _ in range(p_M_2)] +
            [best_2 + rnd.uniform(-e_m_2, e_m_2) for _ in range(p_m_2)] +
            [(popul_2[i] + best_2) / 2 for i in range(-2, -p_s_2 - 2, -1)] +
            [best_2],
            key=lambda x: -gain_1(popul_1[-1], x)
        )
        best_2 = popul_2[-1]
        hall_of_fame_2.append(best_2)
    return best_1, gain_1(best_1, best_2), hall_of_fame_1, best_2, -gain_1(best_1, best_2), hall_of_fame_2

if __name__ == "__main__":
    best_1, f_best_1, hall_of_fame_1, best_2, f_best_2, hall_of_fame_2 = collabo(
        prec_1=1e-2,
        prec_2=1e-2,
        N_1=30,
        N_2=30,
        p_M_1=5,
        p_M_2=5,
        p_m_1=10,
        p_m_2=10,
        e_m_1=.01,
        e_m_2=.01,
    )
    #plt.plot([gain_1(indiv, best_2) for indiv in hall_of_fame_1])
    #plt.plot([-gain_1(best_1, indiv) for indiv in hall_of_fame_2])
    plt.plot(hall_of_fame_1)
    plt.plot(hall_of_fame_2)
    plt.show()