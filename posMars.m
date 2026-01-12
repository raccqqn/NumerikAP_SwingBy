function p = posMars(t)

r  = 227990000*10^3;  % Mittlerer Bahnradius Mars
T = 686.980; % Umlaufzeit | Tage

w = 2*pi / T;

phi0 = -1.7;

x = r * cos(w * t + phi0);
y = r * sin(w * t + phi0);
p = [x(:), y(:)];


end