import numpy as np
from math import exp
from pathlib import Path
import random as rnd

PATH = Path("Algos_Collabos") / "PM" / "BE2"
type Data = tuple[list[int], int]

def sigmoid(x: float) -> float:
    return 1 / (1 + exp(-x))

def sigmoid_prime(x: float) -> float:
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

class NN:
    def __init__(self):
        self.layers: list[int] = [48, 16, 4]
        self.weights: list[np.ndarray] = []
        self.biases: list[np.ndarray] = []
    
    def feed_forward(self, activation: np.ndarray):
        pass

    def train(self, datas: list[Data]):
        pass

if __name__ == "__main__":
    dico = read_data_file(PATH / "test.data")
    for k, v in dico:
        show(k)
        break