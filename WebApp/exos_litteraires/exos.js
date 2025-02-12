var text = main.textContent;
console.log(text)
total.innerHTML = text.length;
normal.innerHTML = text.replace(/\n/g, '').length; // ou avcec getElementByTagName
var ponct = 0, esp = 0, lettr = 0, cons = 0, voy = 0;
for (let i = 0; i < text.length; i++) {
    char = text[i]
    if ([".", ","].includes(char)) ponct++;
    if ([" "].includes(char)) esp++;
    if(char.match("[a-zA-Z]")) {
        lettr++;
        if (["a", "e", "i", "o", "u", "y", "A", "E", "I", "O", "U", "Y"].includes(char)) {
            voy++;
        } else cons++;
    };
}
ponctuation.innerHTML = ponct;
espaces.innerHTML = esp;
lettres.innerHTML = lettr;
voyelles.innerHTML = voy;
consonnes.innerHTML = cons;

