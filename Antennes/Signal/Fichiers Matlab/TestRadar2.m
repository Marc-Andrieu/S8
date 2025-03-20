
%
% Ecole Centrale de Lyon
% module electif ELCF6 - Antennes, Signal et Processeurs
% 
% BE signal - Radar
%
% TestRadar2 : estimation conjointe de position et de vitesse sur signal inconnu
%

clear all;
close all;
clc;


% Paramètres
%---------------------------------------------------------------------------------------------%

load xyinconnu2
% x = signal émis
% y = signal reçu
% Ts = periode d'échantillonnage
% nup = frequence porteuse

nus = 1/Ts;         % frequence d'échantillonnage (Hz)
N = length(x);      % taille des signaux (echantillons)
t = [0:N-1]*Ts;     % vecteur des temps (sec)
c = 3*10^2;         % vitesse de propagation de l'onde (m/sec)
iim = sqrt(-1);     % i imaginaire


% Signaux émis et reçu 
%---------------------------------------------------------------------------------------------%

figure,
subplot(211), plot(t,x);
xlim([0 t(end)]);
xlabel('temps (sec)');
ylabel('amplitude');
title('signal émis');
subplot(212), plot(t,y);
xlim([0 t(end)]);
xlabel('temps (sec)');
ylabel('amplitude');
title('signal reçu');

nu = [-N/2:N/2-1]/N*nus;
X = fftshift(fft(x));
Y = fftshift(fft(y));

figure,
subplot(211), plot(nu,abs(X));
xlabel('frequence (Hz)');
ylabel('module');
title('spectre du signal émis');
subplot(212), plot(nu,abs(Y));
xlabel('frequence (Hz)');
ylabel('module');
title('spectre du signal reçu');


% Traitements radar - estimation de position et de vitesse
%---------------------------------------------------------------------------------------------%

%
% a- recuperation de l'enveloppe complexe
%

% a completer


%
% b- recepteur optimal pour une estimation conjointe de position et de vitesse
%

fmin = -50;         % decalage frequentiel min (Hz)
fmax = 50;          % decalage frequentiel max (Hz)
df = 0.2;           % pas frequentiel du vecteur des decalages frequentiels (Hz)
f = [fmin:df:fmax]; % vecteur des decalages frequentiels (Hz)
Nf = length(f);     % nombre de decalages frequentiels


A = zeros(2*N-1, Nf);
for iff = 1:Nf
    x_decale = x .* exp(iim * 2 * pi * f(iff) * t);       % decalage frequentiel du x émis
    A(:,iff) = transpose(xcorr(x_decale, y));    % autocorrelation temporelle entre le y reçu et x_décalé
end

tau = [-N:N-1]*Ts;

B = abs(A).^2;
[vecteur_valeurs, indices_lignes] = max(B); 
[valeur, index_colonne] = max(vecteur_valeurs); % index_colonne sur 500
index_ligne = indices_lignes(index_colonne); % sur 9000
temps_optimal = tau(index_ligne)
freq_optimale = f(index_colonne)


%
% c - estimation de la position et de la vitesse
%

position_optimale = temps_optimal * c / 2
vitesse_optimale = freq_optimale * c / 2 / nup

