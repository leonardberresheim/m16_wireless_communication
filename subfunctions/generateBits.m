% GENERATEBITS generates a random bit sequence
%   Input: 
%       nBits       Number of Bits
%   Output: 
%       y           (1 x nBits) vector of random generated bits

function y = generateBits(nBits)
    y = logical(randi([0 1], 1, nBits)); %Creates Vector (1 x nBits) of uniformly distributed pseudorandom logical of [0 1] - 
    % stem(y); % Output the Bitsequence
end
