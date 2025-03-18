%{

The objective of this session is to apply the DCT transformation to compress images.
Then, to proceed to the decompression, by applying the inverse transformation.
And finally, to calculate the error between the starting image and the images after decompression for quantization factors ranging from 1 to 25.
For each quantization factor, the compression performed will be calculated by noting the number of different DCT coefficients from zero.
The stages of compression are as follows:
* Reading a bitmap image
* Recovery of the matrix of RGB coefficients
* Calculation of the DCT coefficients of the matrix by blocks of 8x8 pixels
* Quantize
* Writing DCT coefficients to a file
For decompression, simply reverse the previous steps. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [duree_traitement] = main_compression(qualite, nom_source_bmp, nom_destination_jpg)
    function [imageRGBdouble] = lecture_image_bmp(nom_fichier)
    function [M] = conversion_spatial_frequantiel(matrice, qualite)
        function [res] = ajoute(m,valeur)
        function [Q] = mat_quant(Fq)
    function [] = ecriture_jpg(JPG, nom, qualite)
function [duree_traitement] = main_decompression(nom_destination_jpg , nom_source_bmp)
    function [JPG,qualite] = lecture_jpg(nom)
    function [M] = conversion_frequentiel_spatial(matrice, qualite)
        function [res] = ajoute(m,valeur)
        function [Q] = mat_quant(Fq)
        function [a] = m_IDCT2(m)
    function [] = ecriture_bmp(BMP, nom) 

%}

% 1. From the lecture and also the code review, explain how image compression works.

%{
Plusieurs étapes :
* YCbCr (Luminance, Composante bleue, Composante Rouge) : l'oeil humain est
bcp + sensible aux formes (luminance) qu'aux couleurs (chrominances),
surtout le vert, donc on compresse la chrominance avec pertes
* DCT (Discrete Cosinus Transform) : une TF ms réelle (possible, c sur un
intervalle), et en 2D
* Quantification : c de la division euclidienne element-wise, donc avec
pertes
* Zigzag encoding : faut bien transformer l'image (2D) en un vecteur (1D)
pr le stockage et la transmission
* Codage de source (compression) au choix :
    * VLC (Variable-length coding) : entropy-based, du Huffmann (on utilise les fréquences au sens de "à quel point ce symbole est souvent utilisé ?")
    * RLC (Run-length coding) : redundancy-based, qd on a "aaaa" on met un "#4a" 
%}

% 2. Calculate the difference between a bitmap image before compression and after decompression
% for quantization factors ranging from 1 to 25.

duree_compr = zeros(1, 25);
duree_decompr = zeros(1, 25);
err = zeros(1, 25);

original = lecture_image_bmp("Nature.bmp");
original(1:3, :, :) = [];
for q = 1:25
    q
    duree_compr(q) = main_compression(q, "Nature.bmp", "Nature_compressee.jpg");
    duree_decompr(q) = main_decompression("Nature_compressee.jpg", "Nature_decompressee.bmp");
    decompr = lecture_image_bmp("Nature_decompressee.bmp");
    size(original)
    size(decompr)
    err(q) = sum((original - decompr) .^ 2, "all");
end

figure(1)
plot(duree_compr)
figure(2)
plot(duree_decompr)
figure(3)
plot(err)

duree_compr
duree_decompr
err

% 3. For each quantization factor, calculate the number of non-zero DCT coefficients.



% 4. Plot the error curves (mean and standard), as well as the compression rates, as a function of
% the quantization factor.


