%
% Ecole Centrale de Lyon
% module electif ELCF6 - Antennes, Signal et Processeurs
% 
% BE signal - Telecoms
%
% TEB_MPSK.m
%

clear all;
close all;
clc;

% parametres
%---------------------------------------------------------------------------%

nus = 1000;    % frequence d'echantillonnage (Hz)
fp = 100;      % frequence porteuse (Hz)
Db = 100;      % débit binaire (baud=1/sec)
A = 1;         % amplitude du signal

Ts = 1/nus;    % periode d'echantillonnage (sec)
iim = sqrt(-1);


% creation du message binaire à transmettre
%---------------------------------------------------------------------------%
imageaff = 0;
if(imageaff)
    filename = 'pikachu.jpg';
    [img] = imread(filename);
    %figure, image(img);
    %title('image émise');
    m = ImageToMessage(img);
    Nbit = length(m);   % nombre de bit à transmettre
else
    Nbit = 39996;   % nombre de bit à transmettre (multiple de "puissance" pour une modulation MPSK, donc de 2, 3 et 4 ici)
    m = randi([0 1],1,Nbit);
end

%figure,
for puissance=2:4
    % modulation MPSK
    %---------------------------------------------------------------------------%
    M = 2 ^ puissance;
    
    % creation de la sequence de symboles à transmettre (MPSK : 1 symbole = "puissance" bits)
    Nsymb = Nbit / puissance; % nombre de symboles dans le message
    msymbole = reshape(m,puissance,Nsymb); % sequence de symbole (matrice 2*Nsymb)
    
    % creation de l'enveloppe complexe ux(t) du signal : modulation de phase
    nphase = bin2dec(num2str(msymbole'))'; % transposition de {00,01,10,11} vers {0,1,2,3}
    ux = A*exp(iim*2*pi*nphase/M+iim*pi/M);
    
    % Mise en forme du signal ux(t) : échantillonnage et débit symbole
    Ds = Db/puissance;              % debit symbole (1/sec)
    nrepet = floor(nus/Ds); % facteur de repetition
    uxnus = reshape(ones(nrepet,1)*ux,1,Nsymb*nrepet); % chaque symbole est répété 'nrepet' fois
    
    % creation du signal réel x(t) à émettre : modulation IQ
    N = length(uxnus);
    t = [0:N-1]*Ts;
    x = real(uxnus).*cos(2*pi*fp*t)-imag(uxnus).*sin(2*pi*fp*t);

    %figure,
    switch puissance
        case 2
            subplot(3,1,1)
        case 3
            subplot(3,1,2)
        case 4
            subplot(3,1,3)
    end
    plot([-N/2:N/2-1]/N*nus,abs(fftshift(fft(x))));
    xlabel('frequence nu');
    ylabel('module');
    title(num2str(M));

    % propagation et calcul du TEB
    %---------------------------------------------------------------------------%
    NbPoints = 60;
    sigma2 = linspace(0.01,4,NbPoints);
    TEB = zeros(1,NbPoints);  
    
    for i=1:NbPoints
        z = x + sqrt(sigma2(i)) * randn(1, N);
    
        uznus = hilbert(z) .* exp(-iim*2*pi*fp*t);
        uz = uznus(nrepet/2:nrepet:end);
    
        nphaseprime = M/2 + floor(angle(-uz) * M / (2 * pi));
    
        mprime = str2num(reshape(dec2bin(nphaseprime)', puissance * Nsymb, 1))';  
    
        % calcul du TEB
        TEB(i) = sum(m ~= mprime) / Nbit;  
    end
    
    % affichage du TEB en fonction de sigma2
    
    %plot(sigma2, TEB, 'o','LineWidth',1.5);
    %hold on
end
%{
xlabel('\sigma^2');
ylabel('Taux d''Erreur Binaire (TEB)');
title('TEB en fonction de la puissance du bruit \sigma^2');
legend({'M = 4', 'M = 8', 'M = 16'})
grid on;
hold off
%}