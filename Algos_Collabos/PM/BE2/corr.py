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

y = np.array([[0],
    [1],
    [1],
    [0]]
)

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