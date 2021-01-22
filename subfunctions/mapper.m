% MAPPER maps bits according to the constellation format
%   Input: 
%       bits                (1 x n) vector - Bitsequence
%       constellation       (1 x Q) vector - Constellation symbols
%   Output: 
%       y                   (1 x "n/bit_frag_size") vector - Mapped bitsequence



function y = mapper(bits, constellation)
    % Get number of constellation symbols
    n_const = length(constellation);
    
    % The size of the bits fragment (mapped to a symbol) depends on the
    % number of constellation symbols
    bits_frag_size = log2(n_const); 
    
    % If bits is too short, add "0"s 
    % For example : 
    % n_const = 4 -> bits_frag_size = 2
    % Bitsequence = 00101
    % Fragmented bitseqeunce = 0|01|01 - The left fragment missed a bit
    % so we add 0 => 00|01|01
    while(mod(length(bits),bits_frag_size)~=0)
        % cat(dim,A,B) - concatenates B to the end of A along dimension dim 
        % Here vector is 2-dimentional. A is 0. B the bitsequence
        bits = cat(2,0,bits);
    end
    
    %Pre-allocate space for y
    y = zeros(1,length(bits)/bits_frag_size);
    
    % The mapping is executed in a for loop.
    % We need two counting variables.
    % i for indexing the bitsequence, incrementing it by the bits_frag_size
    % and  for indexing the output vector.
    x = 1;
    for i=1:bits_frag_size:length(bits)
        % According to the constallation format table see before, the bit
        % fragment will be converted to decimal (with bi2de) and
        % incremented by one to index the constaltion vector.
        % bi2de reads binary numbers from right to left, this is why the
        % bit fragment needs to be flipped first.
        index = bi2de(fliplr(bits(i:i+bits_frag_size-1))) + 1;     %bi2de ließt die binär zahl von rechts nach links, deswegen der fliplr
        y(1,x) = constellation(index);
        x = x + 1;
    end  
end