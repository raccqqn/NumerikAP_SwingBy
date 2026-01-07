function p = posVenus(t)

r  = 108208930;  % Mittlerer Bahnradius Venus  
T = 224.701; % Umlaufzeit | Tage

w = 2*pi / T;

x = r * cos(w * t);
y = r * sin(w * t);
p = [x(:), y(:)];

end