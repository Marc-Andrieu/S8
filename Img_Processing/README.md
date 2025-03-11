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
```math
I = f(V_d) = I_S \times \left(\mathrm{exp} \left(\frac{q V_d}{kT} \right) - 1 \right) - I_{ph}
```

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

## Introduction to img sensing and processing, avec M. A.

Le partiel c un QCM. Le reste c des compte-rendus de BE

### Camera

El big clasico modèle pinhole comme tjs.
* Y a une focale $f$
* On peut faire de la géométrie projective (finally, après 21 ans à attendre)

#### Lim

* Résolution
* *Dynamic range* (euh c quoi ?)
    * Saturation avec luminosité trop forte
    * Tout noir si luminosité très faible (sous un threshold)
* Spectre du visible
* Synthèse additive (de couleur)


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

### Traitement d'img

* Brève histoire diapo 29
* Des applications des diapos 35 à au moins 50

## Formation d'image, avec M. A.

### 3D

Toutes les mat ici sont en $4 \times 4$ : c de la géométrie projective (coord *hmgn*)
* $x$ vers la gauche, $y$ vers le haut, et $z$ en profondeur
* $R$ : rot
* $T$ : transl
* $P$ : projection
```math
M = Intrinsics \times P \times RT
$$
Où :
$$
\begin{align}
T &= \begin{bmatrix}
    I_3 & T_{3 \times 1} \\
    0_{1 \times 3} & 1
\end{bmatrix} \\
R &= \begin{bmatrix}
    R_{3 \times 3} & 0_{3 \times 1} \\\
    0_{1 \times 3} & 1
\end{bmatrix} \\
P &= \begin{bmatrix}
    1 & 0 & 0 & 0 \\
    0 & 1 & 0 & 0 \\
    0 & 0 & 1 & 0
\end{bmatrix} \\
Intrinsics &= \begin{bmatrix}
    -f_{sx} & 0 & x_c' \\
    0 & -f_{sy} & y_c' \\
    0 & 0 & 1
\end{bmatrix}
\end{align}
```

Vu qu'on identifie :
```math
\begin{bmatrix}
    x \\
    y \\
    z \\
    w
\end{bmatrix} = \begin{bmatrix}
    x/w \\
    y/w \\
    z/w \\
    1
\end{bmatrix}
```

Bah $w = 0$ concerne les pts à l'infini (c justement le cas pas traité en euclien)

Aussi ce qui est banger, c que mtn tout est liné, mm les transl, c juste multiplier (à gauche) par :
```math
T = \begin{bmatrix}
    1 & 0 & 0 & t_x \\
    0 & 1 & 0 & t_y \\
    0 & 0 & 1 & t_z \\
    0 & 0 & 0 & 1
\end{bmatrix}
```

Comme ça $x' = x + w t_x$ etc, et $w = w'$.

Pr tourner autour de chaque axe :
```math
\begin{align}
R_X &= \begin{bmatrix}
    1 & 0 & 0 & 0 \\
    0 & c \theta & -s \theta & 0 \\
    0 & s \theta & c \theta & 0 \\
    0 & 0 & 0 & 1
\end{bmatrix} \\
R_Y &= \begin{bmatrix}
    c \theta & 0 & s \theta & 0 \\
    0 & 1 & 0 & 0 \\
    -s \theta & 0 & c \theta & 0 \\
    0 & 0 & 0 & 1
\end{bmatrix} \\
R_Z &= \begin{bmatrix}
    c \theta & -s \theta & 0 & 0 \\
    s \theta & c \theta & 0 & 0 \\
    0 & 0 & 1 & 0 \\
    0 & 0 & 0 & 1
\end{bmatrix} \\
\end{align}
```

#### >1 caméras

$F = M^T E M$ où mat essentielle $E = RT$
* $R$ : rot
* $T$ : transl
* $M$ : passage du $xyz$ absolu vers le repère de l'oeil ($z$ la profondeur etc)

