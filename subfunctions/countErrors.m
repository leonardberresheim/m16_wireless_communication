% COUNTERRORS - Zählt die Entstandenen Bitfehler
%   Eingabe: 
%       x                   Zeilen-Vektor - Entschiedenen Bits
%       bits                Zeilen-Vektor - Ursprüngliche Bits
%   Ausgabe: 
%       nErr                Anzahl der Bitfehler
%       ber                 Bitfehlerverhältnis

function [nErr, ber] = countErrors(x,bits)
        nErr = length(find(x ~= bits));
        ber = nErr / length(x);
end