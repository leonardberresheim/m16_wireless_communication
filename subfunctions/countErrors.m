% COUNTERRORS - Zählt die Entstandenen Bitfehler
%   Eingabe: 
%       x                   Zeilen-Vektor - Entschiedenen Bits
%       bits                Zeilen-Vektor - Ursprüngliche Bits
%   Ausgabe: 
%       nErr                Anzahl der Bitfehler
%       ber                 Bitfehlerverhältnis

function [nErr, ber] = countErrors(x,bits)
        n = size(x);
        n_x = n(1);
        s_x = n(2);
        % Prealocate space
        nErr = zeros(n_x,1);
        ber = zeros(n_x,1);
        for i = 1:n_x
            nErr(i) = length(find(x(i,:) ~= bits));
            ber(i) = nErr(i,:) ./ s_x;
        end
end