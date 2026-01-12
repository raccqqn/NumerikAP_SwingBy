function [diff, min_dist, t_min] = flybyM_dist(phi0, angle, v0)
    
    %Startbedingungen über ausgelagerte Funktion berechnen
    [pos, v0_vec] = v0_calc(v0, angle);
    y0 = [pos(:); v0_vec(:)];
    
    %Optionen festlegen, Simulation starten
    options = odeset('AbsTol',1e-14, 'RelTol',1e-12);
    tspan = [0, 500];   
    
    [t, y] = ode113(@(t,y) grav_calc(t,y,phi0), tspan, y0, options);
    
    %Minimalen Abstand bestimmen
    %Wenn Event ausgelöst wurde, ist ye(1:2) der Ort bei 20.000km
    %Fzero sucht: Abstand - Ziel
    rS = y(:,1:2);
    rV = posMars(t, phi0);
    dist_vec = vecnorm(rV - rS, 2, 2);      %Normierter Vektor, Mindestabstand speichern
    [min_dist, idx] = min(dist_vec);
    t_min = t(idx);
    
    diff = min_dist;          %Diff zurückgeben, fzero will: Dieser Wert = 0
end
