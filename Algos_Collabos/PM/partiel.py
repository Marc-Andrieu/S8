import random
import numpy as np
import matplotlib.pyplot as plt
import copy

type RN = tuple[np.ndarray, np.ndarray]

def sigmoid(x: np.ndarray) -> np.ndarray:
    return 1 / (1 + np.exp(-x))


"""A modifier dans la question 4"""
C1 = 3
C2 = 1

X = [
    [1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1],
    [1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0],
    [1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1],
    [0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1],
    [0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1],
    [0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0],
    [1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1],
    [1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1],
    [1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1]
]

Y = [
    [1, 0, 0, 0],
    [1, 0, 0, 0],
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 1, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 1, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1],
    [0, 0, 0, 1]
]

X: np.ndarray = np.array(X)
Y: np.ndarray = np.array(Y)

entree = X
Y = Y

intervalle: int = 10

N = 12
"""Question 6"""
M = 6 # ou 10 dans la question 6 
dim_sortie = 4
n_pop = 25
n_crossover = 10
epsilon_mutation = 0.1 # pas indiqué dans l'énoncé : pris arbitrairement
"""Question 5"""
n_petite_mutation = 10 # ou 15 dans la question 5
n_grande_mutation = 5 # ou 0 dans la question 5
n_gen = 50000
seuil = 0.01

def get_next_gen(
    gen: list[RN],
    best: RN
) -> list[RN]:
    next_gen = [best]
    best0, best1 = best

    # Crossover
    for i in range(1, n_crossover + 1) :
        synapse0, synapse1 = gen[i]
        next_gen.append((
            (best0 + synapse0)/2,
            (best1 + synapse1)/2
        ))

    # Petite mutation
    for i in range(n_petite_mutation):
        ind_synapse = random.randrange(2) # choix au hasard entre les deux synapse
        """
        Question 3 :
        proba = random.random()
        proba_synapse0 = M*N / (M*N + 4*M)
        if proba < proba_synapse0:
            ind_synapse = 0
        else:
            ind_synapse = 1
        """
        ind_i = random.randrange(len(best[ind_synapse]))
        ind_j = random.randrange(len(best[ind_synapse][ind_i]))

        temp = copy.deepcopy(best)
        temp[ind_synapse][ind_i][ind_j] += epsilon_mutation * random.uniform(-1, 1)

        next_gen.append(temp)

    # Grande mutation
    for i in range(n_grande_mutation):
        next_gen.append((
            (2 * np.random.random((N,M)) - 1) * intervalle,
            (2 * np.random.random((M,dim_sortie)) - 1) * intervalle
        ))

    return next_gen

def trier_gen(
    gen: list[RN],
    err: list[float]
) -> list[RN]:
    # Associer chaque individu à son erreur et trier par erreur croissante
    items_individus_erreurs = list(zip(err, gen))
    individus_erreurs_trie = sorted(items_individus_erreurs, key=lambda x: x[0])
    # On ne garde que la génération triée
    _, gen_trie = zip(*individus_erreurs_trie)
    return list(gen_trie)

def get_err(gen: list[RN]) -> list[float]:
    err: list[float] = []
    for synapse0, synapse1 in gen:
        cache_actuel = sigmoid(C1 * np.dot(entree, synapse0))
        sortie_actuel = sigmoid(C2 * np.dot(cache_actuel, synapse1))
        err.append(np.linalg.norm(Y - sortie_actuel))
    return err

# Initialisation de la génération
gen: list[RN] = [
    (
        (2 * np.random.random((N, M)) - 1) * intervalle,
        (2 * np.random.random((M, dim_sortie)) - 1) * intervalle
    ) for _ in range(n_pop)
]

best_err: list[float] = []
err = get_err(gen)
best_err.append(min(err))

