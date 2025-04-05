
%
% Ecole Centrale de Lyon
% module electif ELCF6 - Antennes, Signal et Processeurs
% 
% BE signal - Radar
%
% FonctionAmbiguite : calcul et tracé de la fonction d'ambiguité de
% différents signaux
%

clear all;
%close all;
clc;

% paramètres
%---------------------------------------------------------------------------%

N = 1000;       % nombre d'echantillons du signal
nus = 10^3;     % fréquence d'echantillonnage (Hz)
Ex = 1;         % energie du signal x

Ts = 1/nus;                 % periode d'echantillonnage (sec)
t = [0:N-1]*Ts;             % vecteur des temps (sec)
nu = [-N/2:N/2-1]/N*nus;    % vecteur des frequences (Hz)
T = N*Ts;                   % duree du signal (sec)

fmin = -50;         % decalage frequentiel min (Hz)
fmax = 50;          % decalage frequentiel max (Hz)
df = 0.2;           % pas frequentiel du vecteur des decalages frequentiels (Hz)
f = [fmin:df:fmax]; % vecteur des decalages frequentiels (Hz)
Nf = length(f);     % nombre de decalages frequentiels
rsousech = 2;       % facteur de sous-echantillonnage pour une visualisation rapide de la fonction d'ambiguite

iim = sqrt(-1);     % i imaginaire


% creation du signal x(t)
%---------------------------------------------------------------------------%

signal = 1;     % choix du signal (1, 2, 3 ou 4)

switch signal
    
case 1 % signal 1 : sinusoide
nu0 = 150;          % frequence centrale (Hz)
w = hanning(N)';    % fenetre de ponderation
x = w.*exp(iim*2*pi*nu0*t);

case 2 % signal 2 : sinusoide modulee par un sinc
nu0 = 150;           % frequence centrale (Hz)
Tc = 1/40;           % periode du sinus cardinal (sec)
w = hanning(N)';     % fenetre de ponderation
x = w.*sinc((t-T/2)/Tc).*exp(iim*2*pi*nu0*t);

case 3 % signal 3 : modulation linéaire de fréquence (MLF - Chirp linéaire)
numin = 125;            % fréquence min du signal (Hz)
numax = 175;            % fréquence max du signal (Hz)
w = tukeywin(N,0.3)';   % fenetre de ponderation
phi = 2*pi*(numax-numin)/(2*T)*(t.^2) + 2*pi*numin*t;  % phase instantanée du signal
x = w.*exp(iim*phi);

case 4 % signal 4 : modulation hyperbolique de Fréquence (Chirp hyperbolique)
numin = 125;            % fréquence min du signal (Hz)
numax = 175;            % fréquence max du signal (Hz)
w = tukeywin(N,0.3)';   % fenetre de ponderation
phi = 2*pi*((numax-numin)/(3*T^2)*(t.^3)+numin*t); % phase instantanée du signal
x = w.*exp(iim*phi);

end

x = sqrt(Ex)*x/sqrt(sum(abs(x).^2)); % normalisation du signal en energie
X = fftshift(fft(x)/N);     % calcul du spectre

figure,
subplot(221), plot(t,real(x));
axis tight; grid on;
xlim([0 T]);
xlabel('temps (sec)');
ylabel('amplitude');
title(['signal ',num2str(signal)]);
subplot(223), plot(nu,abs(X));
axis tight; grid on;
xlim([-1 1]*nus/2);
xlabel('frequence (Hz)');
ylabel('module');
title(['spectre du signal ',num2str(signal)]);


% calcul de la fonction d'ambiguité A(tau,f) du signal x
%---------------------------------------------------------------------------%

A = zeros(2*N-1,Nf);
for iff = 1:Nf
    y = x.*exp(iim*2*pi*f(iff)*t);       % decalage frequentiel
    A(:,iff) = transpose(xcorr(x,y));    % autocorrelation temporelle
end

A = A(1:rsousech:end,:);        % sous-echantillonnage pour un affichage rapide
tau = [-(N/rsousech):N/rsousech-1]*Ts*rsousech; % vecteur des decalages temporels sous-echantillonnés (sec)

subplot(2,2,[2 4])
mesh(f,tau,abs(A).^2);
axis tight; grid on;
ylim([-1 1]*T);
ylabel('decalage temporel (sec)');
xlabel('decalage frequentiel (Hz)');
zlabel('|A(\tau,f)|.^2');
title(['fonction d''ambiguite du signal ',num2str(signal)]);


