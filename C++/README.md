<script
    src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
    type="text/javascript">
</script>

# Cours C++ avec E. D.

[Lien du cours](http://perso.ec-lyon.fr/derrode.stephane/Teaching/ECL2A3A/ECL2A_C%2B%2B)

## Un peu d'histoire

* `C` (1972, *Ken Thompson* ce **GOAT**) après `B`, pr réécrire `UNIX`
* Tout aux *Bell Labs*
* C le $1^e$ langage indép de l'architecture du processeur (accès mémoire, etc)
	* Du coup c cool pr l'embarqué
* 1978 : le fameux [*The C programming language*](https://download.books.ms/main/205000/556e6bee561b776c95c6872c441baad1/Brian%20W.%20Kernighan%2C%20Dennis%20M.%20Ritchie%20-%20The%20ANSI%20C%20Programming%20Language-Prentice%20Hall%20%281988%29.pdf)
* 1980 : `C++` comme extension pr POO
* 2011 : dernière ratification (par ISO) du C++ (pilotes (*drivers*), etc)

## Carac

* Langage compilé (en "langage machine") : c un *binary* ("exécutable"), pas d'intermédiaire avec la machine
* Plusieurs fichiers
	* Compilables séparément : `.cpp` $\to$ `.h`
	* Puis l'éditeur de liens compacte les `.h` et les `#include <>` en un seul binary
* Y a des lib *standards* (natives) à inclure (importer)
* C pas memory-safe
* En vrai les OS récents ils allouent une partie de mémoire aux programmes, donc c bon tu vas pas casser ton ordi
* Tjs une fonc `int main()`
	* qui sert d'entrypoint
	* et return un code de retour int (clasico `0` qd OK)

## Code

```cpp
#include <iostream>
using namespace std;
int main()
{
	cout << "Bonjour ECL !" << endl;
	return 0;
}
```

### Explications

* `using namespace std;` : pr pas avoir à mettre genre `std::cout` à chaque fois ; et tt façon c le standard
* Tjs finir par `;`, blc des \n et de l'indentation :
```cpp
x = 3 +
2; y = 42;
```
* Commentaires :
```cpp
// one-line
/* Multi-
Line */
```
* le trick c `{}` pr faire passer une série d'instructions as une seule, et pas de `;` après :
	* Var locale si définie entre `{}`, globale sinon
```cpp
if (a > b) {
	x = 2;
	y = 3;
}
```

### Les imports basiques

```cpp
#include <iostream>
#include <vector>
#include <string>
#include <cmath>
```

### IO

le `c` c *channel* (c le `std` du shell)
```cpp
// écriture (~stdout, echo)
cout << "ab" << "cd"; 
/* lecture (~stdin, read),
avec type-checking,
le 1e stocké ds x, le 2nd ds y */
int x; double y; cin >> x >> y;
"ab" << "cd" // ?
"ab" >> "cd" // ?
endl; // "endline", c \n
/* Si on trouve que "ça va trop vite"
(ça termine avant d'echo qqch ds stdout),
on ajoute ces 2 lignes après les `cout <<` */
cin.ignore();
cin.get()
```

### Fortement typé

```cpp
type nom_var (= val);
sizeof(...); // taille allouée (en octets)
```

Y a 2 types de types :
```cpp
//Types de bases (non-scalaires, ie. 1 seule info)

int  // entier, 32bit
long // entier, 64bit
char // 8bit, et c forcément entre 'guillemets simples'
bool // 8bit c abusé
float, double // réels


// Types construits ou structurés (contient plusieurs infos)

struct NomStruct { // non-scalaire, hétérogène
	double nom_attribut;;
};
// comme en Rust, c des classes sans implémentation de fonctions
NomStruct N;
N.nom_attribut = 3.14; // comme d'hab

#include <vector>

vector<type> v(); // non-scalaire, homogène (que du `type` deds)
/* c dynamique (taille peut changer)
args optionnels : taille de départ en 1e, valeur de tous les éléms en 2nd */
v.push_back(elem); // method pr append
int taille = v.size(); // method pr taille

vector<int> v(20, 8); // taille 20, que des 8 deds
vector<vector<int>> mat(42, v); // matrice, toutes les lignes sont des v
v[8][8] = 42;
v[20] = 3; //n'étant pas memory-safe, ça casse qqch autre part

#include <string>
string s = "ab"; // c forcément entre "guillemets doubles"
char c = s[0];
vector<char>; // c littéralementça
s.size();
```

### Maths

$\to$ Nbr
```cpp
+, -, *,
/, // eucl entre 2 entiers, tout court entre 2 réels
%, // modulo
++, -- // incr et décrémentation
// et askip faire += et tout c licite
```

$\to$ `bool`
```cpp
<, >, <=, >=,
==, !=,
&&, ||, !
```

### Conditions
```cpp
if // C comme une fonction
if (bool) {
	instr;
} else {
	instr;
}

switch // clasico switch case

// for
for(init; maintien; incr) {
	instr;
}
for (i = 0; i < n; i++) {
	instr;
} // el clasico

// while : y a les 2, comme en VBS
while (cond) {
	instr;
}
do {
	instr;
} while (cond); // cas spécial : ";" qu'ici
```

## Pointeurs

### Bases

Le pointeur, c l'entier qui est l'adresse mémoire d'une autre var
```cpp
&var // get l'adresse
*var // get la valeur
```

En gros y a :
* les variables normales : on en fait des adresses avec `&`
* les adresses (pointeurs) : on en fait des variables normales avec `*`
```cpp
double x = 3.14;
double *pt; //pointeur sur du type double
// et pt tout court c un int

pt = &x; //adresse de x, mise ds pt
x = *pt; //valeur que pointée par pt, mise ds x
// Dualité entre ces deux expr

pt = 0; //pointe sur rien
```

### Allocation dynamique

```cpp
new, delete; // Opérateurs d'allocation dynamique

char *pt;
pt = new char; // opérateur d'emprunt
*pt = 'a';
delete pt; // opérateur de restitution
pt = 'b'; //on casse la mémoire youpi
```

En pratique, à la fin de l'exec, y a restitution automatique.

### Tableaux dynamiques

```cpp
type *tab = new type[taille]; //allocation
tab[n] = blabla; // traitement
delete[] tab; //libérateur
```

## Fonctions

```cpp
type_retourné nom_fonc (type arg1, type arg2) {
	instr1;
	instr2;
}
```

Y a un type spécial `void` pr dire que la fonction renvoie rien, e.g.
```cpp
void affiche (int x) cout << x << endl;
```

### 3 façons de passer des args :
* Par copie (default)
* Par adresse (avec pointeurs)
```cpp
void triple(int *p) {
	*p = *p * 3;
}
int n = 5;
int *p_n = &n;
triple(p_n);
cout << n << endl; // n = 15
```

* Par réf
```cpp
void triple(int &n) {
	n = n * 3;
}
int n = 5;
triple(n);
cout << n << endl; // n vaut 15 
```