k = 1
while k < n_gen and best_err[-1] > seuil:
    gen = trier_gen(gen, err)
    best = gen[0]
    gen = get_next_gen(gen, best)
    err = get_err(gen)
    best_err.append(min(err))
    k += 1
    if k % (n_gen//100) == 0:
        print(f"Plus basse erreur en sortie (génération {k}) : {best_err[-1]}")

plt.plot(np.log10(np.array(best_err)))
plt.xlabel("N° de l'itération")
plt.ylabel("Erreur la plus faible parmi les individus ($log_{10}$)")
plt.show()

#

gen = trier_gen(gen, err)
best = gen[0]
print("Le best :", best, "\nFin print best")

synapse0, synapse1 = best


"""Question 7"""
entree = [[1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1]]
cachee = sigmoid(C1 * np.dot(entree, synapse0))
sortie = sigmoid(C2 * np.dot(cachee, synapse1))

print(sortie)
print(sortie / np.sum(sortie[0]))

"""

Crédits pour le code : travail avec Adrien Leblond

Questions :

2.) Sur la courbe en annexe en 1750 itérations environs, on descent d'un facteur 1/100,
donc la vitesse de convergence est de l'ordre d'un facteur $10^{ -2 / 1750 }$ à chaque itération en moyenne

---------------------------------------------------------------------------------------------------

3.) L'objectif de cette question est de donner à chaque poids, tous synapse confondus, la même probabilité d'être muté
(auparavant, les poids du synapse1 étaient plus souvent modifiés car moins nombreux).

Pour autant, la convergence est (sur quelques essais) significativement plus lente,
et l'erreur stagne pendant des dizaines de milliers d'itérations, avant de miraculeusement faire un bond.
Auparavant, l'erreur diminuait de façon bien plus progressive et régulière (par petites améliorations successives),
cf. graphique question 2.

---------------------------------------------------------------------------------------------------

4.) Mettre des C1 et C2 plus grands devient contre-productifs :
avec C1 = C2 = 5, il est même possible de bloquer complètement l'évolution.

Mettre C1 = C2 = 1 ralentit légèrement (on est plus sur 5000 itérations que 2000 en moyenne),
mais en contrepartie, l'erreur semble toujours converger vers 0, et sans chutes soudaines.

Enfin, mettre C1 > C2 semble *a priori* plus efficace que C2 < C1...

Mais C1 = C2 = 2 semble être le meilleur choix dans tous les cas.

Dans de nombreuses autres combinaisons (avec C1 et C2 des entiers entre 1 et 5),
on observe une curieuse convergence vers cette valeur : 1.4142135623730983.

---------------------------------------------------------------------------------------------------

5.) Il est *possible* de retirer les grandes mutations, déjà peu nombreuses, mais je le déconseille :
on a trop souvent une stagnation autour d'un minimum local (même si on observe que ça converge parfois).
En effet les petites mutations regardent au voisinage du meilleur actuel, et ne parviennent pas à sortir
de "l'attraction" de ce minimum local.

Quelques grandes mutations, même peu nombreuses, paraîssent nécessaires pour se sortir de tels blocages
dans des minima locaux.

---------------------------------------------------------------------------------------------------

6.) En pratique, oui, sur la dizaine d'essais effectués à la main pendant ce partiel,
augmenter la taille de la couche cachée ralentit la convergence, voire la rend impossible
(j'ai d'ailleurs découvert une autre valeur d'un minimum local dans cette situation : 1.7320508075688816).

D'une part, augmenter cette taille implique qu'il y a plus de poids synaptiques,
donc en conservant le même nombre de petites mutations, il faut plus d'itérations pour toucher
une même proportion de l'ensemble des poids.

D'autre part, augmenter cette taille donne plus de paramètres au réseau, donc plus de possibilités de
directions possibles à suivre pour descendre vers un minimum plus faible, ce qui devrait rendre moins probable
le fait de rester bloqué sur un mimimum local étant donné que l'espace des possibilités est plus grand.

---------------------------------------------------------------------------------------------------

7.) Le réseau (losque ça converge) reconnaît clairement [1, 0, 0, 0] (en normalisant le vecteur de sortie

---------------------------------------------------------------------------------------------------

8.) J'ai testé toutes les combinaisons de C1 et C2 entiers avec chacun valant 1, 2 ou 3 :
dans les 9 configurations, *lorsque le réseau converge*, il reconnait clairement un 1 0 0 0

---------------------------------------------------------------------------------------------------

9.)

"""
