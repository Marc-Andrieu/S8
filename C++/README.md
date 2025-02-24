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
	double nom_attribut;
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
*var // get la valeur (le contenu)
```

En gros y a :
* les variables normales : on en fait des adresses avec `&`
* les adresses (pointeurs) : on en fait des variables normales avec `*`
```cpp
double x = 3.14;
double *pt; //pointeur sur du type double
// et pt tout court c un int

pt = &x; //adresse de x, mise ds pt
x = *pt; //valeur (contenu) que pointée par pt, mise ds x
// Dualité entre ces deux expr

pt = 0; //pointe sur rien
```

### Allocation dynamique

```cpp
new, delete; // Opérateurs d'allocation dynamique

char *pt;
pt = new char; // opérateur d'emprunt, renvoie un pointeur
*pt = 'a';
delete pt; // opérateur de restitution
pt = 'b'; //on casse la mémoire youpi
```

En pratique, à la fin de l'exec, y a restitution automatique.

#### Tableaux dynamiques

```cpp
type *tab = new type[taille]; //allocation
tab[n] = blabla; // traitement
delete[] tab; //libérateur de tt le tableau
// Là si t'oublies les [], ça libère que le 1e élém
```

## Fonctions

```cpp
type_retourné nom_fonc (type arg1 = val_par_défaut, type arg2) {
	instr1;
	instr2;
	return var; // sauf pr le type void
}
```

Y a un type spécial `void` pr dire que la fonction renvoie rien (auquel cas pas de `return` à caser), e.g. :
```cpp
void affiche (int x) cout << x << endl;
```

### 3 façons de passer des args :

#### Par copie/valeur (default)

* Ca crée une copie des vars, avec les mm vals. Donc à éviter si possible.
* Après, c "safe" en ceci qu'on est sûr que ça va pas modif les var passées en args.
* C le seul cas où le type retourné c pas forcément `void`

#### Par adresse (avec pointeurs, un peu guez)

```cpp
void triple(int *p) {
	*p = *p * 3;
}
int n = 5;
int *p_n = &n;
triple(p_n);
cout << n << endl; // n = 15
```

#### Par réf (trop cool, modif en place) (cf. réfs au 10/02)

```cpp
void triple(int &n) {
	n = n * 3;
}
int n = 5;
triple(n);
cout << n << endl; // n vaut 15 
```

# CM 2 (10/02)

## Pointeurs et réfs

### Pointeurs (continuation)

* `0x` au début des adresses c juste pr dire qu'elle est écrite en hex.
* Pr avoir un pointeur qui pointe ds le vide, y a aussi :
```cpp
float* pt = NULL;
```
* Vu qu'un pointeur c un entier, on peut faire toutes les opérations usuelles, dont `++`, pratique pr se déplacer ds un vecteur.
* `if (p == NULL)` c pareil que `if (p)`

### Réfs

int n ;
int &ref = n; // r référence sur n, ie. son contenu pointe sur celui de `n`
int *pt = &n; // pt une pointeur sur n
n = 3;
// *pt et ref valent 3

### `const`

```cpp
const double pi = 3.14; // on met juste const devant
```
Si on essaie de modif un const, ça fail

## Tableaux statiques (allocation consécutive)

### 1D ("vect")

```cpp
int v[2] = {1, 2}; // bon bah cette syntaxe c bon aussi
// ici, v pas un vect ms un pointeur sur le 1e élém
// En adresses : &v[i] vaut v + i (y compris pr i = 0)
// En valeurs : vect[i] vaut *(vect + i)

