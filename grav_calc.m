function [dydt, a_S, a_E, a_V] = grav_calc(t, y, phi0M)

G = 6.67 * 10^-11 * (86400^2);  %Gravitationskonstante mit Tagen

M_S = 1.988 * 10^30;   %Sonnenmasse
M_E = 5.9722 * 10^24; %Erdmasse
M_V = 4.8673 * 10^24; %Venusmasse
M_M = 6.417 * 10^23;  %Marsmasse

r = y(1:2);         %Abstand und Geschwindigkeit aus y speichern
v = y(3:4);

%Position der Planeten am aktuellen Zeitpunkt berechnen
rabs_E = r - posEarth(t)';  
rabs_V = r - posVenus(t)';
rabs_M = r - posMars(t, phi0M)';

%Beschleunigungen der einzelnen Körper berechnen
a_S = -(G*M_S / norm(r)^3) * r;                     %Am Nullpunkt                 
a_E = -(G*M_E / norm(rabs_E)^3) * (rabs_E);
a_V = -(G*M_V / norm(rabs_V)^3) * (rabs_V);
a_M = -(G*M_M / norm(rabs_M)^3) * (rabs_M);

a_sum = a_S + a_E + a_V + a_M;

dydt = [v; a_sum];

end