function p = posEarth(t)

r  = 149597870*10^3;  % Mittlerer Bahnradius Erde
T = 365.256; % Umlaufzeit Erde | Tage

w = 2*pi / T;

%Erde um ~45° positiv verschoben
phi0 = 0.7724;

x = r * cos(w * t + phi0);
y = r * sin(w * t + phi0);
p = [x(:), y(:)];

end