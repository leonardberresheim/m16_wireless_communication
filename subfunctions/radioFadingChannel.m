% RADIOFADINGCHANNEL berrechnet die koplexen Kanalkoeffizienten für einen
% Fading Kanal
% Eingänge:
%       nSamp   Anzahl der Kanalkoeffizienten die erstellt werden sollen
% Ausgänge:
%       y       vector (nSamp x 1) der komplexen Kanalkoeffizienten
function y = radioFadingChannel(nSamp)
    I = randn(1,nSamp);
    R = randn(1,nSamp);
    y = R + j*I;
    y = y.*sqrt(1./(mean(abs(y).^2))); % Nölle fragen = mittlere leistung für komplexe zahlen
end