// Damn, en fait écrire ces 2 lignes c pareil
*(v + 1) = 3;
v[1] = 3;
// On écrit 3 ds le contenu.
// J'ai l'impression que v[i] c du syntactic sugar pr *(v + i)
```

### 2D (matrice)

```cpp
int m[2][3]={
	{5, -8, 4},
	{-1, -2, -3}
}; // prend 6 octets
// En adresses : &m[i][j] vaut m + j + 3*i
// En valeurs : m[i][j] vaut *(m + j + 3*i)
```

### Allocation dynamique

```cpp
new, delete; // comme resp. malloc() et free() en C
```

Pr une matrice, c un pointeur (de type `type**`) vers le 1e élém d'un vecteur, ms en réalité chaque élém de ce tab-là est un pointeur (de type `type*`) vers le 1e élém de chaque ligne (de type `type`).

## Fonctions

* 3 types de passage d'args (cf. la smn dernière)
* Cette fn fail à chaque fois, car `x` est libéré à la fin de l'exéc de la fn :
```cpp
int* RetAdresse () { 
	int x = 2;
	return &x;
}
```
* On peut donner le mm nom à plusieurs fn, du moment qu'elles ont pas exactement les mm types des args et à la fois le mm type de retour.
* En vrai, y a un peu de conversion implicite, genre `int` vers `float` ou `long`, de `float` vers `double`

## Orienté Objet

### Rappels triviaux

* La classe c l'abstraction (le concept, la nature) d'une instance/objet (un exemplaire).
* Y a des attr/properties, et des methods.
* Oh c bien formulé : l'instance est à la variable ce que le type est à la classe.
* Encapsulation : c le ft qu'une classe c une boîte cloisonnée qui regroupe des données (attr) et des traitements (methods).
* En C++, y a la notion d'attr privé et public

### Code

```cpp
struct NomStruct {
	type attr1, attr2;
	void fn1 (type arg);
};
void NomStruct::fn1 (type arg) {
	instr; // c l'implémentation. En ft c vachement proche du Rust philosophiquement
}

NomStruct N1 {1, 2}, N2; // c facultatif de mettre un struct au début
// 1 ira ds attr1, 2 ds attr2
N1.attr1 = 3;
N2 = N1; // c licite d'affecter entre 2 structures de mm type
// Par contre on peut pas tester l'=té entre 2 instances
```

### Pointeur dessus

```cpp
NomStruct N;
pt = &N;
// vu que *pt vaut N, *(pt).attr1 vaut N.attr1, ms on écrit :
pt -> attr1 = 3.14; // pr ut la valeur de attr1
// A nouveau, c juste du syntactif sugar pr *(pt).attr1
```

### Classe : public et privé

```cpp
#include <iostream>
using namespace std;
class NomClasse { // ouais, struct devient class, tqt
	public:
		NomClasse (type arg); // C le *constructeur*
		// Il porte forcément le mm nom que la classe
		// et n'a mm pas de void devant (il est spécial)
		// Il peut y en avoir plusieurs, vu que c juste une fonc
		// (tant que le type de ces fn n'est pas le mm)
		void fn1 (type arg);
	private:
		type attr; // pas accessible directement
}
NomClasse::NomClasse (type arg) { // impl d'un constructeur
	attr1 = ...;
}
```

### Constructeur

* Ca sert à s'assurer qu'à la déclaration d'un objet, il soit bien bien initialisé (attr définis).

Y a 3 constructeurs :
* Par défaut
* Autres avec des vals par défaut
* De recopie

#### A programmer systématiquement si classe à allocation dynamique

* Constructeur par recopie : pr bien recopier chaque truc
* opérateur d'affectation : idem
* Destructeur : sinon on delete pas tout

Ces 3-là ds le cas où la classe en question alloue de la mémoire dynamiquement (on connaît pas *a priori* la taille alloué à une instance)

#### Par défaut

```cpp
//.cc pr class
class MaClasse {
	public:
		MaClasse(); // constructeur par défaut
		MaClasse (int attr); // autre constructeur, sans vals par défaut
		MaClasse(int attr = 0); // autre constructeur, avec vals par défaut
		MaClasse(const MaClasse &P); // constructeur par recopie
		~MaClasse(); // destructeur
		void method1();
		void operator=(X&); // on peut avoir des opérateurs custom
	private:
		int attr;
}

