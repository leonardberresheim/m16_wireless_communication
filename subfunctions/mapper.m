%GENERATEBITS generiert eine zufällige Reihe Bits aus
%   Eingabe: 
%       bits                Zeilen-Vektor - Bitstream
%       constellation       Zeilen-Vektor - Konstellationspunkte
%   Ausgabe: 
%       y                   Zeilen-Vektor - Gemappeter Bitstream



function y = mapper(bits, constellation)
    n_bits = length(bits);
    n_const = length(constellation);
    bits_frag_size = log2(n_const);   % Größe des bit fragments, - davon abhängig wie groß constellation-vector ist.
    y = strings(1,n_bits/bits_frag_size);  %Pre-allocate space for y
    x = 1;
    for i=1:bits_frag_size:n_bits
        index = bi2de(fliplr(bits(i:i+bits_frag_size-1))) + 1;     %bi2de ließt die binär zahl von rechts nach links, deswegen der fliplr
        y(1,x) = constellation(index);
        x = x + 1;
    end
    
    
end