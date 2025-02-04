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

Le  crossover sans mutation, c de la dichotomie :
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
