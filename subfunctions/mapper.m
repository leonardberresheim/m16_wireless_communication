% MAPPER Ordned Bits Konstellationspunkten zu
%   Eingabe: 
%       bits                Zeilen-Vektor - Bitstream
%       constellation       Zeilen-Vektor - Konstellationspunkte
%   Ausgabe: 
%       y                   Zeilen-Vektor - Gemappeter Bitstream



function y = mapper(bits, constellation)
    n_const = length(constellation);
    
     
    bits_frag_size = log2(n_const);   % Größe des bit fragments, - davon abhängig wie groß constellation-vector ist.
    
    % If bits is too short, add "0"s
    while(mod(length(bits),bits_frag_size)~=0)
        bits = cat(2,0,bits);
    end
    
    y = zeros(1,length(bits)/bits_frag_size);  %Pre-allocate space for y
    x = 1;
    
    for i=1:bits_frag_size:length(bits)
        index = bi2de(fliplr(bits(i:i+bits_frag_size-1))) + 1;     %bi2de ließt die binär zahl von rechts nach links, deswegen der fliplr
        y(1,x) = constellation(index);
        x = x + 1;
    end
    
    
end