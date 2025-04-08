# Le RN à3 couches (une couche cachée) et on ajoute le param alpha
# On teste avec plusieurs alphas pour paufiner
import numpy as np
alphas = [0.001, 0.01, 0.1, 1, 10, 100, 1000]

# la fonction sigmoid (non linéaire)
def sigmoid(x):
    return 1/(1+np.exp(-x))

# On sépare pour simplifier le code :
# La fonction dérivée de la ïsigmode
def derivee_de_sigmoide(output):
    return output * (1 - output)

X = np.array([
    [0,0,1],
    [0,1,1],
    [1,0,1],
    [1,1,1]
])

y = np.array([
    [0],
    [1],
    [1],
    [0]
])

couche_entree = X
nb_iterations = 10000 #60000

# juste pour tracer de temps en temps : 10 trace par valeur de alpha testée
trace_tous_les_combien = nb_iterations // 10

for alpha in alphas:
    print("\nApprentissage Avec Alpha:" + str(alpha))
    np.random.seed(1)

    # Init des pondérations (avec mu=0)
    synapse_0 = 2 * np.random.random((3,4)) - 1
    synapse_1 = 2 * np.random.random((4,1)) - 1

    for j in range(nb_iterations) :

        # Propager à travers les couches
        couche_cachee = sigmoid(np.dot(couche_entree,synapse_0))
        couche_sortie = sigmoid(np.dot(couche_cachee,synapse_1))
        
        erreur_couche_sortie = couche_sortie - y

        if j% trace_tous_les_combien == 0: # Dix traces de l’erreur
            print("Moyenne abs(Erreur) après "+str(j)+" iterations : ", end='')
            print(str(np.mean(np.abs(erreur_couche_sortie))))

        # La dérivée pour connaitre la disrection de la valeur calculée (sortie)
        # Pondération par la dérivé de l’erreur
        delta_couche_sortie = erreur_couche_sortie * derivee_de_sigmoide(couche_sortie)

        # Quelle est la contribution de couche_cachee àl’erreur de couche_sortie
        # (suivant les pondérations)?
        erreur_couche_cachee = delta_couche_sortie.dot(synapse_1.T)

        # Quelle est la "direction" de couche_cachee (dérivée) ?
        # Si OK, ne pas trop changer la valeur.
        delta_couche_cachee = erreur_couche_cachee * derivee_de_sigmoide(couche_cachee)
 
        # Retropropagastion dans les pondérations
        synapse_1 -= alpha * (couche_cachee.T.dot(delta_couche_sortie))
        synapse_0 -= alpha * (couche_entree.T.dot(delta_couche_cachee))
        