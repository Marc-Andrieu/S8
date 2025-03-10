<script
    src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
    type="text/javascript">
</script>

# CM 1 : P. M.

Défs initiales :
* **Individu** : son trait génétique est rpz pas des chromosomes
* **Chromosomes** : définissent un génotype
* **Génotype** : e.g. suite de lettres, de bits, un réel, etc
* Ca exprime des caractéristiques : c le **phénotype**
* Ces caracs donnent aux individus une **fitness** (*adaptation* [au milieu]) plus ou moins grde.
* La **sélec nat** favorise les individus les + adaptés, en ceci qu’ils se reproduisent +.
* Ils se reproduisent 
    * par **crossover** (*recombination* [des gènes], $(x; y) \mapsto moy(x; y)$), avec ou sans **mutation**,
    * ou par **clonage** et mutation obligatoire ($x \mapsto x +$ `rnd`).

Le crossover sans mutation, c de la dichotomie :
* Avantage : rapide.
* Inconvénient : on trouve que des extrema locaux.

La mutation pure (*cf.* ci-dessous).
* Avantage : max global presque surement.
* Inconvénient : lent.

Algo mutation pure : trouver le max entre 0 et 1 d’une fonc : on prend le meilleur des 2 et un rnd, et on recommence (ouais y a pas de notion de mémoire). Et bah justement $P(extrema \in [x \pm \varepsilon])$ suit une géométrique.

Déf : algos génétiques
1. Créer popul rnd de taille $N$
1. Evaluer la fitness de chaque membre
1. Sélec nat : reproduction des + adaptés : générer les enfants par crossover ou clonage
1. Mutation de qlq indivs
1. If fitness pas assez good : `GOTO 2`

# CM de la rentrée (10 mars) : histoire des réseaux de neurones

* Ppe : un neurone $e_i$ a un état qui dépend de $\mathcal{C}_i^{excitateur}$ l'ens des neurones qui ajoutent de l'activation, et $\mathcal{C}_i^{inhibiteur}$ les neurones qui retirent de l'activation.
In fine c pareil au sgn près, juste on somme leurs contributions à $e_i$, et selon que ça dépasse strictement un sueil $\theta_i$, on dit que le neuron $e_i$ est activé ou non.
    * On peut faire de la logique :
        * une porte OU c un seuil de 0 (jusqu'à 0,9) avec des +
        * une porte ET c un seuil de 1 (jusqu'à 1,9) avec des +
        * une porte NON c un - sur le truc à nier et un seuil de -1 (jusqu'à -0,1)
* In fine c encore juste de l'algèbre liné : c un produit scalaire entre un vecteurs de poids et le vecteur des activations des neurones du layer précédent

Voca :
* Récurrent : $\exists$ une boucle : matrice de poids $p_i$ triangulaire (pr un graphe avec tous les neurones)
    * On ft évoluer les poids comme ça :
$$
p_{ji}' = p_{ji} + Pas(e_i^{theo} - e_i) \cdot e_i
$$

Où $Pas$ c une fn pr le pas d'apprentissage, c de la descente de 
* En 1982, Hopfield mq, étant donné une mat de poids qui est sym (donc c un réseau récurrent), et une fn de seuil qui output du -1 ou du -1 par rapport à un seuil, bah on peut définir une énergie, trucs de Lyapunov, et bref le réseau converge !

De nos jours :
$$
e_i(t_n) = \varphi \left( \sum_i p_{ji} e_j(t_{n - 1}) \right)
$$

Où $\varphi$ c la fn réponse : heaviside, affine entre $\theta_1$ et $theta_2$, sigmoïde, etc.
BTW, la sigmoïde :
$$
\sigma(z) = \frac{1}{1 + \mathrm{e}^{-Tz}}
$$

Pr choisir les poids :
* Méthode de gradient
* ...
* Algos génétiques !