Disparité (diapo 28 qui a l'air banger) :

## Intensity Transformation and Spatial Filtering, zvc M. A.

* Notion de voisins (mat 3 $\times$ 3)
* Une image [en niv de gris] c $f : \mathbb{N}^2 \to \mathbb{N}$ une intensité par pixel
* Transformation d'intensité c $T: \mathbb{N} \to \mathbb{N}$ avec l'img transformée qui est $g = T \circ f$
    * E. g. un contrast stretching ça a une forme de sigmoïde
    * Un négatif c $T : r \mapsto \mathrm{max}(L - 1 - r; 0)$ où l'intensité est ds $[0; L - 1]$
    * Une log-transformation c $r \mapsto \mathrm{log}(1 + r)$
    * Transformations puissance (gamma) : $r \mapsto c r^\gamma$
        * $\gamma > 1$ pr de la corr
        * $\gamma < 1$ pr toucher au contraste
    * Piecewise-linear (liné par morceau)
* Qlq fn Matlab utiles :
    * `fft2`, `ifft2`
    * `imcomplement(M)` pr le négatif
    * `mat2gray(M)` pr display une mat en tant qu'img N&B
    * `im2uint8(M)` pr mult la mat par un scalaire pr l'avoir ds $\mathcal{M}([0; 255])$
    * `imadjust(M, [x_min, x_max], [y_min, y_max], gamma)` pr appl la transf gamma avec fn cste hors.
    * `imhist(M, b)` pr hist d'une img en N&B (jsp c quoi `b`)
        * `imhist(M, b) / numel (M)` pr normaliser l'histogramme
        * A propos d'égalisation d'histogramme : en gros on applique une transf qui est une intégrale, ça ft un peu passe-bas et ça permet de mieux distribuer les niveaux de gris : $\displaystyle T(r) = (L - 1) \int_0^r p_r(w) \mathrm{d}w$. En Matlab : `histeq(M, 256)`

### Filtrage : Spatial

* Convol avec un masque/kernel/template/fenêtre, bref plein de mots pr parler d'une mat de ptite taille
```math
g(x; y) = \sum_{s = 0}^{m/2} \sum_{t = 0}^{n/2} w(s; t) f(x + s; y + t)
$$
* Par contre pr les petits masques, ça peut donner un effet de quadrillage
* Fun fact : les filtres liné sont liné. Ah et ils commutent avec les fn de shift (décalage).
    * Rappel : la convol ça ft un groupe abélien, ça commute avec la multiplication externe (par un scalaire), et c distributif sur l'addition. Bref, avec $+$ et $*$ on a un anneau
* Filtre gaussien : en Matlab c juste `fspecial('gaussian', taille, 1)`
$$
G_{\sigma} : (x; y) \mapsto \frac{1}{2 \pi \sigma^2} \mathrm{exp} \left( \frac{-(x^2 + y^2)^2}{2 \sigma^2} \right)
```
* Les filtres gaussiens :
    * Sont passe-bas (logique ils sont en cloche donc leur TF aussi)
    * Stables par convol (ouais si tu convolues deux filtres gaussien ça reste un filtre gaussien)
    * Se factorisent en du $U^T V$ des vecteurs gaussiens
* Bilateral filtering : filtre liné + rejet des outliers (c mettre un seuil nan ?)

#### Filtres spatiaux de contraste (sharpening spatial filters)

* Le laplacien $\nabla^2$ (en convoluant par `fspecial('laplacian')`), très pratique
* $\mathrm{Id} + c\nabla^2$ pr augmenter le constraste
* Le gradient
* Filtre de Sobel : vertical (`fspecial('Sobel')` en Matlab)
```math
\begin{bmatrix}
    1 & 0 & -1 \\
    2 & 1 & -2 \\
    1 & 0 & -1
\end{bmatrix}
```

En horizontal c la transposée et celui-là

### Filtrage : Fréquentiel

* A propos d'aliasing : c du "lissage" ms qui rend moche, ça crée des artéfacts et de la distorsion. Et ds une vidéo, c par ex le ft de voir une roue ou une hécile tourner ds le mauvais sens.
* La convol spatiale qui devient un produit fréquentiel

#### DFT and iDFT

```math
\begin{align}
F(u; v) &= \sum_{x = 0}^{M - 1} \sum_{y = 0}^{N - 1} f(x; y) \mathrm{exp} \left(-2 j \pi \left( \frac{ux}{M} + \frac{vy}{N} \right) \right) \\
f(x; y) &= \frac{1}{MN} \sum_{u = 0}^{M - 1} \sum_{v = 0}^{N - 1} F(u; v) \mathrm{exp} \left(+2 j \pi \left( \frac{ux}{M} + \frac{vy}{N} \right) \right)
\end{align}
```

Les discrétisations sont reliées en échelle par $\displaystyle \Delta u = \frac{1}{M\Delta T}, \Delta v = \frac{1}{N\Delta Z}$

#### Propriétés en 2D

Transl et rot :
```math
\begin{align}
f(x; y) \mathrm{exp} \left(-2 j \pi \left( \frac{u_0 x}{M} + \frac{v_0 y}{N} \right) \right) &= F(u - u_0; v - v_0) \\
f(x - x_0; y - y_0) &= F(u; v) \mathrm{exp} \left(+2 j \pi \left( \frac{u_0 x}{M} + \frac{v_0 y}{N} \right) \right) \\
f(r; \theta + \theta_0) &= F(\varpi; \varphi + \theta_0), x = r \mathrm{cos} \theta, y = r \mathrm{sin} \theta, u = \varpi \mathrm{cos} \varphi, v = \varpi \mathrm{sin} \varphi
\end{align}
```

Bref un joli tableau diapo 35

#### Img smoothing

## Image reszing - Interpolation

Pr zoomer,dézoomer, tourner, corrections géom, etc
* Nearest neighbor interpolatin : on ft pareil qu'un des voisins
* Bicubic interpolation : fait intervenir les 16 (16?) + proches voisins

## Img compression based on freq

* Comme dit ds la vieille vidéo d'el Jj, l'oeil humain est bcp + sensible à la luminance (aux formes), qu'à la chrominance (auw couleurs), donc les trucs à 16777216 couleurs ça sert à rien, en baissant à 256 on voit mm pas la différence
* Compression pr stockage et transm
* Ms faut choisir une complexité algorithmique pr la compr et la décompr, la qualité perdue (en avec perte), à quoi on touche (couleur, ...), etc.
* Compression basée sur :
    * L'entropie : c comme ds mon appro de théorie de l'information, Huffman
        * VLC (Variable-length coding) : utiliser les freqs (au sens de "à quel point ce symbole est souvent utilisé ?") pr ajuster le code, genre Huffman, codage de source (cf. mon appro pr tt ça)
    * La source (?), FFT; subsampling (réduire le nbr de variantes de qqch utilisées psk l'oeil humain fera pas vrmt la diff)
        * Subsampling : écrit en format A:B:C (e.g. 4:2:2), resp. référence, le nbr de chrominance ds la 1e ligne, et pareil pr la luminance (c pas clair ms je fais avec le cours)
        * RLC (Redundancy-based methods) : e.g. `2bccccccefeel -> 2b#6cef#2el`
* On a globalement 2 raisons pr faire de la compression : 
    * L'oeil humain est limité donc c con de tout stocker
    * Y a de la redondance, y a déjà par construction des trucs qui apportent pas d'information


### DCT (Discrete Cosinus Transform)

$$
\begin{align}
\mathrm{DCT}(i; j) &= \frac{1}{\sqrt{2N}} C(i) C(j) \sum_{x=0}^{N-1} \sum_{y=0}^{N-1} \mathrm{pixel} (x; y) \cos \left( \frac {(2x + 1) i \pi}{2N} \right) \cos \left( \frac {(2y + 1) j \pi}{2N} \right) \\
\mathrm{pixel}(x; y) &= \frac{1}{\sqrt{2N}} \sum_{i=0}^{N-1} \sum_{j=0}^{N-1} C(i) C(j) \mathrm{CDT} (i; j) \cos \left( \frac {(2x + 1) i \pi}{2N} \right) \cos \left( \frac {(2y + 1) j \pi}{2N} \right)
\end{align}
$$

Où $C(x) = 1/\sqrt{2}$ si $x = 0$ et 0 sinon

En gros ça donne une nouvelle matrix $F$, avec un gros coeff en haut à gauche, et que des ptits coeffs ailleurs

### Hybrid Compression

* Basé sur CDT
* A pertes

Pipeline :
1. YCbCr
2. DCT
3. Quantification
4. Encodage

#### Quantification

On a une *table de quantification* $Q, c une matrice de mm taille que $F$, et on pose, en arrondissant à l'entier le + proche pr chaque coeff :
$$
\hat F (u; v) = F(u; v) / Q(u; v)
$$

#### Zigzag coding

* Pr transf l'img en un joli vecteur : on parcours en zigzag.
* Et là on peut faire du codage de source avec Huffmann, ou faire du RLC (Run Length Coding) / VLC (Variable Length Coding)

### Décompression

* On peut estimer l'erreur avec :
$$
e := f - \hat f
$$

## Hough Transform

### Espace de rpzt° naïf

* L'équa de ligne c $y = f(x) = ax + b$ ds l'espace de l'image
* DS l'espace des params, $b = g(a) = y - axs$
* Un pt ds un espace est une droite ds l'autre
* Donc on parcourt l'image ds $x$ et ds $y$ et on accumule : pr chaque $a$ on incrémente la cellule $y - ax$
* A la fin, le *point* où l'accumulateur est le + grd, ça correspond à la *droite* la meilleure

### Faire mieux : $(\rho; \theta)$

$$
\rho = x \cos \theta + y \sin \theta
$$

Du coup l'algo devient :
```
Pr chaque (x, y):
    Pr chaque theta:
        Case[ x*cos(theta) + y*sin(theta) ] += 1
```

### Amélio

* En calc le grad, on peut restreindre l'intervalle de $\theta$ testés

### Cercle

* C le mm concept, juste une équa différente, et on a 3 inc pas 2

## Transformations morphologiques (CM4 tqt rien n'a du sens ds ce cours)

### Opérations standards

Etant donné :
* Une img binaire
* une fn $\theta$ une fn à la Heaviside (1 au-delà d'un seuil, 0 en deçà)
* et un *élém structurant*, généralement du carré de $n \times n$ pixels avec $n$ petit et impair, juste le nbr de 1 autour d'un pixel $c(x; y)$

On définit qlq opérations
* Dilatation : $dilate(x; y) := \theta(c(x; y); 1)$
* Erosion : $dilate(x; y) := \theta(c(x; y); S)$ où $S$ c la taille de l'élém structurant
* Majorité : $maj(x; y) := max(c(x; y) S/2)$
* Ouverture : $opening(x; y) := dilate(erode(x; y); S)$
* Fermeture : $close(x; y) := erode(dilate(x; y); S)$
