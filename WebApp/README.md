<script
    src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
    type="text/javascript">
</script>

# Applications Web avec R. C.

## Intro

* *In fine*, tout est basé sur la stack HTML5 + JS.
* Archi 3-tiers : front + back (API + DB)
* Responsive : 1 seul code $\forall$ taille d'écran
* Cours à la cool pas très linéaire

### Eval
* Autonomie en binôme (je SG Ñool)
    * Rendu du src + "rapport" (on va juste faire de la doc)
    * Restitution (oral)
* Partiel : QCM

### La stack ds cet électif
* Front :
    * HTML5
    * JS pur
        * AJAX : pr les WS (WebSocket)
        * DOM : pr modif le html
        * Qlq APIs...
* Back :
    * API : node.js
    * DB : *rien de spécifié*

### Histoire et fun facts

* 12/95 : création
* 11/96 : proposé à ECMA pr en faire un ECMAScript (ES, pr standardisation)
* 06/97 : ES1
* 06/98 : ES2 s'aligne sur ISO
* 12/99 : ES3
* 2000+ : AJAX (*Async JS & XML*), `XMLHttpRequest`
* 2009 : ES5
* 2015 : ES6
* JS est encore aujd le langage le + populaire

Essentiellement y a 3 "navigateurs" : Firefox, Chromium, et Safari.
Tt le reste est Chromium-based.

## JS : la base

### Template HTML

```html
<!DOCTYPE html>
<title>Titre</title>
<meta charset="utf-8">

<p id="monId">Contenu</p>

<script src="mon_script.js"></script>
```

### Généralités JS

* `;` comme en C++. C optionnel, ms par pitwei mets-le sinon c chiantos pr debug

### Ecriture
```js
document.write('Hello World'); // ajouter
monId.innerHTML = "Helloworld"; // remplacer le contenu des balises dont l'id est `monId`
```

### logs

y a `console.log("yo")`, ms aussi `.info(), .warn(), .error()`

### Pop-up
`alert("yo");`

### Logique : identique au C++ (à checker)

#### Opérateur de nombres

```js
<, >, <=, >=
==, != // ici 42 == true oui
===, !== // strict : 42 === true non
```

#### Opérateurs de bools

```js
&&
||
!
```

#### Conditions

```js
if (cond) {
    instr;
} else {
    instr;
}
for (let i = 0; i < n; i++) { // cf. let
    instr;
}
while
switch
break
continue
```

#### Opérateur ternaire

```js
maVar = bool ? si_true : si_false;
```

### Maths

```js
+, -, *
// + ft aussi la concat de string
9 / 6 // eucl ou entière ?
% // modulo
++, -- // incr et décrémentation
+=, -=
```

### Fonction

#### Déclarée

Récursivité possible, car fonc globale
```js
function ma_fn(n) {
 if ( n % 1 ) return undefined; // n non entier
 return ma_fn(n-1);
}
```

#### Anonyme

Récursivité impossible
```js
ma_fn = function (n) {
 return n;
};
```

#### Nommée

Dérivé de la syntaxe anonyme... en nommant!
Récursivité possible à nouveau.
```js
ma_fonc = function ma_fn(n) {
 if ( n % 1 ) return undefined; // n non entier
 return ma_fn(n - 1);
}
```

#### Flèche

Dérivé de la syntaxe anonyme (on a juste tej le `function` et ajouté `=>`).
Introduit en ES6.
```js
ma_fn = (n) => {
    return n;
}
```

#### Accès aux args

Avec `arguments`, comme `*args` en Py :
```js
() => { //tqt on a mm pas besoin de parler d'args
 for (i = 0; i < arguments.length; i++ ) {
    instr;
 }
}
```

#### De 1e classe

En JS, les fn sont des *first-class citizens*, *ie.* des objets avec attr et methods.

```js
ma_fn = (n) => {n * n}
ma_fn.length; // 1 car 1 args
ma_fn.call(null, 42); // 1764
[9, 6, 3].sort(
    (a, b) => {return a - b;} // fn de comparaison
) // [3, 6, 9]
```

Les fn flèches n'ont pas `this` ds leur contexte (moi non plus jsp pk) :
```js
dico = {
    attr = "truc",
    method1: function(p) {console.log(this[p]);},
    method2: p => {console.log(this[p]);},
}
dico.method1("attr"); // "truc"
dico.method2("attr"); // undefined
```

* On peut imbriquer des fn (déclarer `sub_fn` ds `fn`), auquel cas `sub_fn` est locale et peut servir à override un `sub_fn` global (car une var (*e.g.* une fn) est)
* Clôtures : en gros, si une fn1 renvoie une fn2 et que fn2 se sert d'une var locale, bah la var locale est pas détruite par le garbage collector, du coup ça agit comme une var statique :
```js
incr = function() { // renvoie une fn
    var value = 0; // var "stat"
    return function() { // fn d'incr refaite
        return value++;
    }
}();
incr(); // 1
incr(); // 2
``` 

### Variables

* Une var est *déclarée* si y a un `var, let` ou `const` devant
* Les déclarées sont locales, les non-déclarées sont globales par défaut !
    * Donc à l'intérieur d'une fn, mets des `var` stp
```js
var x = 1; // déclarée et defined
var y; // déclarée ms undefined
z = 2; // non-déclarée et defined
let l = 3; // introduit en ES6, pr lim au bloc actuel la portée d'une var
const c = 4; // introduit en ES6. Throw un TypeError si on essaie de modif un const
u = (() => {
    var v = 1; // locale
    return v + 2;
})(); // u = 3;
```

