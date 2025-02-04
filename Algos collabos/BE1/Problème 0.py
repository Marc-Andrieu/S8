from math import sin, log
import matplotlib.pyplot as plt 
from random import uniform


def f(x: float) -> float:
    assert abs(x) <= 1, f"{x} est hors de [-1; 1] !"
    return -(
        x * (2 + sin (10 * x))
    ) ** 2


def collabo(
    prec: float,
    N_pop: int,
    p_M: int,
    p_m: int,
    e_m: float,
) -> tuple[float, float, list[float]]:
    p_s: int = N_pop - p_m - p_M - 1
    popul: list[float] = sorted([uniform(-1, 1) for _ in range(N_pop)], key=f)
    best = popul[-1]
    hall_of_fame: list[float] = [best]

    while f(best) < -prec:
        popul = sorted(
            [uniform(-1, 1) for _ in range(p_M)] +
            [best + uniform(-e_m, e_m) for _ in range(p_m)] +
            [(popul[i] + best) / 2 for i in range(-2, -p_s - 2, -1)] +
            [best],
            key=f
        )
        best = popul[-1]
        hall_of_fame.append(best)

    return best, f(best), hall_of_fame


if __name__ == "__main__":
    best, f_best, hall_of_fame = collabo(
        prec=1e-10,
        N_pop=12,
        p_M=4,
        p_m=4,
        e_m=0.01,
    )
    plt.plot([log(-f(indiv)) for indiv in hall_of_fame])
    plt.show()

    X = [n / 100 - 1 for n in range(200)]
    Y = [f(x) for x in X]
    #plt.plot(X, Y)
    plt.grid()
    #plt.show()