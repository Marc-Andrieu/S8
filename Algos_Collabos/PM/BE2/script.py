import numpy as np
alphas: list[float] = [0.001, 0.01, 0.1, 1, 10, 100, 1000]

def sigmoid(x: np.ndarray) -> np.ndarray:
    return 1/(1+np.exp(-x))

def sigmoide_prime(x: np.ndarray) -> np.ndarray:
    s = sigmoid(x)
    return s * (1 - s)

X = np.array([
    [0,0,1],
    [0,1,1],
    [1,0,1],
    [1,1,1]
])

Y = np.array([
    [0],
    [1],
    [1],
    [0]
])

couche_entree = X
nb_iterations = 10000
trace_tous_les_combien = nb_iterations // 4

"""
TODO:
* read les data
* softmax
* bias
"""

for alpha in alphas:
    print(f"\nApprentissage avec alpha = {alpha}")
    np.random.seed(1)
    synapse_0 = 2 * np.random.random((3,4)) - 1
    synapse_1 = 2 * np.random.random((4,1)) - 1

    for j in range(nb_iterations) :

        # Forward propag
        couche_cachee = sigmoid(np.dot(couche_entree,synapse_0))
        couche_sortie = sigmoid(np.dot(couche_cachee,synapse_1))

        # Backpropag matrice synapse1 (cachée -> sortie)
        erreur_couche_sortie = Y - couche_sortie
        delta_couche_sortie = erreur_couche_sortie * sigmoide_prime(couche_sortie)
        erreur_couche_cachee = delta_couche_sortie.dot(synapse_1.T)

        # Backpropag matrice synapse0: (entrée -> cachée)
        synapse_1 += alpha * (couche_cachee.T.dot(delta_couche_sortie))
        delta_couche_cachee = erreur_couche_cachee * sigmoide_prime(couche_cachee)
        synapse_0 += alpha * (couche_entree.T.dot(delta_couche_cachee))

        if j% trace_tous_les_combien == 0:
            print("Moyenne abs(Erreur) après "+str(j)+" iterations : ", end='')
            print(np.mean(np.abs(erreur_couche_sortie)))

    print("Les sorties après l'apprentissage :")
    print(couche_sortie)
    print("Les poids après l'apprentissage :")
    print(synapse_0)
    print(synapse_1)