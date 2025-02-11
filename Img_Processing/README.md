<script
    src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
    type="text/javascript">
</script>

# Capteurs et traitement d'images

Y a un diapo papier

## Capteurs, avec D. N.

### Intro : oeil, "capteur d'img"

Ds l'oeil y a :
* bâtonnets
* cônes

Pas la mm taille, captent pas les mm fréqs.
3 canaux RGB.

Avant y avait des capteurs chimiques : avec du nitrate d'argent, qui réagit à la lumière : + y avait de lumière, + ct noir. Donc ça s'appelait un "négatif".
Et un obturateur mécanique (~iris).
Mtn avec les semi-conducteurs. Discrétisation.
Convergence à la "optique géométrique" sur un capteur 24 $\times$ 36 mm

### Optique

\+ le capteur est ptit, + le capteur zoome.
Y a une notion de "crop factor".
Pr annuler cet effet, il "suffit" d'éloigner un peu + le capteur de la lentille.

Selon le zoom, y a une "zone de netteté" différente, qui dépend des angles.
Pr augmenter la netteté, faut réduire les angles, et ça se ft avec un... diaphragme !
Ms ça modif aussi la durée d'exposition.
Ms y a des params qui se compensent, etc... (bref la photographie manuelle c dur)

### Technos de capteurs d'img

2 technos principales : d'abord CCD, puis CMOS.
Y a un gros marché autour des téléphones.
Sony fabrique la moitié des capteurs d'images, après y a Samsung comme attendu, et puis le reste.

L'avantage du CMOS vs CCD assez guez :
* processus de fabrication standard. Alors que les CCD a une fabrication dédiée pr chaque appareil donc chiantos.
* Adressage random de pixels. Alors que décalages nécessaires pr adresses mémoires CCD.
* Puissance conso faible vs élevée.
* Mise en oeuvre easy vs périphériques dédiés nécessaires.

### Architectures et fonctionnement des capteurs CCD et CMOS

#### Photo-transduction (conversion photon -> charges élec)

Graphe Watt lumineux ($A/W$) en fonction de la longueur d'onde $\lambda$ ($\mu m$) :
* en théorie (photodiode idéale) y a proportionalité
* en pratique c assez affine sur $[0,2; 1] \, \mu m$ et après bam ça chute.
* Justement sur $[0,8; 1] \, \mu m$ c hors du visible ms la photodiode le voit, c pr ça que les télécommandes etc utilisent le NIR (*near infrared*).

BTW, une photodiode c juste une diode disséquée et on balance de la lumière deds.

