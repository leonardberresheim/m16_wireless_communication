% DEMAPPER - Inverse function to MAPPER funktion
%   Input: 
%       x                   (1 x n) vector - Decided symbols
%       constellation       (1 x Q) vector - Constellation symbols
%   Output: 
%       y                   (1 x n*bit_frag_size) vector - Demapped bits
% ------------------------------------------------------------------
% When this function is executed in the vectorized part of the simulation
% then:
%       x    (n x m) vector
%       y    (n x m) vector

function y = demapper(x, constellation)
    % Get size of x
    n = size(x);
    % When in loop simulation n_x = 1
    n_x = n(1);
    s_x = n(2);
    % Preallocate space for y
    y = zeros(n_x,s_x);
    
    % Number of constellation symbols
    n_const = length(constellation);
    
    % The size of the bits fragment (mapped to a symbol) depends on the
    % number of constellation symbols
    bit_frag_size = log2(n_const); 
    
    % This will be executed for each symbol in each col of the signals
    % vector. And if this is executed in the vectorized mode then also for
    % each symbols-vector in each row of the signals matrix
    for j=1:n_x
        
        % We need two counting variables.
        % i for indexing the mapped signal,
        % and i_2 for indexing the output vector, incrementing it by bits_frag_size.
        i_2 = 1;
        for i=1:s_x
            % This time the constellation table is looked at in the inverse
            % direction. We find the index for the constellation symbol
            % that corresponds to the decided symbol, subtract 1 and
            % convert to binary with de2bi.
            % Because de2bi reads binary numbers from right to left the
            % result need to be fliped.
            a = fliplr(de2bi(find(x(j,i)==constellation)-1));
            % The above code returns a with the "unessesary" 0s cut away.
            % i.e. 01 -> 1
            % Thos 0s are necessary for us so we add them back again till a
            % corresponds to our bit_frag_size
            while(length(a) ~= bit_frag_size)
               a = cat(2,0,a); 
            end
            y(j,i_2:i_2+bit_frag_size-1) = a;
            i_2 = i_2+bit_frag_size;
        end
    end
    
end