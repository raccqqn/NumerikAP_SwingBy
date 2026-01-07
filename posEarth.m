function p = posEarth(t)

r  = 149597870;  % Mittlerer Bahnradius Erde
T = 365.256; % Umlaufzeit Erde | Tage

w = 2*pi / T;

x = r * cos(w * t);
y = r * sin(w * t);
p = [x(:), y(:)];

end