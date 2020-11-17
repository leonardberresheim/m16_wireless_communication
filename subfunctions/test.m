constellation = [-1-1j, 1-1j, -1+1j, 1+1j];
x = [-1-1j, 1+1j, -1-1j, 1-1j]
constellation.^2
mittlere_leistung_const = mean(abs(constellation).^2)
mittlere_leistung_x = mean(abs(x).^2)

x = x.*sqrt(mittlere_leistung_const/mittlere_leistung_x)

mittlere_leistung_x = mean(abs(x).^2)