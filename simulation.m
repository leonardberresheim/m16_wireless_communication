% radio communication system simluation script
% Leonard Berresheim - s0556126

clc, clear variables; % clear all variables
addpath('sunfunctions'); % add directory "subfunctions" to path

% global simulation parameters
ebN0dB = 0:30; % SNR (per bit) in dB
nBits = 10e3; % simulate nBits bits per simulation loop

constellation = [-1-1j, 1-1j, -1+1j, 1+1j]; % constellation of the
% modulation format, here: QPSK with gray mapping)

% here goes the simulation loop...
