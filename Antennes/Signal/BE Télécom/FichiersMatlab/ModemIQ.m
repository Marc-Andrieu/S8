%
% Ecole Centrale de Lyon
% module electif ELCF6 - Antennes, Signal et Processeurs
% 
% BE signal - Telecoms
%
% ModemIQ : creation d'un signal réel à partir d'un signal
% complexe (modulation IQ) et inversement (demodulation IQ)
%


clear all;
close all;
clc;

% paramètres
%---------------------------------------------------------------------------%

N = 1024;      % nombre d'échantillons
nus = 10^3;    % fréquence d'échantillonnage (Hz)
fp = 50;       % fréquence porteuse (Hz)

Ts = 1/nus;                 % periode d'échantillonnage (sec)
t = [0:N-1]*Ts;             % vecteur des temps (sec)
nu = [-N/2:N/2-1]/N*nus;    % vecteur des fréquences (Hz)
iim = sqrt(-1);

% creation des signaux p(t) et q(t)
%---------------------------------------------------------------------------%
p = [ones(1,N/2) -ones(1,N/2)];
q = [ones(1,N/4) -ones(1,N/4) ones(1,N/4) -ones(1,N/4)];

figure,
subplot(211), plot(t,p);
axis tight;
ylim([-1 1]*1.5);
xlabel('temps t')
ylabel('amplitude');
title('composante p');
subplot(212), plot(t,q);
axis tight;
ylim([-1 1]*1.5);
xlabel('temps t')
ylabel('amplitude');
title('composante q');


% Modulation IQ : creation du signal réel x(t) à partir de p(t) et q(t)
%---------------------------------------------------------------------------%
x = p.*cos(2*pi*fp*t) - q.*sin(2*pi*fp*t);
X = fftshift(fft(x));

figure,
plot(t,x);
axis tight;
ylim([-1 1]*2);
xlabel('temps t')
ylabel('amplitude');
title('signal x');
figure,
plot(nu,abs(X));
xlabel('frequence \nu')
ylabel('module');
title('spectre X');


% Demodulation IQ : calcul de l'enveloppe complexe ux(t) par rapport à la fréquence porteuse fp
%---------------------------------------------------------------------------%

z = hilbert(x); % signal analytique
ux = z .* exp(-1i * 2 * pi * fp * t); % enveloppe complexe


% représentation des parties réelle et imaginaire de ux(t)
%---------------------------------------------------------------------------%

figure,
subplot(211), plot(t,real(ux));
axis tight;
ylim([-1 1]*1.5);
xlabel('temps t')
ylabel('amplitude');
title('Partie réelle de $u_x$');
subplot(212), plot(t,imag(ux));
axis tight;
ylim([-1 1]*1.5);
xlabel('temps t')
ylabel('amplitude');
title('Partie imaginaire de $u_x$');


% représentation de ux(t) dans le plan complexe
%---------------------------------------------------------------------------%

figure,
plot(imag(ux), real(ux), '.');
xlabel('Axe réel')
ylabel('Axe imaginaire');
title('Représentation de $u_x$ dans le plan complexe');




