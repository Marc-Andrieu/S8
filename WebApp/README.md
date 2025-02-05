<script
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
  type="text/javascript">
</script>

# Applications Web

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
<
>
<=
>=
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

### Types

```js
undefined
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

### Variables

* Une var est *déclarée* si y a un `var` devant
* Les non-déclarées sont globales par défaut !
  * Donc à l'intérieur d'une fn, mets des `var` stp
```js
var x = 1; // déclarée et defined
var y; // déclarée ms undefined
z = 2; // non-déclarée et defined
```
* `let` : introduit en ES6, pr lim au bloc actuel la portée d'une var

### Vrac

```js
let
const
import
export
throw
```
