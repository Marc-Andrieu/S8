
function [imgprime] = MessageToImage(messageprime,N,M,d)

%
% Transformation d'un un signal binaire en une image couleur
% chaque pixel est cod� sur 8 bit
%
% entr�es : - messageprime : la sequence binaire
%           - N : nombre de lignes de l'image
%           - M : nombre de colonnes de l'image
%           - d : nombre de canaux de couleur (d=3)
%
% sortie : - imgprime : image cod�e en uint8 (valeur des pixels entre 0 et 255)
%

% conversion en uint8
imgsignalprime = uint8(bin2dec(reshape(num2str(messageprime),N*M*d,8)));

% conversion en image
imgprime = reshape(imgsignalprime,N,M,d);