//.h pr header
MaClasse::MaClasse() {attr = 0;} // constructeur par défaut
MaClasse::MaClasse(int attr1) {attr = attr1;} //autre constructeur avec vals par défaut
MaClasse::MaClasse(const MaClasse &P) {
	//mot-clé "this" pr auto-référence
	attr = P.attr;
	tab = new double[attr]
	for (int i = 0; i < attr; i++) tab[i] = p.tab[i];
}
MaClasse& MaClasse::operator=(const MaClasse &P) {
	if (this != &P) {
		delete [] tab;
		attr = P.attr;
		tab = new double[attr];
		for (int i = 0; i < attr; i++) tab[i] = p.tab[i];
	}
	return *this;
}

//.cpp
// Allocation statique
MaClasse mon_instance1; //pas de ()
MaClasse mon_instance2(42);
mon_instance1.method1();

MaClasse mon_instance3(mon_instance2); // constructeur de recopie, il existe par défaut

// Allocation dynamique
MaClasse *pt_mon_instance = new MaClasse(42);
pt_mon_instance -> method1();
delete pt_mon_instance;
```

### Destructeur

A la fin de l'exéc d'un prog, y a automatiquement un appel au destructeur par défaut.

Parfois faut le surcharger

```cpp
// ds la classe, on a un attr double *tab, tab de flottants
MaClasse::MaClasse(...) // ça ct le constructeur
MaClasse::~MaClasse(...) { // ça c le destructeur
	if (tab != NULL) {
		delete [] tab; // on lib le tab
		tab = NULL; // on remet à null le pointeur
	}
}

```

### Fonction amie

C bien une fn, pas une method.
Déclarée que ds le `.h`.
Possède les mm droits qu'une method, donc peut accéder aux attr privés. 

```cpp
// .cc
...
	int method1();
	friend int fn_ami(MaClasse A, MaClasse B);

int fn_ami(MaClasse A, MaClasse B) {
	if (A.attr == B.attr) return 1; else return 0; // accès aux attrs privés
}
```

### Opérateurs

Peut être défini comme opérateur ami (fn) ou opérateur membre (method).

```cpp
// Ex : addition de deux points
// .cc
# nclude <iostream>
using namespace std;
class point {
	public:
		point (int x1 = 0, int y1 = 0);
		friend point operator+(const point &A, const point& B); // c un ami, vu que ça peut pas être une method (tu renvoies un nouvel objet)
		point& operator +=(const point& A);
	private:
		int x, y;
};

//.h
#include "point.h"
point::point(int x1, int y1) {x = x1; y = y1;}
point operator+(const point &A, const point &B) {
	point C(A.x + B.x, A.y + B.y);
	return C;
}
point& point::operator+=(const point &A) {
	x+=A.x; y+=A.y;
	return *this;
}

```

On peut aussi surcharger `<<` et `>>` de `ostream` (vers la diapo 64).


### A caser qlq part

#### Alloc stat et dyna

```cpp
main () {
	Vect T(10); // alloc stat
	Vect *pV = new Vect(42); // alloc dyna
	pV -> ma_method(args);
	delete pV;
}
```

#### Un tableau de 3 "Vect"

```cpp
main () {
	Vect** pV = new Vect*[3];
	for (int i = 0, i < 3, i++) {
		pV[i] = new Vect[10];
	}
	pV[0] -> ma_method(args);
	}
```

#### Destructeur de ça

```cpp
for (int i = 0, i < 3, i++) {
	delete pV[i]; // on kill tous les elems deds
}
delete [] pV; // on kill le tableau
```

### Classe générique

* Aussi appelées *patrons* ou *modèles de classes*, ça sert à créer des classes qui ont un type (en ft, une classe) comme param, *e.g.* typiquement un vecteur d'objets d'une mm classe qlqconque.
* Ds ce cas, toute la classe est ds le `.h` !

```cpp
// point.h
#include <iostream>
using namespace std;

