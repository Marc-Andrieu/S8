<script
    src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
    type="text/javascript">
</script>

# CM 2 : A. S.

A. S. gère la partie "*collaboratif*" de cet électif.

* [Stigmergie](https://en.wiktionary.org/wiki/stigmergy#English) : capacité d'auto-organisation.

* TSP (pb du voyageur de commerce clasico) : diapos intéressantes de la 48 à la 61 grand max, surtt la 52 avec la proba de transition entre les villes $i$ et $j$

# BE

Plusieurs sujets possibles :
* SLAM (?)
* PCC (plus court chemin) en "multi-agents" avec le ppe de Stigmergie
* En colonies de foumis
    * TSP
    * BAP (Bus Allocation Problem) et colonies de fourmis
    * Ramassage scolaire
    * Coloration de graphe / PSO (Bonus)
* Algos génétiques en génération d'images
* Routage et trafic
* AntNet

## Rappel des ppes

* Les "fourmis" c des agents individuels qui posent des "phéromones"
* Je sens qu'y a 2 notions importantes : phéromones et évaporation

Ppe "général", ds certains cas seulement (donc c pas si "général" ?) :
```
forEach particle p
    for each coordinate p.c
        p.c += 2*rand()*(pbest.c - p.c) + 2*rand()*(gbest.c - p.c)
# pbest : le meilleur local jusque là
# gbest : le meilleur global jusque là.
```

Bon en gros on pousse ds la dir du meilleur de tous les temps et du meilleur récent.

Les agents ("fourmis") peuvent sueulement :
* "marcher" (avancer) sur un graphe, allant d’une ville vers une autre ;
* "prendre" des aliments quand ils arrivent à la source de nourriture ;
* "laisser" cette nourriture lorsqu’ils reviennent au nid.
* "déposer" de la phéromone sur une route (une arête) lors d’un voyage ;
* "décider"/"choisir"quel sera le prochain chemin à suivre en fonction de l’intensité de phéromone sur les arêtes possibles depuis un noeud.

Bon allons-y : une foumi est en B, elle peut aller en A ou D.
Elle choisit A.
Elle dépose de la phéromone, sur l'arête B-A ou juste sur A ça dépend de l'implémentation, proportionnellement à la distance BA.


Conseil du prof : utiliser des classes, comme d'hab pr bien cloisonner.
4 classes :
* Civilisation : contient les 2 villes *nest* et *food*, des methods *go* et *faire un pas*
* Ville : a une position et des arêtes
* Route : a une qté de phéromone, une longueur, 2 villes, et une method *evaporer*
* Fourmi : y en a plusieurs types ; elles peuvent *avancer*, *prend de la food*, *déposer de la food*, *choisir une arête*, et *déposer de la phéromone*

Algo de ppe :
```
init:
    créer le graphe(villes, arêtes)
    créer N fourmis

fourmi.faire_un_pas():
    si dans une ville:
        choisir une arête et l’emprunter
    si sur une arête:
        avancer d’une unité
    si à la ville *Food*:
        prendre nouriture
        Choisir une arête de retour et l'emprunter
    si au Nid:
        Si porteur de nouriture
            la déposer
        choisir une arête d'aller et l’emprunter

main():
    répéter:
        pour chaque fourmi F:
            F.faire_un_pas()
            màj phéromone   
```


Tqt le PL (*pheromone level*) vaut :
$$
PL_{t + 1} = \alpha \mathrm{sin} (\beta PL_t + \gamma)
$$

### Normalement c intéressant à partir de là DIAPOS 35 à 41

Expl des params : ...

La fourmi $k$ à la ville $r$ va à la ville $s$ qui vaut :
* Si $q < q_0$:
    * $s = \mathrm{argmax}(\tau_{rs} \eta_{rs}^\beta)$
* Sinon:
    * $s = \mathrm{argmax}_{s \notin M_k} {Pk}$


#### Règle d'évaporation

$$
\tau_{ij}^{n + 1} = (1 - \rho) tau_{ij}^n
$$

#### Règle d'augmentation

$$
\tau_{ij}^{n + 1} = \tau_{ij}^{n + 1} + (\Delta \tau_{ij}^{n + 1})
$$

Où $\Delta \tau_{ij}^{n + 1} =$:
* Si $(i; j) \in T_k$: $1/C^k$
* Sinon: 0

#### Init des params

...

## Algos génétiques

