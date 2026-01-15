function [kin, pot, sum] = energy_calc(y)

G = 6.67 * 10^-11 * (86400^2);  %Gravitationskonstante mit Tagen
M = 1.99 * 10^30;   %Sonnenmasse
m = 1;              %Masse Sonde

speed = vecnorm(y(:,3:4),2,2);    %Geschwindigkeit aus y berechnen
kin = 0.5 * speed .^ 2;           %Kinetische Energie berechnen

pos = [y(:,1), y(:,2)];
r = vecnorm(pos, 2, 2);           %Betrag des Vektors, Sonne immer an 0-Punkt
pot = -(G*m*M) ./ r;              %Potentielle Energie berechnen

sum = kin + pot;                  %Gesamtenergie berechnen


end