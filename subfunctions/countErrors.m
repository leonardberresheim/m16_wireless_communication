% COUNTERRORS - Counts number of error caused by the canal
%   Eingabe: 
%       x                   (1 x n) vector - Demapped symbols
%       bits                (1 x n) vector - Initial bit sequence
%   Ausgabe: 
%       nErr                Number of bit errors
%       ber                 Bit error ratio
% ---------------------------------------------------------
% When this function is executed in the vectorized part of the simulation
% then:
%       x       (n x m) vector
%       nErr    (1 x m) vector
%       ber     (1 x m) vector

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