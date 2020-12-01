% radio communication system simluation script
% Leonard Berresheim - s0556126

clc, clear variables; % clear all variables
addpath('subfunctions'); % add directory "subfunctions" to path

% global simulation parameters
ebN0dB = 0:30; % SNR (per bit) in dB
nBits = 10e3; %10e3; % simulate nBits bits per simulation loop

constellation = [-1-1j, 1-1j, -1+1j, 1+1j]; % constellation of the
% modulation format, here: QPSK with gray mapping)
M = length(constellation);% Number of constellation Symbols

% here goes the simulation loop...

% generate Bit-sequence

bits = generateBits(nBits);

x = mapper(bits, constellation);

%% Hinzufügen eines additiven weißen gaußverteiltem Rauschen
% Es werden verschiedene SNR werde getestet.
%SNR = 0:11;
% Rauschen hinzufügen mit jeweiliger SNR
x_n = add_awgn(x,ebN0dB,M);


x_d = decision(x_n, constellation);

y = demapper(x_d,constellation);

[nErr,ber] = countErrors(y,bits);
% Numerische Berechnuns
P_AWGN = 0.5*erfc(sqrt(ebN0dB));

semilogy(ebN0dB, ber, ebN0dB, P_AWGN, "-o");


%fprintf("Anzahl der Fehler: " + nErr + "\n");
%fprintf("Fehlerverhältnis: " + ber*100 + "%%\n");