% Dieser Code wurde entnommen von der Moodle-Seite zum Kurs M16

function [constellation, berTheoAWGN, berTheoFading, M] = DK16PCUe_ModFormats(ModFormat)
% [constellation, berTheoAWGN, berTheoFading, M] = DK16PCUe_ModFormats(ModFormat)
%
% Defines some common modulation constellations (using Gray-coding where possible) for use in mapper(), decistion(), demapper()
% How to use: Call this function at the initial setup section of your simulation.m script
%
% It expects a string parameter "ModFormat", taken from the set of possible modulation formats:
% {'bpsk'='qam2'='psk2', 'qpsk'='qam4'='psk4', 'qam8', 'psk8', 'qam16', 'psk16', 'qam32', 'qam64' ,'qam256'}
%
% The function returns a vector "constellation" of (generally) complex numbers (i.e., constellation points). 
% The position (as decimal number starting from 1) of each constellation point within that vector corresponds
% to the bit pattern (in binary coding) mapped to the given constellation point
%
% The function also returns two handles anonymous functions, which give theoretical BERs vs. SNR for the selected modulation format:
% berTheoAWGN  (SNR,M) is the theoretical BER-vs-SNR for the AWGN-channel (Additive White Gaussian Noise)
% berTheoFading(SNR,M,K) is the theoretical BER-vs-SNR for the Rayleigh (K=0) and Rician (K>0) fading channel
% SNR: SNR per symbol in linear units (not dB)
% K: K-factor as defined for Rician fading channel (see M16DK lecture slides)
% note: for 8-QAM and 32-QAM, no theretical formulas  are given for the Rayleigh/Rician channels(returned BER=0.5)
% 
% Example for 16-QAM BER-vs-OSNR plots:
%   ModFormat = 'QAM16'; %(upper or lower case doesn't matter)
%   [constellation, berTheoAWGN, berTheoFading, M] = DK16PCUe_ModFormats(ModFormat);
%   snr_dB = [0:20]; % in dB
%   snr_lin = 10.^(snr_dB/10); % linear snr
%   BER_AWGN = berTheoAWGN(snr_lin,M); %for SNR = 1...20 dB
%   BER_RAYL = berTheoFading(snr_lin,M,0); %for SNR = 1...20 dB and Rayleigh fading channel (K=0)
%   BER_RICE = berTheoFading(snr_lin,M,4); %for SNR = 1...20 dB and Rician fading channel (K=4)
%   figure(123), clf
%   semilogy(snr_dB,BER_AWGN,'^-', snr_dB,BER_RAYL,'o-', snr_dB,BER_RICE,'*-','Linewidth',1);
%   xlabel('SNR (dB)'); ylabel('BER'); legend('AWGN','Rayleigh','Rice (K=2)'); grid on
%
% see also Matlab-functions qammod() and pskmod() in communications toolbox for furtger information
% (C) HTW Berlin M16DKPCÜ WS2020/2021

switch lower(ModFormat) 
    case {'psk2','bpsk','qam2'}
        constellation = [-1-1j, 1+1j];
        
    case {'qpsk','qam4','psk4'}
        constellation = [-1-1j, 1-1j, -1+1j, 1+1j];

    case 'qam8'
        constellation = [-1-1i, 1-1i, -1+1i, 1+1i, -1i*(1+sqrt(3)), 1+sqrt(3), -1-sqrt(3), 1i*(1+sqrt(3))]; 
        
    case 'qam16'
        constellation = [-3+3i, -3+1i, -3-3i, -3-1i, -1+3i, -1+1i, -1-3i, -1-1i, 3+3i, 3+1i, 3-3i, 3-1i, 1+3i, 1+1i, 1-3i, 1-1i];
        
    case 'qam32'
        constellation = [-3+5i, -1+5i, -3-5i, -1-5i, -5+3i, -5+1i, -5-3i, -5-1i, -1+3i, -1+1i, -1-3i, -1-1i, -3+3i, -3+1i, -3-3i, -3-1i,  3+5i,  1+5i,  3-5i,...
            1-5i,  5+3i,  5+1i,  5-3i,  5-1i,  1+3i,  1+1i,  1-3i,  1-1i,  3+3i,  3+1i,  3-3i,  3-1i];
        
    case 'qam64'
        constellation = [-7+7i, -7+5i, -7+1i, -7+3i, -7-7i, -7-5i, -7-1i, -7-3i, -5+7i, -5+5i, -5+1i, -5+3i, -5-7i, -5-5i, -5-1i, -5-3i, -1+7i, -1+5i, -1+1i,...
            -1+3i, -1-7i, -1-5i, -1-1i, -1-3i, -3+7i, -3+5i, -3+1i, -3+3i, -3-7i, -3-5i, -3-1i, -3-3i, 7+7i, 7+5i, 7+1i, 7+3i, 7-7i, 7-5i, 7-1i, 7-3i, 5+7i,...
            5+5i, 5+1i, 5+3i, 5-7i, 5-5i, 5-1i, 5-3i, 1+7i, 1+5i, 1+1i, 1+3i, 1-7i, 1-5i, 1-1i, 1-3i, 3+7i, 3+5i, 3+1i, 3+3i, 3-7i, 3-5i, 3-1i, 3-3i];
        
    case 'qam256'
        constellation = [-15-15i, -15-13i, -15-9i, -15-11i, -15-1i, -15-3i, -15-7i, -15-5i, -15+15i, -15+13i, -15+9i, -15+11i, -15+1i, -15+3i, -15+7i, -15+5i,...
            -13-15i, -13-13i, -13-9i, -13-11i, -13-1i, -13-3i, -13-7i, -13-5i, -13+15i, -13+13i, -13+9i, -13+11i, -13+1i, -13+3i, -13+7i, -13+5i, -9-15i,...
            -9-13i, -9-9i, -9-11i, -9-1i, -9-3i, -9-7i, -9-5i, -9+15i, -9+13i, -9+9i, -9+11i, -9+1i, -9+3i, -9+7i, -9+5i, -11-15i, -11-13i,...
            -11-9i, -11-11i, -11-1i, -11-3i, -11-7i, -11-5i, -11+15i, -11+13i, -11+9i, -11+11i, -11+1i, -11+3i, -11+7i, -11+5i, -1-15i, -1-13i, -1-9i,...
            -1-11i, -1-1i, -1-3i, -1-7i, -1-5i, -1+15i, -1+13i, -1+9i, -1+11i, -1+1i, -1+3i, -1+7i, -1+5i, -3-15i, -3-13i, -3-9i, -3-11i,...
            -3-1i, -3-3i, -3-7i, -3-5i, -3+15i, -3+13i, -3+9i, -3+11i, -3+1i, -3+3i, -3+7i, -3+5i, -7-15i, -7-13i, -7-9i, -7-11i, -7-1i,...
            -7-3i, -7-7i, -7-5i, -7+15i, -7+13i, -7+9i, -7+11i, -7+1i, -7+3i, -7+7i, -7+5i, -5-15i, -5-13i, -5-9i, -5-11i, -5-1i, -5-3i,...
            -5-7i, -5-5i, -5+15i, -5+13i, -5+9i, -5+11i, -5+1i, -5+3i, -5+7i, -5+5i, 15-15i, 15-13i, 15-9i, 15-11i, 15-1i, 15-3i, 15-7i,...
            15-5i, 15+15i, 15+13i, 15+9i, 15+11i, 15+1i, 15+3i, 15+7i, 15+5i, 13-15i, 13-13i, 13-9i, 13-11i, 13-1i, 13-3i, 13-7i, 13-5i,...
            13+15i, 13+13i, 13+9i, 13+11i, 13+1i, 13+3i, 13+7i, 13+5i, 9-15i, 9-13i, 9-9i, 9-11i, 9-1i, 9-3i, 9-7i, 9-5i, 9+15i,...
            9+13i, 9+9i, 9+11i, 9+1i, 9+3i, 9+7i, 9+5i, 11-15i, 11-13i, 11-9i, 11-11i, 11-1i, 11-3i, 11-7i, 11-5i, 11+15i, 11+13i,...
            11+9i, 11+11i, 11+1i, 11+3i, 11+7i, 11+5i, 1-15i, 1-13i, 1-9i, 1-11i, 1-1i, 1-3i, 1-7i, 1-5i, 1+15i, 1+13i, 1+9i,...
            1+11i, 1+1i, 1+3i, 1+7i, 1+5i, 3-15i, 3-13i, 3-9i, 3-11i, 3-1i, 3-3i, 3-7i, 3-5i, 3+15i, 3+13i, 3+9i, 3+11i, 3+1i,...
            3+3i, 3+7i, 3+5i, 7-15i, 7-13i, 7-9i, 7-11i, 7-1i, 7-3i, 7-7i, 7-5i, 7+15i, 7+13i, 7+9i, 7+11i, 7+1i, 7+3i, 7+7i, ...
            7+5i, 5-15i, 5-13i, 5-9i, 5-11i, 5-1i, 5-3i, 5-7i, 5-5i, 5+15i, 5+13i, 5+9i, 5+11i, 5+1i, 5+3i, 5+7i, 5+5i];
        
    case 'psk8'
        constellation = [sqrt(2)/2*(-1+1i), -1+0*1i, 0-1*1i, sqrt(2)/2*(-1-1i), 0+1*1i, sqrt(2)/2*(1+1i), sqrt(2)/2*(+1-1i), 1-0*1i];
        
    case 'psk16'
        constellation = [-0.707107+0.707107i, -0.92388+0.382683i, -0.92388-0.382683i, -1+0i,  0.382683-0.92388i,  0-1i, -0.707107-0.707107i, -0.382683-0.92388i, -0.382683+0.92388i,  0+1i, 0.707107+0.707107i,  0.382683+0.92388i, 0.707107-0.707107i,  0.92388-0.382683i,  0.92388+0.382683i,  1-0i];
        
    otherwise
        error(['Modformat ', ModFormat,' is not defined.'])
end



%% theoretical BER-vs-SNR formulas (SNR: SNR per symbol in linear units (not in dB); K: K-factor as defined for Rice-channel)
% berawgn() and berfading() are part of Matlab's Communications Toolbox (type 'doc berawgn' and 'doc berfading' in Matlab command prompt)

M = numel(constellation); % number of constellation points
switch lower(ModFormat) %
    case {'psk2','bpsk','qam2','psk8','psk16'} % PSK formats
        berTheoAWGN   = @(SNR,M) berawgn(10*log10((SNR/log2(M))),'psk',M,'nondiff');
        berTheoFading = @(SNR,M,K) berfading(10*log10((SNR/log2(M))),'psk',M,1,K);

    case {'qpsk','qam4','psk4','qam16','qam64','qam256'} % regular (square) QAM
        berTheoAWGN   = @(SNR,M)   berawgn(10*log10((SNR/log2(M))),'qam',M);
        berTheoFading = @(SNR,M,K) berfading(10*log10((SNR/log2(M))),'qam',M,1,K);

    case {'qam8'} % 8-QAM
        berTheoAWGN   = @(SNR,M) 26/47*erfc(sqrt(SNR*10/49)); % numerical fit to Carena2012 eq.(28)
        berTheoFading = @(SNR,M,K) 0.5*ones(size(SNR));
    
    case {'qam32'} % (square) 32-QAM
        berTheoAWGN   = @(SNR,M) 7/19*erfc(sqrt(SNR*1/20)); % numerical fit to Carena2012 eq.(28)
        berTheoFading = @(SNR,M,K) 0.5*ones(size(SNR));
        
    otherwise
        error(['Modformat ', ModFormat,' is not defined.'])
end