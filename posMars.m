function p = posMars(t)

r  = 227990000*10^3;  % Mittlerer Bahnradius Venus  
T = 686.980; % Umlaufzeit | Tage

w = 2*pi / T;

x = r * cos(w * t);
y = r * sin(w * t);
p = [x(:), y(:)];

end