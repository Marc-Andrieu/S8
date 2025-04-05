%
% Ecole Centrale de Lyon
% module electif ELCF6 - Antennes, Signal et Processeurs
% 
% BE signal - Telecoms
%
% ModulationQPSK.m
%

clear all;
close all;
clc;

% parametres
%---------------------------------------------------------------------------%

nus = 1000;    % frequence d'echantillonnage (Hz)
fp = 100;      % frequence porteuse (Hz)
Db = 100;      % d�bit binaire (baud=1/sec)
A = 1;         % amplitude du signal

Ts = 1/nus;    % periode d'echantillonnage (sec)
iim = sqrt(-1);


% creation du message binaire � transmettre
%---------------------------------------------------------------------------%
imageaff = 1;
if(imageaff)
    filename = 'pikachu.jpg';
    [img] = imread(filename);
    figure, image(img);
    title('image �mise');
    m = ImageToMessage(img);
    Nbit = length(m);   % nombre de bit � transmettre
else
    Nbit = 100;   % nombre de bit � transmettre (multiple de 2 pour une modulation QPSK)
    m = randi([0 1],1,Nbit);
    figure,
    plot(m);
    ylim([-0.5 1.5]);
    title('message binaire initial');
end


% modulation QPSK
%---------------------------------------------------------------------------%

% creation de la sequence de symboles � transmettre (QPSK : 1 symbole = 2 bits)
Nsymb = Nbit/2; % nombre de symboles dans le message
msymbole = reshape(m,2,Nsymb); % sequence de symbole (matrice 2*Nsymb)

% creation de l'enveloppe complexe ux(t) du signal : modulation de phase
nphase = bin2dec(num2str(msymbole'))'; % transposition de {00,01,10,11} vers {0,1,2,3}
ux = A*exp(iim*2*pi*nphase/4+iim*pi/4);

% Mise en forme du signal ux(t) : �chantillonnage et d�bit symbole
Ds = Db/2;              % debit symbole (1/sec)
nrepet = floor(nus/Ds); % facteur de repetition
uxnus = reshape(ones(nrepet,1)*ux,1,Nsymb*nrepet); % chaque symbole est r�p�t� 'nrepet' fois

% creation du signal r�el x(t) � �mettre : modulation IQ
N = length(uxnus);
t = [0:N-1]*Ts;
x = real(uxnus).*cos(2*pi*fp*t)-imag(uxnus).*sin(2*pi*fp*t);


figure,
subplot(211),plot(t,real(uxnus),'b');
ylim([-1 1]*2*A);
xlabel('temps t');
ylabel('amplitude');
title('enveloppe complexe du signal �mis - composantes p et q');
subplot(212),plot(t,imag(uxnus),'b');
ylim([-1 1]*2*A);
xlabel('temps t');
ylabel('amplitude');
figure,
plot(ux,'*');
xlim([-1 1]*2*A);
ylim([-1 1]*2*A);
grid on;
xlabel('Re(ux)');
ylabel('Im(ux)');
title('constellation � l''�mission');
figure,
plot(t,x,'b');
ylim([-1 1]*2*A);
xlabel('temps t');
ylabel('amplitude');
title('signal �mis x(t)');
figure,
plot([-N/2:N/2-1]/N*nus,abs(fftshift(fft(x))));
xlabel('frequence nu');
ylabel('module');
title('spectre X(nu) du signal �mis');

% propagation
%---------------------------------------------------------------------------%
sigma2 = 0.0;
z = x+sqrt(sigma2)*randn(1,N);

figure,
plot(t,z,'b');
ylim([-1 1]*2*A);
xlabel('temps t');
ylabel('amplitude');
title('signal re�u z(t)');
figure,
plot([-N/2:N/2-1]/N*nus,abs(fftshift(fft(z))));
xlabel('frequence nu');
ylabel('module');
title('spectre Z(nu) du signal re�u');


% Demodulation QPSK
%---------------------------------------------------------------------------%

% r�cup�ration de l'enveloppe complexe (d�modulation IQ)
uznus = hilbert(z).*exp(-iim*2*pi*fp*t);

figure,
subplot(211),plot(t,real(uznus),'b');
ylim([-1 1]*2*A);
xlabel('temps t');
ylabel('amplitude');
title('enveloppe complexe uz(t) du signal re�u - phase et quadrature');
subplot(212),plot(t,imag(uznus),'b');
ylim([-1 1]*2*A);
xlabel('temps t');
ylabel('amplitude');

% sous-echantillonnage pour retour � la p�riode symbole
uz = uznus(nrepet/2:nrepet:end);

figure,
plot(uz,'*');
xlim([-1 1]*2*A);
ylim([-1 1]*2*A);
grid on;
xlabel('Re(uz)');
xlabel('Im(uz)');
title('constellation � la r�ception');

% decision : creation de nphaseprime � valeurs dans {0,1,2,3}
% � partir de uz, on veut retrouver nphaseprime = nphase
nphaseprime = 2 + floor(angle(-uz) * 2 / pi); % A completer

% retour � une sequence binaire mprime � partir de nphaseprime
mprime = str2num(reshape(dec2bin(nphaseprime)',2*Nsymb,1));

if(imageaff)
    [N,M,d] = size(img);
    [imgprime] = MessageToImage(mprime,N,M,d);
    figure,
    image(imgprime);
    title('image re�u');
else
    figure,
    plot(mprime);
    ylim([-0.5 1.5]);
    title('message binaire re�u');
end

figure,
subplot(221), image(img);
title('Image �mise');
subplot(222), image(imgprime);
title('Image re�ue');