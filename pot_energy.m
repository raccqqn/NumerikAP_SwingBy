function pot = pot_energy(y)

G = 6.67 * 10^-11 * (86400^2);  %Gravitationskonstante mit Tagen
M = 1.99 * 10^30;   %Sonnenmasse
m = 1;              %Masse Sonde

pos = [y(:,1), y(:,2)];

r = vecnorm(pos, 2, 2);   % Nx1-Vektor

pot = -(G*m*M) ./ r;

end