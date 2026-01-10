function [pos, v0_vec] = v0_calc(v0,angle)

diam_earth = 12742 * 10^3;      %Erdumfang in Metern 
angle_tan = 0.7724 + pi/2;      %Winkel Tangente zu Erde bei Start
angle = angle + angle_tan;      %Erdtangente + Abschusswinkel
w_earth = 2*pi / 365.256;       %Winkelgeschwindigkeit Erde
r_earth  = 149597870*10^3;      %Radius Erde in Metern
v_earth = w_earth * r_earth;

pos = posEarth(0);
pos(1) = pos(1) + cos(angle_tan) * diam_earth / 2;
pos(2) = pos(2) + sin(angle_tan) * diam_earth / 2;


v0_earth = v_earth * [cos(angle_tan); sin(angle_tan)];
v0_sat = v0 * [cos(angle); sin(angle)];
v0_vec = v0_sat + v0_earth; 

end