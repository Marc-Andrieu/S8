
%
% Ecole Centrale de Lyon
% module electif ELCF6 - Antennes, Signal et Processeurs
% 
% BE signal - Radar
%
% TestRadar1 : estimation de position et de vitesse
%

clear all;
close all;
clc;


% Paramètres
%---------------------------------------------------------------------------------------------%

nus = 10^(3);   % frequence d'échantillonnage (Hz)
N = 1000;       % taille du signal émis (echantillons)
Ex = 1;         % energie du signal emis x(t)
nup = 200;      % frequence porteuse (Hz)

Ts = 1/nus;     % periode d'échantillonnage (sec)
T = N*Ts;       % duree du signal emis (sec)
t = [0:N-1]*Ts; % vecteur des temps (sec)

iim = sqrt(-1); % i imaginaire

% signal émis
%---------------------------------------------------------------------------------------------%

signal = 1;     % type de signal (1, 2, 3 ou 4)

% création de l'enveloppe complexe ux du signal x
switch signal
    
case 1 % signal 1 : sinusoide fenetree
w = hanning(N)';   % fenetre de ponderation
ux = w;

case 2 % signal 2 : sinusoide modulée par un sinc et fenetree
Tc = 1/40;         % periode du sinus cardinal (sec)
w = hanning(N)';   % fenetre de ponderation
ux = w.*sinc((t-T/2)/Tc);

case 3 % signal 3 : modulation linéaire de fréquence (LFM - Chirp linéaire)
numin = -20;            % fréquence min du signal (Hz)
numax = 20;             % fréquence max du signal (Hz)
w = tukeywin(N,0.3)';   % fenetre de ponderation
phi = 2*pi*((numax-numin)/(2*T)*(t.^2)+numin*t);  % phase instantanée du signal
ux = w.*exp(iim*phi);

case 4 % signal 4 : modulation hyperbolique de Fréquence (Chirp hyperbolique)
numin = -20;            % fréquence min du signal (Hz)
numax = 20;             % fréquence max du signal (Hz)
w = tukeywin(N,0.3)';   % fenetre de ponderation
phi = 2*pi*((numax-numin)/(3*T^2)*(t.^3)+numin*t); % phase instantanée du signal
ux = w.*exp(iim*phi);

end

% création du signal x à partir de son enveloppe complexe ux
x = real(ux).*cos(2*pi*nup*t)-imag(ux).*sin(2*pi*nup*t);
x = sqrt(Ex)*x/sqrt(sum(abs(x).^2)); % normalisation energie


% signal reçu
%---------------------------------------------------------------------------------------------%

% paramètres du milieu
c = 3*10^2;         % vitesse de propagation de l'onde (m/sec)
alpha = 1;          % attenuation
psi = 2*pi*rand;    % déphasage aléatoire (rad)
sigma2 = 0.01;      % variance du bruit additif blanc gaussien

% paramètres de la cible
r = 100;            % distance de la cible (m)
v = -10;            % vitesse radiale de la cible (m/sec)
deltat = 2*r/c;     % décalage temporel associé (retard)
deltaf = 2*nup*v/c; % decalage frequentiel associé (doppler)

% extension du signal émis pour prendre en compte le temps de propagation (x et y auront la même taille)
Ndeltat = (round(deltat/Ts));
N0 = N;
N = 2^nextpow2(N+2*Ndeltat);
x = [x,zeros(1,N-N0)];
N = length(x);
t = [0:N-1]*Ts;

% signal reçu : atténuation + déphasage + décalage temporel + décalage fréquentiel + bruit
y = real(alpha*exp(iim*psi)*hilbert(circshift(x,[1 Ndeltat])).*exp(iim*2*pi*deltaf*t)) + sqrt(sigma2)*randn(1,N);

figure,
subplot(211), plot(t,x);
xlabel('temps (sec)');
ylabel('amplitude');
title('signal emis x(t)');
subplot(212), plot(t,y);
xlabel('temps (sec)');
ylabel('amplitude');
title('signal reçu y(t)');

nu = [-N/2:N/2-1]/N*nus;
X = fftshift(fft(x));
Y = fftshift(fft(y));

figure,
subplot(211), plot(nu,abs(X));
xlabel('frequence (Hz)');
ylabel('module');
title('spectre du signal emis');
subplot(212), plot(nu,abs(Y));
xlabel('frequence (Hz)');
ylabel('module');
title('spectre du signal reçu');


% traitements radar
%---------------------------------------------------------------------------------------------%

%
% (Question 2) a- recuperation des enveloppes complexes par rapport à nup
%

z = hilbert(x); % signal analytique
ux = z .* exp(-1i * 2 * pi * nup * t); % enveloppe complexe

%
% (Question 3) b- recepteur optimal pour une estimation conjointe de position et de vitesse
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
% (Question 4) - estimation de la position et de la vitesse
%

position_optimale = temps_optimal * c / 2
vitesse_optimale = freq_optimale * c / 2 / nup




