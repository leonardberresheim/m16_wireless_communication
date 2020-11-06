% Trifft ein Entscheidungen bezüglich Modulationssymbolen
%   Eingabe: 
%       x                   Zeilen-Vektor - Empfangene Symbole
%       constellation       Zeilen-Vektor - Konstellationspunkte
%   Ausgabe: 
%       y                   Zeilen-Vektor - Entschiedene Modulationssymbole


function y = decision(x, constellation)
    n_x = length(x);
    y = zeros(1,n_x);
    f = @(A,B) (A-B).^2;
    % Signal wird auf die mittlere Leisung der gesendeten
    % Konstellationspunkte normiert
    % TODO
    for i=1:n_x        
    a = sqrt(bsxfun(f,real(x(i)), real(constellation))+ bsxfun(f,imag(x(i)), imag(constellation)));
    y(i) = constellation(find(a == min(a)));
    end
end