template <class T>
class point {
	public:
		point(T x1, T y1) {
			x = x1;
			y = y1
		}
		void deplace(T d) {
			x += d;
			y += d;
		}
		T getX() {return x;}
	private:
		T x, y;
}
```

### Dérivation et composition : revoir diapos 68 à ~70

Une classe est composée si ses attr sont des objets :
```cpp
class MaClasse {
	public:
		MaClasse(...);
	private:
		...
}
```

Une classe est dérivée si apporte une info en + à la classe mère :
```cpp
//classederivee.h
class ClasseDerivee : public ClasseMere {
	public:
		ClasseDerivee(arg1, arg2); // constructeur par défaut, en héritage
		ClasseDerivee(ClasseDerivee &C); // constructeur par recopie, en héritage
		operator=(ClasseDerivee& C); // opérateur d'affectation
		type ClasseDerivee::ma_method(args); // pr surcharger une method de la classe mère
	private:
		...
}

//classederivee.cpp
ClasseDerivee::ClasseDerivee(arg1, arg2):ClasseMere(arg1) { // par défaut
	attr2 = arg2;
}
ClasseDerivee::ClasseDerivee(ClasseDerivee &C):ClasseMere(C) { // par recopie
	attr2 = C.attr2;
}
ClasseDerivee& ClasseDerivee::operator=(ClasseDerivee& C) { // affectation
	this -> ClasseMere::operator=(A);
	attr2 = C.attr2;
	return *this;
}
type ClasseDerivee::ma_method (args2) { // surcharge
	... ClasseMere::ma_method(args1) ... //appel à celle qu'on est en train de surcharger
	... //avec args2
}

// main.cpp
void main () {
	ClasseDerivee c;
	...
	c.ClasseMere::ma_method(args); // pr forcer l'appel de la method avant surcharge
}
```

* Le destructeur par défaut d'une classe dérivée fait appel au destructeur de la classe mère.
* Eviter absolument l'héritage multiple, le prod garantit que c une horreur.

### Méthodes virtuelles et polymorphisme

#### Typage statique

Soit une classe `B` dérivée d'une classe `A`, qui surcharge une method `fn` de `A` :
```cpp
A* pta;
B* ptb;
pta = ptb; // tt va bien jusque là
pta -> fn(args); // appelle la fn de A... bah oui j puisque pta* est de type A 
```

#### Typage dynamique

Faut juste ajouter un `virtual` à la method de `A` pr que ça résolve l'appel vers une surcharge :
```cpp
//.h
class A {
	public:
		...
		virtual type fn(args);
		...
	...
}
```

### Classe abstraite

C chelou, tqt, ms pr avoir une classe *virtuelle* (abstraite), il faut et il suffit d'avoir une fn virtuelle avec `= 0` :
```cpp
class A {
	public:
		...
		virtual type fn(args) = 0; // paf la classe A est abstraite
		...
	...
}
```

### Exceptions

3 mots-clefs (*keywords*):
```cpp
throw
try
catch
```

Une exception, c tjs hérité de la classe `exception`.

Pr le try catch :
```cpp
try {
	instr;
} catch(int n) { // code d'err
	instr;
} catch(const char* msg) { // msg d'err
	instr;
} catch(bad_alloc) { // natif
} catch(...) { // 
	instr;
}
```

Pr le throw :
```cpp
#include <cmath>
using namespace std;

float racine(double d) {
	if (d < 0)
		throw 1;
	return sqrt(d)
}
```

#### Liste d'initialisation

```cpp
// voir diapo 70
Individu::Individu(char* Name, int j, int m, int a):DN(j, m, a)
{strcpy(Nom, Name);}
Individu::Individu(char* Name, Date& d):DN(d)
{strcpy(Nom, Name);}
```

#### Bonnes pratiques

* L'héritage fige bcp de choses, donc il est utilisé de moins en moins
* Les attr `private` d'une classe sont mm pas accessibles par une classe qui en dérive.
	* Pr le permettre on place ça ds `protected` : c comme privé pr la classe elle-mm, et pr les classes dérivées de celle-ci, elles peuvent ce servir de ces attr hérités.

## Vrac

Pr chaque classe, on a 2 fichiers :
* un `.h`(*header*) pr la déclaration de la classe
* un `.cpp` pr le code de la classe