Fonctionnement : y a une jonction PN clasico, avec un champ élec $E$ fort de $N$ vers $P$, donc un tout petit courant de fuite $I_S$ de $N$ vers $P$ (les $e^-$ arrivent pas à s'opposer à $E$).
L'exposition à la lumière ça translate juste la caractéristique vers le bas :
$$
I = f(V_d) = I_S \times \left(\mathrm{exp} \left(\frac{q V_d}{kT} \right) - 1 \right) - I_{ph}
$$

Le schéma équivalent de la photodiode c 3 trucs en parallèle :
* Un générateur de courant $I_{ph}$
* Une diode classique
* Une capa de jonction $C$

#### CCD (charge-coupled device)

Transfère toutes les charges élecs à trav ttes les col et ttes les lignes.
Donc mm avec un rendement de 99,999999%, bah à travers du 1000 $\times$ 1000 ça ft un rendement de $0,99999999^{1000} = \varepsilon$ (plot twist : non, $\displaystyle \left( 1 - \frac{1}{n} \right)^n \to e^{-1}$).

#### CMOS

Techno pixel actif 3T : y a un ampli deds.
Et un bail d'interrupteur qui empêche le courant de fuite de passer ds le bus colonne jusqu'en "bas".

$\displaystyle U = \frac{I t}{C}$ : à courant constant, la tension est affine en le temps d'exposition.
Et ce courant est proportionnel à l'intensité lumineuse : pr un pixel + éclairé, la tension diminue + vite.
On ft l'acquisition après un tps adapté à la luminosité de l'ensemble des pixels.

Avec 10 ms de décharge et 0,04 ms de lecture, on perd pas de temps : dès la lecture du $750^e$ pixel, on relance la décharge du $1^e$, commme ça on le lit dès que le $999^e$ est lu.

Bruit sans correction : bruit dit "poivre et sel", on voit rien.
Pr corriger ceci, dû à l'offset (cf. diapo 32), bah on ft 2 mesures.

### Img, couleurs

Résolution = nbr de pixels par surface
Oh y a encore Snell-Descartes qui ft chier.

Le format le + trivial c PGM : c littéralement l'implémentation naîve, c les valeurs RGB en plain text.
Et c gros vu que c 3 octets par pixels, donc 3 $\times$ height $\times$ width octets.
Pr filtrer que chaque canal R, G ou B... bah on ft un passe-bande.
BTW y a aussi une interpolation avec les voisins (littéralement un passe-bas twisté) pr enlever certains bruits (dus justement aux HF).
Ah le fameux $0,3R + 0,6G + 0,1B$.
Y a aussi l'encodage CMYK (*cyan, magenta, jaune, noir*), auquel cas le blanc c #00000000.
RGB et CMYK couvrent deux "gamuts" différents sur le graphe du TP de PCM sur la couleur (celui avec les couleurs pures sur le bord)

### Concl

* CMOS partt
* Photodiode
* RSB surtt en faible lum, à cause du $I_S$
* Lecture entrelacée (rolling shutter)
* Couleur par filtrage passe-bande

## Formation d'img, avec M. A.

Le partiel c un QCM. Le reste c des compte-rendus de BE

### Camera

El big clasico modèle pinhole comme tjs.
* Y a une focale $f$
* On peut faire de la géométrie projective (finally, après 21 ans à attendre)
* $x$ vers la gauche, $y$ vers le haut, et $z$ en profondeur

#### Lim

* Résolution
* *Dynamic range* (euh c quoi ?)
    * Saturation avec luminosité trop forte
    * Tout noir si luminosité très faible (sous un threshold)
* Spectre du visible
* Synthèse additive (de couleur)

#### >1 caméras

$F = M^T E M$ où $E = RT$
* $R$ : rot
* $T$ : transl
* $M$ : passage du $xyz$ absolu vers le repère de l'oeil ($z$ la profondeur etc)

Toutes les mat ici sont en $4 \times 4$ : c de la géométrie projective

$$
\begin{align}
T &= \begin{bmatrix}
    I_3 & T_{3 \times 1} \\
    0_{1 \times 3} & 1
\end{bmatrix} \\
R &= \begin{bmatrix}
    R_{3 \times 3} & 0_{3 \times 1} \\\
    0_{1 \times 3} & 1
\end{bmatrix}
\end{align}
$$

### Img

Une img... c juste un tenseur (waw).
D'ordre 2 si N&B, +1 si couleur ou_exclusif vidéo, et d'ordre 4 pr vidéo en couleurs. 
* Pr grayscale, le clasico c faire la moyenne entre les 3 canaux

Y a des espaces de couleur :
* RGB : Red Green Blue
* LAB : 
* HSL : Hue (Teinte, c une couleur de l'arc-en-ciel) Saturation (pureté de la teinte) Luminance (éclairage)
* YCDCR (Luminance Composante Bleue Commposante Rouge) : Luminance et Chrominance (cf. vieille vidéo d'*El Jj*) : l'oeil humain est en effet bcp + sensible à la luminance qu'à la chrominance (on peut donc la compresser sans pression)

#### RGB

* Avec du RGB à chaque canal est encodé sur 1 octet, ça donne $2^24 = 16 777 216$ couleurs possibles, et sur 2 octets, $2^48$ couleurs.

#### Matlab

```m
img = imread("chemin")
figure(1); imshow(img)
% Classes d'entiers :
% int8 à int64, et avec u devant pr unsigned
% flottants : double, single
```

### Related fields

* Computer graphics (3D (cf. mon moteur), ...)
* Pattern recognition (très vaste, mm en linguistique)
* Computer Vision (PAr)

Sous-trucs
* Compression d'img
* VR, AR
* ML