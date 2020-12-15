% GENERATEBITS generiert eine zufällige Reihe Bits aus
%   Eingabe: 
%       nBits       Anzahl der Bits
%   Ausgabe: 
%       y           (1 x nBits) Vektor der zufällig generierten Bits

function y = generateBits(nBits)
    y = logical(randi([0 1], 1, nBits)); %Creates Vector (1 x nBits) of uniformly distributed pseudorandom logical of [0 1] - 
    % stem(y); %Ausgabe der Datenfolge
end
