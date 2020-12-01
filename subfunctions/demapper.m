% DEMAPPER - Inverse Funktion zur MAPPER Funktion
%   Eingabe: 
%       x                   Zeilen-Vektor - Entschiedenen Symbole
%       constellation       Zeilen-Vektor - Konstellationspunkte
%   Ausgabe: 
%       y                   Zeilen-Vektor - Zugehörigen Bits
function y = demapper(x, constellation)
    n = size(x);
    n_x = n(1);
    s_x = n(2);
    n_const = length(constellation);
    bit_frag_size = log2(n_const); 
    
    for j=1:n_x
        i_2 = 1;
        for i=1:s_x
            a = fliplr(de2bi(find(x(j,i)==constellation)-1));
            while(length(a) ~= bit_frag_size)
               a = cat(2,0,a); 
            end
            y(j,i_2:i_2+bit_frag_size-1) = a;
            i_2 = i_2+bit_frag_size;
        end
    end
    
end