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
    static fn_de_classe() {
        return "Une bonne grosse constante"
    }
    // aussi static get et static set
}
var mon_instance = new Classe(arg);
mon_instance.mon_arg;
mon_instance.mon_arg = arg2;
Classe.fn_de_classe();

// "Héritage"
class SousClasse extends Classe {
    constructor(arg) ={super(arg);}
}

```

#### Que vaut `this` ?

* Globalement : `window` (ou `module.exports` en node.js)
* Constructeur : le nouvel objet
* Mehhod : l'objet sur lequel la method a été appelée
* Fn classique : comme en global, par contre vaut `undefined` en mode strict
* Fn flèche : change par la valeu qu'il a à l'étage supérieur

### Vrac

```js
let
const
import
export
throw
```

## Le DOM

C un ens d'API standardisées, indép de la plateforme et du langage, pr accéder au contenu, struc et style des HTML et XML.


### DOM Core

Du HTML c juste un arbre.
`Document` c'en est la racine, `Element` c la liste de ceux ayant une mm balise, `Text` c le contenu textuel d'un.

BTW, elem et noeud c pareil.

```js
var elem = document.getElementById("id");
var couleur = elem.style.backgroundColor; //etc
var ls = document.getElementsByClassName("nom");
var ls = document.getElementsByTagName("tag"); // tag = balise
var elem = document.querySelector("sel"); // pr toucher du CSS
var ls = document.querySelectorAll("sel");
document.createElement("tag");
document.createTextNode(texte);
createElement("tag");
createTextNode("txt");
createAttribute("attr");
var frag = document.createDocumentFragment();
var txt = txt.splitText(offset); // offset c un entier

elem.appendChild(elem);
elem.insertBefore(nouv_elem, ref_elem);
elem.replaceChild(nouv_elem, ancien_elem);
elem.removeChild(elem);
var elem = elem.cloneNode(bool); // si true, c une deep copy
var val = elem.getAttribute(attr); // au cas où ce node a des attr qui eux-mm ont des vals
elem.setAttribute(attr, val);
elem.removeAttribute(attr);
var bool = elem.hasAttribute(attr);
var bool = hasChildNodes(elem);



elem.parentNode //élém
elem.childNodes //liste d'éléms
elem.firstChild
elem.lastChild
elem.previousSibling
elem.nextSibling
elem.nodeValue // "le node est la clé"
elem.nodeName
elem.nodeType
```

Exemple pr créer une matrice 3 $\times$ 3:
```js
var n, tr, i, td, txt                       // variables locales
   , table = document.createElement('table') // création de la table
 ;
 for ( n = 0; n < 3; n++ ) {                 // boucle sur les lignes
   tr = document.createElement('tr');        // création d'un élément tr
   for ( i = 0; i < 3; i++ ) {               // boucle sur les cellules
     td = document.createElement('td');      // création d'un élément td
     txt = document.createTextNode(1+i+n*3); // création d'un noeud texte
     td.appendChild(txt);                    // ajout du texte au contenu de la cellule
     tr.appendChild(td);                     // ajout de la cellule au contenu de la ligne
   }                                         // fin de la boucle sur les cellules
   table.appendChild(tr);                    // ajout de la ligne au contenu de la table
 }                                           // fin de la boucle sur les lignes
 p2.parentNode.insertBefore(table,p2);       // ajout de la table au contenu du document
```

### DOM HTML

Ca simplifie pas mal de truc par rapport au DOM Core

```js
var img = document.createElement('img');
img.setAttribute('src','logo.png'); // en DOM Core
img.src = "logo.png"; // pareil ms en DOM HTML

