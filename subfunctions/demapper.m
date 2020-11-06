% DEMAPPER - Inverse Funktion zur MAPPER Funktion
%   Eingabe: 
%       x                   Zeilen-Vektor - Entschiedenen Symbole
%       constellation       Zeilen-Vektor - Konstellationspunkte
%   Ausgabe: 
%       y                   Zeilen-Vektor - Zugehörigen Bits
function y = demapper(x, constellation)
    n_x = length(x);
    n_const = length(constellation);
    bit_frag_size = log2(n_const); 
    j = 1;
    for i=1:n_x
        a = fliplr(de2bi(find(x(i)==constellation)-1));
        while(length(a) ~= bit_frag_size)
           a = cat(2,0,a); 
        end
        y(j:j+bit_frag_size-1) = a;
        j = j+bit_frag_size;
    end
    
    
end