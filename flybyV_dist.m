function diff = flybyV_dist(angle, v0, target_dist)
    
    %Startbedingungen über ausgelagerte Funktion berechnen
    [pos, v0_vec] = v0_calc(v0, angle);
    y0 = [pos(:); v0_vec(:)];
    
    %Optionen festlegen, Simulation starten
    options = odeset('AbsTol',1e-14, 'RelTol',1e-12, 'Events', @swinger);
    tspan = [0, 500];   
    
    [t, y, te, ye, ie] = ode113(@grav_calc, tspan, y0, options);
    
    %Minimalen Abstand bestimmen
    %Wenn Event ausgelöst wurde, ist ye(1:2) der Ort bei 20.000km
    %Fzero sucht: Abstand - Ziel
    rS = y(:,1:2);
    rV = posVenus(t);
    dist_vec = vecnorm(rV - rS, 2, 2);      %Normierter Vektor, Mindestabstand speichern
    min_dist = min(dist_vec);
    
    diff = min_dist - target_dist;          %Diff zurückgeben, fzero will: Dieser Wert = 0
end

function [val, term, dir] = swinger(t, y)
    target = 16000 * 10^3;  %Zieldistanz in Metern

    rS = y(1:2)';           %Als Zeilenvektor speichern
    rV = posVenus(t);
    dist = norm(rV - rS);

    val = target - dist;                  %Toleranz, ode45 löst System nur an bestimmten Zeitschritten
    term = 1;                             %Stoppen
    dir = -1;
end