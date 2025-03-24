import numpy as np
from pathlib import Path

PATH = Path("Algos_Collabos") / "PM" / "BE2" / "data"
type Data = tuple[list[int], int]

def sigmoid(x: np.ndarray) -> np.ndarray:
    return 1 / (1 + np.exp(-x))

def sigmoid_prime(x: np.ndarray) -> np.ndarray:
    s = sigmoid(x)
    return s * (1 - s)

def read_data_file(path: Path) -> list[Data]:
    dico: list[Data] = []
    with open(path, "r") as f:
        for line in f:
            line = line.rstrip()
            ls: list[int] = [int(n) for n in line.split(" ")]
            val = ls.pop()
            dico.append((ls, val))
    return dico

def show(ls: list[int]):
    for i in range(8):
        print(ls[6*i : 6*(i+1)])

type Tenseur = tuple[np.ndarray, np.ndarray]
type NN = list[Tenseur]

def vect_rnd(m: int) -> np.ndarray:
    return 2 * np.random.rand(m, 1) - 1

def mat_rnd(m: int, n: int) -> np.ndarray:
    return 2 * np.random.rand(m, n) - 1

def tenseur_rnd(m: int, n: int) -> Tenseur:
    return [mat_rnd(m, n), vect_rnd(m)]

tenseur_entree = tenseur_rnd(22, 48)
tenseur_sortie = tenseur_rnd(10, 22)

def feed_forward(X: np.ndarray, tenseur: Tenseur) -> np.ndarray:
    M, b = tenseur
    return sigmoid(M @ X + b)

def choix(nn: NN, data: Data) -> float:
    X, val = data
    for tenseur in nn:
        X = feed_forward(X, tenseur)
    return val, np.argmax(X)

def err(nn: NN, data: Data) -> float:
    X, val = data
    for tenseur in nn:
        X = feed_forward(X, tenseur)
    vect_val = np.zeros((10, 1))
    vect_val[val] = 1
    return np.linalg.norm(X - vect_val)

def err_totale(nn: NN, tout: list[Data]) -> float:
    s = sum(err(nn, data) for data in tout)
    return s

def crossover(nn1: NN, nn2: NN) -> NN:
    nn: NN = []
    for n in range(len(nn1)):
        M1, b1 = nn1[n]
        M2, b2 = nn2[n]
        nn.append((
            (M1 + M2) / 2,
            (b1 + b2) / 2
        ))
    return nn

def mutation(nn: NN, e_m: float) -> NN:
    nn_sortie: NN = []
    for M, b in nn:
        m, n = M.shape
        nn_sortie.append((
            M + e_m * mat_rnd(m, n),
            b + e_m * vect_rnd(m)
        ))
    return nn_sortie


def collabo(
    prec: float,
    N: int,
    p_M: int,
    p_m: int,
    e_m: float,
    path: Path
):
    p_s: int = N - p_m - p_M - 1
    
    def key_err(nn: NN) -> float:
        return err_totale(nn, read_data_file(path))
    
    popul: list[NN] = sorted([
            [tenseur_rnd(88, 48), tenseur_rnd(10, 88)]
            for _ in range(N)
        ],
        key=key_err,
        reverse=True
    )
    best = popul[-1]
    hall_of_fame: list[np.ndarray] = [best]

    le_premier: bool = True
    while le_premier or key_err(best) > prec:
        print("err best :", key_err(best))
        le_premier = False
        popul = sorted(
            [[tenseur_rnd(88, 48), tenseur_rnd(10, 88)] for _ in range(p_M)] +
            [mutation(best, e_m) for _ in range(p_m)] +
            [crossover(best, popul[i]) for i in range(-2, -p_s - 2, -1)] +
            [best],
            key=key_err,
            reverse=True
        )
        best = popul[-1]
        hall_of_fame.append(best)

    return best, key_err(best), hall_of_fame

if __name__ == "__main__":
    best, f_best, hall_of_fame = collabo(
        prec=1,
        N=60,
        p_M=5,
        p_m=50,
        e_m=10,
        path=PATH / "test.data"
    )
    print("Best : ", best)
    print("f(best) : ", f_best)
    print("Hall of Fame : ", hall_of_fame)
    
    for data in read_data_file(PATH / "test.data"):
        print(choix(best, data))
