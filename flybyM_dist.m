function [diff, min_dist, t_min] = flybyM_dist(phi0, angle, v0)
    
    %Startbedingungen über ausgelagerte Funktion berechnen
    [pos, v0_vec] = v0_calc(v0, angle);
    y0 = [pos(:); v0_vec(:)];
    
    %Optionen festlegen, Simulation starten
    options = odeset('AbsTol',1e-10, 'RelTol',1e-8, "Events", @(t,y) distanceMars(t, y, phi0, 1000 * 10^3));
    tspan = [0, 500];   
    
    [t, y] = ode15s(@(t,y) grav_calc(t,y,phi0), tspan, y0, options);
    
    rS = y(:,1:2);
    rV = posMars(t, phi0);
    dist_vec = vecnorm(rV - rS, 2, 2);      %Normierter Vektor, Mindestabstand speichern
    [min_dist, idx] = min(dist_vec);
    t_min = t(idx);
    
    diff = min_dist;          %Diff zurückgeben
end

function [val, term, dir] = distanceMars(t, y, bestphi, target)

    rS = y(1:2)';           %Als Zeilenvektor speichern
    rV = posMars(t, bestphi);
    dist = norm(rV - rS);

    val = dist - target;                  %Toleranz, ode45 löst System nur an bestimmten Zeitschritten
    term = 1;                             %Stoppen
    dir = -1;
end
