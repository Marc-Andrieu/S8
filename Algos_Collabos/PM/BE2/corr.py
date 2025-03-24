# La sortie Y=1 si x1=1 (ou bien y=x1 and x3)
# Pas de hidden couche, donc les résultats ne seront pas top.
import numpy as np

# La fonction de combinaison (ici une sigmoide)
def sigmoide(x) : return 1/(1+np.exp(-x))

# Et sa dérivée
def derivee_de_sigmoide(x) : return x * (1 - x)

# Les entrées
X = np.array([ [0,0,1],
[0,1,1],
[1,0,1],
[1,1,1] ])

# Les sorties (ici un vecteur)
Y = np.array([[0,0,1,1]]).T # Transposé

# On utilise seed pour rendre les calculs déterministes.
np.random.seed(1)

# Initialisation aléatoire des poids (avec une moyenne = 0)
synapse0 = 2 * np.random.random((3,1)) - 1
couche_entree = X

for iter in range(10000): # On peut augmenter !
    # propagation vers l’avant (forward)
    couche_sortie = sigmoide(np.dot(couche_entree,synapse0)) # dot multiplication
    # Quelle est l’erreur (l’écart entre les sorties calculées et attendues)
    erreur_couche_sortie = Y - couche_sortie
    # Multiplier l’erreur (l’écart) par la pente du ïsigmode pour les valeurs dans couche_sortie
    delta_couche_sortie = erreur_couche_sortie * derivee_de_sigmoide(couche_sortie)
    # Mise àjour des poids : rétropropagation
    synapse0 += np.dot(couche_entree.T,delta_couche_sortie)

print ("Les sorties après l'apprentissage :")
print (couche_sortie)


##############################################

import numpy as np

def sigmoide_et_sa_derivee(x,deriv=False):
    if deriv:
        return x * (1 - x)
    return 1 / (1 + np.exp(-x))
                   
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

# On utilise seed pour rendre les calculs déterministes.
np.random.seed(1)

# Initialisation aléatoire des poids (avec une moyenne = 0 et écart−type=1)
# Ici, on met la moyenne àzéro, le std ne change pas.
# L’écriture X = b*np.random.random((3,4)) - a
# permet un tirage dans [a,b)], ici entre b=1 et a=−1 (donc moyenne=0)
synapse0 = 2 * np.random.random((3,4)) - 1
synapse1 = 2 * np.random.random((4,1)) - 1

couche_entree = X
nb_iterations = 100000

for j in range(nb_iterations):
    # propagation vers l’avant (forward)
    # couche_entree = X
    couche_cachee = sigmoide_et_sa_derivee(np.dot(couche_entree,synapse0))
    couche_sortie = sigmoide_et_sa_derivee(np.dot(couche_cachee,synapse1))

    # erreur ?
    erreur_couche_sortie = y - couche_sortie

    if j % (nb_iterations // 10) == 0: # des traces de l’erreur
        print("Moyenne Erreur couche sortie :" + str(np.mean(np.abs(erreur_couche_sortie))))
    
    # pondération par l’erreur (si pente douce, ne pas trop changer sinon, changer pondérations,
    delta_couche_sortie = erreur_couche_sortie * sigmoide_et_sa_derivee(couche_sortie,deriv=True)
    
    # Quelle est la contribution de couche_cachee àl’erreur de couche_sortie
    # (suivant les pondérations)?
    error_couche_cachee = delta_couche_sortie.dot(synapse1.T)
    
    # Quelle est la "direction" de couche_cachee (dérivée) ?
    # Si OK, ne pas trop changer la valeur.
    delta_couche_cachee = error_couche_cachee * sigmoide_et_sa_derivee(couche_cachee,deriv=True)
    synapse1 += couche_cachee.T.dot(delta_couche_sortie)
    synapse0 += couche_entree.T.dot(delta_couche_cachee)

print("Résultat de l'apprentissage :")
print(couche_sortie)

##############################################

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