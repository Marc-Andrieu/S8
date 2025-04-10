% A : Img filtering

%{

Bouts de code utiles

bat = imread("BATEAU.PGM");
bat;

figure(1); imshow(bat)
figure(1); imshow(img2)

ma_fft = abs(fftshift(fft2(img)))
normalise = ma_fft ./ max(ma_fft)

%}

% Exo 1 : 2D FT

% Q0

moon = imread("Fig_Moon.tif");
woman = imread("Fig_woman.tif");
xray = imread("Fig_XRAY.tif");
moon = moon(:, :, 1);
woman = woman(:, :, 1);
xray = xray(:, :, 1);

moon_fft = abs(fftshift(fft2(moon)));
woman_fft = abs(fftshift(fft2(woman)));
xray_fft = abs(fftshift(fft2(xray)));
mon_fft_normalise = moon_fft ./ max(moon_fft);

% Q1

figure(1)
subplot(2, 2, 1)
imshow(moon, [])
title("Original")

subplot(2, 2, 2)
imshow(moon_fft, [])
title("FFT naïf")

subplot(2, 2, 3)
imshow(mon_fft_normalise, [])
title("FFT normalisé")

subplot(2, 2, 4)
imshow(log(1 + mon_fft_normalise), [])
title("FFT normalisé + log")

% Q2

%{
Effectivement l'axe quasi-vertical est logique
* Y a peut de vartiation verticale (sur la face éclaire (resp.
non-éclairée), ça reste clair (resp. noir)
verticalement
* Horizontalement, on passe d'une face éclairée à une non-éclairée, y a bcp
de variation, c logique de voir ça reproduit sur la FFT
%}

% Exo 2 : abs(fftshift(fft2(moon)))

% Q1

% woman

woman_fft = fftshift(fft2(woman));

woman_mag_only = abs(ifft2(abs(woman_fft)));
woman_mag_only = woman_mag_only ./ max(woman_mag_only);

woman_phase_only = abs(ifft2(woman_fft ./ abs(woman_fft)));
woman_phase_only = woman_phase_only ./ max(woman_phase_only);

figure(2)
subplot(2, 2, 1)
imshow(woman, [])
title("Original")

subplot(2, 2, 2)
imshow(woman_mag_only, [])
title("Magnitude only")

subplot(2, 2, 3)
imshow(woman, [])
title("Original")

subplot(2, 2, 4)
imshow(woman_phase_only, [])
title("Phase only")

% Barre 500

barre500 = imread("Fig_Barre500.tif");
barre500 = barre500(:, :, 1);

barre500_fft = fftshift(fft2(barre500));

barre500_mag_only = abs(ifft2(abs(barre500_fft)));
barre500_mag_only = barre500_mag_only ./ max(barre500_mag_only);

barre500_phase_only = abs(ifft2(barre500_fft ./ abs(barre500_fft)));
barre500_phase_only(isnan(barre500_phase_only)) = 0;
barre500_phase_only = barre500_phase_only / max(barre500_phase_only);

figure(3)
subplot(2, 2, 1)
imshow(barre500, [])
title("Original")

subplot(2, 2, 2)
imshow(barre500_mag_only, [])
title("Magnitude only")

subplot(2, 2, 3)
imshow(barre500, [])
title("Original")

subplot(2, 2, 4)
imshow(barre500_phase_only, [])
title("Phase only")

% Q2

woman_mag = abs(woman_fft);
barre500_mag = abs(barre500_fft);

woman_phase = woman_fft ./ abs(woman_fft);
woman_phase(isnan(woman_phase)) = 0;
barre500_phase = abs(barre500_fft);
barre500_phase(isnan(barre500_phase)) = 0;

woman_mag_barre500_phase = abs(ifft2(woman_mag .* barre500_phase));
barre500_mag_woman_phase = abs(ifft2(barre500_mag .* woman_phase));

figure(2)
subplot(2, 2, 1)
imshow(woman, [])
title("Original")

subplot(2, 2, 2)
imshow(woman_mag_barre500_phase, [])
title("woman mag, barre500 phase")

subplot(2, 2, 3)
imshow(barre500, [])
title("Original")

subplot(2, 2, 4)
imshow(barre500_mag_woman_phase, [])
title("barre500 mag, woman phase")

% Q3

%{
On dirait vrmt que la phase contient la majorité de l'info sur la forme....
%}

% Exo 3

%{
H = lpfilter(type, M, N, D0, n)
H c en fréq
type = 'gaussian', 'ideal' ou 'btw' (Butterworth)
M, N : dimensions
D0 : fréquence de coupure
n : ordre pr les Butterworth
%}

% Q0

% ftype=’gaussian’, D0=50



% ftype=’ideal’, D0=50



% ftype=’ideal’, D0=50


