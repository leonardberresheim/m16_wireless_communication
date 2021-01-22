% DECISION Decides to which constellation point of format each received
% symbol corresponds
%   Input: 
%       x                   (1 x n) vector - Received symbols
%       constellation       (1 x Q) vector - Constellation symbols
%   Output: 
%       y                   (1 x n) vector - Decided modulation symbols
% ------------------------------------------------------------------
% When this function is executed in the vectorized part of the simulation
% then:
%       x    (n x m) vector
%       y    (n x m) vector

function y = decision(x, constellation)
    % Get size of x
    n = size(x);
    % When in loop simulation n_x = 1
    n_x = n(1);
    s_x = n(2);
    % Preallocate space for y
    y = zeros(n_x,s_x);
    
    
    % Before the decision the Signal needs to be normed to the mean power
    % of the constellations symbols, because the canal may have changed the
    % average power of the signal
    % The power is given by |z|^2
    % To get the average we use the matlab function mean
    mittlere_leistung_x = mean(abs(x).^2); 
    mittlere_leistung_const = mean(abs(constellation).^2);
    x_m = x.*sqrt(mittlere_leistung_const./mittlere_leistung_x);
        % This will be executed for each symbol in each col of the signals
    % vector. And if this is executed in the vectorized mode then also for
    % each symbols-vector in each row of the signals matrix
    % The signals symbols are decided by choosing for each symbol 
    % the constellation symbol with the shortest 
    % euklidian distance to this symbol
    % The euklidian distance: 
    % d(p,q) = sqrt((Im(p)-Im(q))^2 + (Re(p)-Re(q))^2)
    
    % Function handle for part of euklidian distance formula
    f = @(A,B) (A-B).^2;
    
    % This will be executed for each symbol in each col of the signals
    % vector. And if this is executed in the vectorized mode then also for
    % each symbols-vector in each row of the signals matrix
    for i=1:n_x
        for j=1:s_x
            % By using the matlab function bsxfun, we compute the euklidian
            % distance from the signals symbol to each symbol in the
            % constellation vector and save it in (1 x Q) vector a
            a = sqrt(bsxfun(f,real(x_m(i,j)), real(constellation))+ bsxfun(f,imag(x_m(i,j)), imag(constellation)));
            % This returns the index smalled number in vector a resp. the 
            % index of the constellation symbol with the smallest euklidian
            % distance to the signals symbol
            y(i,j) = constellation(find(a == min(a)));
        end
    end
end