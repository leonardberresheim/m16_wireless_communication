% Trifft ein Entscheidungen bezüglich Modulationssymbolen
%   Eingabe: 
%       x                   Zeilen-Vektor - Empfangene Symbole
%       constellation       Zeilen-Vektor - Konstellationspunkte
%   Ausgabe: 
%       y                   Zeilen-Vektor - Entschiedene Modulationssymbole


function y = decision(x, constellation)
    n = size(x);
    n_x = n(1);
    s_x = n(2);
    y = zeros(n_x,s_x);
    f = @(A,B) (A-B).^2;
    % Signal wird auf die mittlere Leisung der gesendeten
    mittlere_leistung_x = mean(abs(x).^2); 
    mittlere_leistung_const = mean(abs(constellation).^2);
    x_m = x.*sqrt(mittlere_leistung_const./mittlere_leistung_x);
    
    for i=1:n_x
        for j=1:s_x
            a = sqrt(bsxfun(f,real(x_m(i,j)), real(constellation))+ bsxfun(f,imag(x_m(i,j)), imag(constellation)));
            y(i,j) = constellation(find(a == min(a)));
        end
    end
end