document.URL;
document.domain;
document.referrer;
document.lastModified;
document.cookie;
```

### DOM Events

```js
// <button onclick="fn(arg)"> Bonjour ! </button>
elem.addEventListener('click', ma_fn); // y a aussi 'mousedown', 'onmouseup', 'onmouseout', 'onmousemove'
// 'focus' qd gagne le focus, 'blur' qd perd le focus
// si y a un 3e arg valant true, alors on trigger aussi le parent, et ce, avant l'enfant
elem.removeEventListener('click');
elem.dispatchEvent('click'); // pr simuler que ça a eu lieu
// ma_fn prend 1 arg "Event e"
e.stopPropagation() // pr éviter de trigger l'enfant aussi
// y a des events "bouillonnants", ie. qui trigger le child avant le parent
var elem = e.target; // l'elem qui a trigger l'event
var elem = e.currentTarget; // ?
var bool = bubbles; // bouillonnant
var bool = cancelable; //
var fenetre = e.view; //
var truc = e.detail; // dépend du type d'event
// interface MouseEvent : longs entiers screenX, screenY, clientX, clientY, bools ctrlKey, shiftKey, altKey
// diverses interfaces InputEvent, KeyboardEvent
```

## Ajax

*Asynchronous Javascript And XML* (AJAX) mm si porte mal son nom aujd, déjà vu qu'aujd on est surtt JSON.

```js
var r = new XMLHttpRequest();
r.onload = function() {
    var reponse = this.responseText;
};
r.open("GET", "URL", true);
r.addEventListener("progress", e => {}) // pr une progressbar
// peut déclencher des events comme load, error, progress et abort
r.send();
r.status;
r.getResponseHeader();
```

Pr un `POST` :
```js
form.onsubmit = function(e) {
// empêche le remplacement de la page par la réponse du service
    e.preventDefault();
    let request = new XMLHttpRequest();
    request.onload = function() {}; // on traite la réponse
    query_string = [form[1],form[2]].map(f =>
        encodeURIComponent(f.name)+'='+encodeURIComponent(f.value)
    ).join('&');
    request.open("POST", "URL", true);
    request.setRequestHeader(
        'Content-Type', 'application/x-www-form-urlencoded');
    request.send(query_string);
}

```

### CORS

Sinon, giga faille2sécu : si on a un onglet où on est authentifié à un site, et un autre sur un site malveillant, il pourrait utiliser les cookies (c le lien avec Ajax) pr usurper mon identité et voler mes données.

C les fameux headers `Origin, Access-Control-Allow-Origin`.
Bref, le CORS c nécessaire pr faire fonctionner Ajax.
Dès qu'on ft autre chose que du GET, faut caser le OPTIONS avant.

## Autres APIs

### Audio

Avec `controls=false`, on le rend inivisible
```html
<audio src="chemin de fichier" controls="true"></audio>
<script>
    cet_élém.play();
    cet_élém.pause();
    cet_élém.paused; //c un bool
    cet_élém.currentTime = 0; // passe à un certain moment
    cet_élém.duration; // durée de l'audio
</script>
```

### Vidéo...

```html
<video>
```

### Canvas

```js
mon_canvas.height;
ctx = mon_canvas.getContext('2d');
ctx.fillStyle = 'orange';
ctx.fillRect(nbr, nbr, nbr, nbr);
```

### Polices open-source

Genre les Google Fonts

### Carte

Leaflet

## Node.js

* 2009
* côté serv
* pas multitâche : en vrai c une seule boucle ms avec entrées/sorties non-bloquantes

### Minimal server

```js
const http = require('http');
function handler(request, response) {
 response.writeHead(200, {'Content-Type': 'text/plain'});
 response.end("Yo");
}
const server = http.createServer(handler);

server.listen(3000);
console.log('Adresse : http://localhost:3000/');
```

### npm

```sh
npm install truc
```
Avec un flag `-g` pr une installation globale

### Repo du prof

* https://github.com/dmolinarius/demofiles/tree/master/elc-d3/cours4

### Lecture/écriture de fichier

```js
const fs = require('fs')

// lecture
const stream1 = fs.createReadStream('chemin');
stream1.setEncoding('utf-8');
stream1.on('data', function(data) {});

// écriture
const stream2 = fs.createWriteStream('./writestream.out');
stream2.write("str");
```

### http.createServer

* Ds la fn qu'on lui passe, 2 args :
    * request
    * response

### Module 'connect'

* ça a l'air pratique pr servir des fichiers statiques

```js
const connect = require('connect');
const static_pages = require('serve-static'); // npm install serve-static
const app = connect()
 .use(static_pages('htdocs')) // middleware de gestion de pages statiques
 .use((request,response) => { // middleware maison pour gestion 404
    response.writeHead(404, {
        'Content-Type': 'text/plain; charset=utf8'
    });
    response.end('Ah 404');
 })
;
app.listen(8080);
```

#### Basic auth

Bon tu sais que c pas très secure, ms faut caser ça là

#### Module 'express'

...

#### WebSockets avec 'socket.io

Côté serv
```js
var io = require('socket.io').listen(8080);
io.sockets.on('connection', function (socket) { // réception événément 'connection'
 socket.emit('hello', { 'this': 'is my data' }); // émission événement 'hello'
});

```

Côté client
```js
<script src="/socket.io/socket.io.js"></script>
<script>
    const socket = io.connect('http://localhost:3000');
    socket.on('mon_event', function (data) {
        // faire des trucs avec JSON.stringify(data)
    });
</script>
```

#### MySQL

```js
const connection = require('mysql').createConnection({
    host: 'localhost',
    user: 'user',
    password: 'password',
    database: 'database'
});
connection.query( 'SELECT * FROM `table`' , (err, results) => {
    console.log(results);
});

```