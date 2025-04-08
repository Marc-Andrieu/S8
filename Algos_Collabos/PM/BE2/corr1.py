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
