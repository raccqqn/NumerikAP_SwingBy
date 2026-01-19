function [diff, min_dist, t_min] = flybyV_dist(angle, v0, phi0M, target_dist)
    
    %Startbedingungen über ausgelagerte Funktion berechnen
    [pos, v0_vec] = v0_calc(v0, angle);
    y0 = [pos(:); v0_vec(:)];
    
    %Optionen festlegen - Stop condition, Feste Zeitspanne
    options = odeset('AbsTol',1e-10, 'RelTol',1e-8, 'Events', @(t,y) swinger(t,y,target_dist));
    tspan = [0, 500];   
    
    %Flug durchführen
    [t, y] = ode113(@(t,y) grav_calc(t,y,phi0M), tspan, y0, options);

    %Mars, Sonden - Positionen speichern
    rS = y(:,1:2);
    rV = posVenus(t);

    %Distanz über normierten Vektor bestimmen, Mindestabstand speichern
    dist_vec = vecnorm(rV - rS, 2, 2);     
    [min_dist, idx] = min(dist_vec);
    
    %Entsprechenden Tag speichern
    t_min = t(idx);
    
    %Differenz zurückgeben, wird minimiert
    diff = min_dist - target_dist;          
end

function [val, term, dir] = swinger(t, y, target)

    %Abstand berechnen
    rS = y(1:2)';          
    rV = posVenus(t);
    dist = norm(rV - rS);

    %Stoppen, wenn Zieldistanz erreicht ist
    val = target - dist;                  
    term = 1;                             
    dir = -1;
end