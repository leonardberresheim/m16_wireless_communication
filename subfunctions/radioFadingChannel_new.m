% RADIOFADINGCHANNEL berrechnet die koplexen Kanalkoeffizienten für einen
% Fading Kanal
% Eingänge:
%       nSamp   Anzahl der Kanalkoeffizienten die erstellt werden sollen
%           k   k-Koeffizient
% Ausgänge:
%       y       vector (nSamp x 1) der komplexen Kanalkoeffizienten
function y = radioFadingChannel_new(nSamp,k)
    I = randn(1,nSamp);
    R = randn(1,nSamp);
    y = R + 1i*I;
    % Auf mittlere Leistung normieren
    y = y.*sqrt(1./(mean(abs(y).^2)));
    
    % Hinzufügung einer LOS-Komponente für Rice-Kanal
    % Zufällige phase
    t_los = randn(1,nSamp);
    % Leisung von nlos
    p_nlos = (norm(y)^2/nSamp);
    % Leisung von los
    p_los = k.* p_nlos;
    % LOS Komponente berechnen aus Phase und Leistung
    los = sqrt(p_los).*(cos(t_los)+sin(t_los).*1i);
    
    % LOS Komponente auf NLOS addieren
    y = y + los;
    
    % Wieder auf mittlere Leistung normieren
    y = y.*sqrt(1./(mean(abs(y).^2)));
    
end