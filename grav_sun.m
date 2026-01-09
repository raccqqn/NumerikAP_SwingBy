function dydt = grav_sun(t, y)

G = 6.67 * 10^-11 * (86400^2);  %Gravitationskonstante mit Tagen
M = 1.99 * 10^30;   %Sonnenmasse

r = y(1:2);         %Abstand und Geschwindigkeit aus y speichern
v = y(3:4);

a = -(G*M / norm(r)^3) * r;
%Fg = m*a ---> Masse kürzt sich aus Formel

dydt = [v; a];

end