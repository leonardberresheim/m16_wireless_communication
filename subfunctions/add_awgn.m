% ADD_AWGN für dem Sendesignal ein additives weißes Rauschen hinzu
% Eingänge:
%       x        Sendesignal
%       snr_b    Signal-to-noise ratio pro Bit in db (TBC)
%       M        Anzahl der Konstellationspunkte des Modulationsformat
% Ausgänge:
%       x_noise  Sendesignal mit Rauschen

function x_noise = add_awgn(x, snr_b, M)
    
    % Prealocate space
    x_noise = zeros(length(snr_b),length(x));
    % SNR pro bit in db nach linear umwandeln
    snr_b_lin = 10.^(snr_b./10);
    % SNR pro bit in SNR pro Symbol umwandeln
    snr_s_lin = snr_b_lin.*log2(M);
    % SNR pro Symbol linear in dB umwandeln
    snr_s_db = 10*log10(snr_s_lin);
    % Zu x ein Rauschen hinzufügen. 'measured' teilt der Funktion awgn mit,
    % dass die mittlere Leistung des signals x erst gemessen werden soll.
    x_n = size(x_noise);
    x_n = x_n(1);
    for n=1:x_n
        x_noise(n,:) = awgn(x, snr_s_db(n),'measured');
    end
end