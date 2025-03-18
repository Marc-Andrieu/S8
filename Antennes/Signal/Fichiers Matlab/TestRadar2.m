
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

% a completer


%
% c - estimation de la position et de la vitesse
%

% a completer

