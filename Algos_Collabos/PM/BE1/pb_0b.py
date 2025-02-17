import matplotlib.pyplot as plt 
import numpy as np
import math

n = 15
B = np.random.rand(n, n)
A = B.T @ B

def f(x: np.ndarray):
    num: float = (x.T @ A @ x).item()
    den: float = (x.T @ x).item()
    return num / den

def collabo(
    prec: float,
    N: int,
    p_M: int,
    p_m: int,
    e_m: float,
):
    p_s: int = N - p_m - p_M - 1
    popul: list[np.ndarray] = sorted([np.random.rand(n, 1) for _ in range(N)], key=f)
    best = popul[-1]
    hall_of_fame: list[np.ndarray] = [best]

    le_premier: bool = True
    while le_premier or abs(f(best) - f(hall_of_fame[-2])) > prec:
        le_premier = False
        popul = sorted(
            [np.random.rand(n, 1) for _ in range(p_M)] +
            [best + np.random.rand(n, 1) * 2 * e_m - np.ones((n, 1)) * e_m for _ in range(p_m)] +
            [(popul[i] + best) / 2 for i in range(-2, -p_s - 2, -1)] +
            [best],
            key=f
        )
        best = popul[-1]
        hall_of_fame.append(best)

    return best, f(best), hall_of_fame

if __name__ == "__main__":
    best, f_best, hall_of_fame = collabo(
        prec=1e-15,
        N=30,
        p_M=5,
        p_m=10,
        e_m=0.01,
    )
    print("Best : ", best)
    print("f(best) : ", f_best)
    print("Hall of Fame : ", hall_of_fame)
    plt.plot([f(indiv) for indiv in hall_of_fame])
    plt.grid()
    plt.show()

    #X = [n / 100 - 1 for n in range(200)]
    #Y = [f(x) for x in X]
    #plt.plot(X, Y)
    #plt.show()