### Types

```js
typeof variable // return son type

true, false // 0, -0, null, NaN, undefined, et "" se convertissent en false; et TOUT le reste en true
// undefined et null, c une valeur et un type, comme None en Py
undefined // pr les var non-init
null // initialisé à null
object // divers trucs, comme les listes, null, une instance de classe
function // fn et classes

// Nombre : pas d'entier, que ces flotants en JS
n = 3;
flotant = 3.14;
scienfitique = 3.14e0;
o = 0o777; // = 511, c de l'octal (base 8)
h = 0xff; // = 255, c de l'hexadécimal
inf = Infinity;
nan = NaN;

// String : ils sont pas mutables
double = ""; // un \ pr escape
simple = '';
mon_str.length;
mon_str[42]; // clasico
mon_str.substring(n, m) // prend les chars n à m - 1
// Pr l'unicode :
"\u0301" // diacritique pr l'accent aigu; ça compte comme 1 char itself (é = 2 chars.. ms blc nan?)
"\u{1F60E}" // pr ceux sur 2 unités de 16 bits
mon_str = mon_str.normalize(); // fusionne des caractères, comme ça "é" comme comme 1 char
[...mon_str] // liste avec les chars

// Arrays
t = [1, true]; //hétérogènes
t[42] = "a"; // dynamiques
t[0]; // commence à 0
t.length;

// "Associative array" (dico), (aussi appelé Object pr faire joli, ms faut pas le dire). C du JSON ds une var
dico = { // hétérogène
    nom1: 42,
    nom2: true, // attribut
    fn: (n) => {n * n}, // method : c juste que la variable en value c une fn (et en vrai c pas con !)
};
dico["nom1"] // tjs possible
dico.nom1 // possible si "nom1" est pas chelou
for (clef in dico) {} // seule façon d'itérer sur les keys, et impossible direct sur les values
// JSON : KEYS entre "guillemets"

```

#### Conversions bricolées

```js
+truc; // nbr
truc + ""; // str
parseInt("12.34azerty") // -> 12
parseFloat("12.34azerty") // -> 12.34
```

#### Objets natifs

```js
Boolean, Number, String // encapsulent le type primitif correspondant
Math
Array, Date, Error, RegExp // ça hérite + ou - d'Object 
Function
Object

// Pas natifs
JSON, Array, Promise, Map, WebAssembly

// Number
Number.isInteger(n)
// y a qlq fonctions pr en faire des str assez pretty
n.toExponential()
n.toFixed()
n.toLocaleString('fr-FR')
n.toPrecision()
n.toString()

// Math
Math.PI // et qlq autres constantes
Math.min() // et plein d'autres methods

/* String
plein de methods : startsWith, endsWith, includes, 
à la regex : match, replace, search, slice, split, substring,
autres : normalize, toLocaleLowerCase(), toLowerCase()
etc */

// JSON : 2 methods et c tout
JSON.stringify({}); // serialization
JSON.parse(""); // deserialization

// Array
t.length = n; // tronque le tableau
// Manipulés par référence :
a = [42];
b = a; // pointent vers la mm adresse
a[0] = 30; // désormais b pointe aussi sur [30]
/* vla les méthodes :
Array.from("str"), .concat([42]).indexOf(elem), .join("str"), .lastIndexOf(elem), .slice(index1, index2), .toString(), .toLocaleString(), .copyWithin(), .fill(), .pop(), .push(), .reverse(), .shift(), .sort(), .splice(), .unshift(), .entries(), .every(), .filter(), .find(), .findIndex(), .forEach(), .keys(), .map(), .reduce(), .reduceRight(),
.some(), .values()
*/

// Date
mtn = new Date();
date1 = new Date(1739344350); //timestamp Unix
date2 = new Date(année, ...)
/* encore vla les methods :
setTime(), set(), setUTC(), getTime(), get(), getUTC(), getTimezoneOffset(), des conversions vers String de toutes sortes, vers JSON, etc.
*/

// RegEXp
regex = /mon regex ici/g;
// .match, .search, .replace, etc.

// Error (ouais y a un objet Error)
try {
    instr douteuses;
} catch (e) {
    if (e instanceof SyntaxError) {
        console.log(e.name + ': ' + e.message);
    }
}
```

### Prototypes

Y a pas d'héritage, instead, on "clone" et on modif.`
```js
var parent = ...;
var enfant = Object.create(parent);
// Object.getPrototypeOf(eve) c bien parent
// Achtung, modif parent après coup va aussi modif enfant

for (attr in object) {} //oui on peut itérer sur les attrs
```

#### Constructeurs

```js
function Truc(nom) {
 this.arg = arg;
}
truc = new Truc(arg); // le new sert à ce que le this réfère à un nouvel Object, qui est celui retourné, au lieu de l'Objet global
```

#### Classes

```js
class Classe {
    constructor(arg) { // keyword constructor pr init
        this.arg = arg;
    }
    method() { // pas de "function" devant les methods
        return this.arg
    }
    get mon_arg() {
        return this.arg
    }
    set mon_arg(arg2) {
        return this.arg = arg2
    }
}
var mon_instance = new Classe(arg);
mon_instance.mon_arg;
mon_instance.
```

### Vrac

```js
let
const
import
export
throw
```
