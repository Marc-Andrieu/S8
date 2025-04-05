%
% Ecole Centrale de Lyon
% module electif ELCF6 - Antennes, Signal et Processeurs
% 
% BE signal - Telecoms
%
% ModemIQ : creation d'un signal r�el � partir d'un signal
% complexe (modulation IQ) et inversement (demodulation IQ)
%


clear all;
close all;
clc;

% param�tres
%---------------------------------------------------------------------------%

N = 1024;      % nombre d'�chantillons
nus = 10^3;    % fr�quence d'�chantillonnage (Hz)
fp = 50;       % fr�quence porteuse (Hz)

Ts = 1/nus;                 % periode d'�chantillonnage (sec)
t = [0:N-1]*Ts;             % vecteur des temps (sec)
nu = [-N/2:N/2-1]/N*nus;    % vecteur des fr�quences (Hz)
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


% Modulation IQ : creation du signal r�el x(t) � partir de p(t) et q(t)
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


% Demodulation IQ : calcul de l'enveloppe complexe ux(t) par rapport � la fr�quence porteuse fp
%---------------------------------------------------------------------------%

z = hilbert(x); % signal analytique
ux = z .* exp(-1i * 2 * pi * fp * t); % enveloppe complexe


% repr�sentation des parties r�elle et imaginaire de ux(t)
%---------------------------------------------------------------------------%

figure,
subplot(211), plot(t,real(ux));
axis tight;
ylim([-1 1]*1.5);
xlabel('temps t')
ylabel('amplitude');
title('Partie r�elle de $u_x$');
subplot(212), plot(t,imag(ux));
axis tight;
ylim([-1 1]*1.5);
xlabel('temps t')
ylabel('amplitude');
title('Partie imaginaire de $u_x$');


% repr�sentation de ux(t) dans le plan complexe
%---------------------------------------------------------------------------%

figure,
plot(imag(ux), real(ux), '.');
xlabel('Axe r�el')
ylabel('Axe imaginaire');
title('Repr�sentation de $u_x$ dans le plan complexe');




