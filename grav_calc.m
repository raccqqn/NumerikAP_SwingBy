function [dydt, a_S, a_E, a_V] = grav_calc(t, y)

G = 6.67 * 10^-11 * (86400^2);  %Gravitationskonstante mit Tagen

M_S = 1.988 * 10^30;   %Sonnenmasse
M_E = 5.9722 * 10^24; %Erdmasse
M_V = 4.8673 * 10^24; %Venusmasse

r = y(1:2);         %Abstand und Geschwindigkeit aus y speichern
v = y(3:4);

%Position der Planeten am aktuellen Zeitpunkt berechnen
rabs_E = r - posEarth(t)';  
rabs_V = r - posVenus(t)';

%Beschleunigungen der einzelnen Körper berechnen
a_S = -(G*M_S / norm(r)^3) * r;                     %Am Nullpunkt                 
a_E = -(G*M_E / norm(rabs_E)^3) * (rabs_E);
a_V = -(G*M_V / norm(rabs_V)^3) * (rabs_V);

a_sum = a_S + a_E + a_V;

dydt = [v; a_sum];

end