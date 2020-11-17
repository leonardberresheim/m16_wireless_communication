% radio communication system simluation script
% Leonard Berresheim - s0556126

clc, clear variables; % clear all variables
addpath('subfunctions'); % add directory "subfunctions" to path

% global simulation parameters
ebN0dB = 0:30; % SNR (per bit) in dB
nBits = 10 %10e3; % simulate nBits bits per simulation loop

constellation = [-1-1j, 1-1j, -1+1j, 1+1j]; % constellation of the
% modulation format, here: QPSK with gray mapping)

% here goes the simulation loop...

% generate Bit-sequence

bits = generateBits(nBits);

x = mapper(bits, constellation);

x_d = decision(x, constellation);

y = demapper(x_d,constellation);

[nErr,ber] = countErrors(y,bits);
fprintf("Anzahl der Fehler: " + nErr + "\n");
fprintf("Fehlerverhältnis: " + ber*100 + "%%\n");