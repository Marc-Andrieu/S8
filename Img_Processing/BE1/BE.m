% I
A = eye(3);
B = [3 2 4;
    1 2 8;
    6 1 5];
C = A + B;
D = B * 40;
%%
% II

% II.1
E = eye(300);
figure(1); imshow(E)
%%

% II.2
bat = imread("BATEAU.PGM");
bat;
figure(1); imshow(bat)

% De la comprssion avec perte
% Avantages : prend moins de place
% Inconvénient : perte d'information (irrév)

bateau = imread("BATEAU.JPG");
bateau;
figure(2); imshow(bateau)
%%
% III

% III.1

figure(3), imhist(bateau)

bs = imread("BATEAUSOMBRE.JPG");
bs;
figure(1); imshow(bs)
figure(2), imhist(bs)

equalized = histeq(bs, 255)
figure(1); imshow(equalized)

% Concl sur hist & égalisation : 
%%
% III.2
bruit = uint8(randi([0, 20], [256, 256]))
bb = bateau + bruit
figure(1); imshow(bb)
bts = bs + bruit
figure(1); imshow(bts)

% En zoomant sur les mm zones :
% Ressemble au bruit qd photo prise en faible luminosité

z = imnoise(bat, 'salt & pepper')
figure(1); imshow(z)

% Pk ça s'appelle "poivre & sel" : 
%%
% III.3

% sine4
sinus4 = imread("sine4.png")
figure(1); imshow(sinus4)

F4 = fft2(sinus4)
figure(1); imshow(abs(F4))

Fs4 = fftshift(F4)
figure(1); imshow(abs(Fs4))

log_Fs4 = log(1 + abs(Fs4))
figure(1); imshow(abs(log_Fs4))
imshow(log_Fs4, [])

% sine16
sinus16 = imread("sine16.png")
figure(1); imshow(sinus16)

F16 = fft2(sinus16)
figure(1); imshow(abs(F16))

Fs16 = fftshift(F16)
figure(1); imshow(abs(Fs16))

log_Fs16 = log(1 + abs(Fs16))
figure(1); imshow(abs(log_Fs16))
imshow(log_Fs16, [])

% Observation : on voit bien la fréquence du sinus
%%
% IV

merR = imread("mer-R.JPG")
figure(1); imshow(merR)
merG = imread("mer-V.JPG")
figure(1); imshow(merG)
merB = imread("mer-B.JPG")
figure(1); imshow(merB)

mer = cat(3, merR, merG, merB) % concat sur la "3ème" dimension
figure(1); imshow(mer)
%%
% V

bw = imread("BW.bmp")
figure(1); imshow(bw)
H = ones(3, 3) / 9

f0 = filter2(H, bw) % convoluer le 1e arg sur le second
uint8(f0)
figure(1); imshow(f0)
% Les valeurs c juste n * 255 / 9, donc 0, 28, 57, 85, 113, 142, 170, 198, 227, 255
% C un lissage : bah on a convolué avec une sorte de rectangle ie.
% multiplié en fréquence avec un sinus cardinal, c bien une sorte de
% passe-bas

figure(1); imshow(bateau)
f1 = uint8(filter2(H, bateau)) % convoluer le 1e arg sur le second
figure(2); imshow(f1)
% passe-bas, déjà dit

I = [1 1 1;
    1 9 1;
    1 1 1] / 9
f2 = uint8(filter2(I, bateau)) % convoluer le 1e arg sur le second
figure(3); imshow(f2)
% I un peu + en cloche, du coup sa TF aussi, donc passe-bas

batgauss = imgaussfilt(bateau)
figure(1); imshow(batgauss)
batsob = edge(bateau, 'sobel')
figure(1); imshow(batsob)
batcanny = edge(bateau, 'canny')
figure(1); imshow(batcanny)
%%
% VI

% VI.1
A = [10 2 9;
    4 18 14;
    22 7 25]
figure(1); imshow(A)
B = imresize(A, [6, 6], 'nearest') % méthode nearest neighbor
figure(1); imshow(B)
C = uint8(imresize(A, [6, 6], 'bilinear')) % méthode bilinéaire (combi liné des 4 px voisins)
figure(1); imshow(C)
D = uint8(imresize(A, [6, 6], 'bicubic')) % méthode bicubique (combi liné des 16 px voisins)
figure(1); imshow(D)
%%
% VI.2
figure(1); imshow(bat)
B = imresize(bat, [600, 600], 'nearest') % méthode nearest neighbor
figure(1); imshow(B) % purement agrandie
C = uint8(imresize(bat, [600, 600], 'bilinear')) % méthode bilinéaire (combi liné des 4 px voisins)
figure(1); imshow(C) % un peu + floue
D = uint8(imresize(bat, [600, 600], 'bicubic')) % méthode bicubique (combi liné des 16 px voisins)
figure(1); imshow(D) % encore un peu + floue