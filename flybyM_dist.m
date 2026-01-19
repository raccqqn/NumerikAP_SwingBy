function [diff, min_dist, t_min] = flybyM_dist(phi0, angle, v0)
    
    %Startbedinungen über ausgelagerte Funktion berechnen
    [pos, v0_vec] = v0_calc(v0, angle);
    y0 = [pos(:); v0_vec(:)];
    
    %Optionen festlegen - Stop Condition, Feste Zeitspanne
    options = odeset('AbsTol',1e-10, 'RelTol',1e-8, "Events", @(t,y) distanceMars(t, y, phi0, 10000 * 10^3));
    tspan = [0, 500];   
    
    %Flug durchführen
    [t, y] = ode15s(@(t,y) grav_calc(t,y,phi0), tspan, y0, options);
    
    %Mars, Sonden - Positionen speichern
    rS = y(:,1:2);
    rV = posMars(t, phi0);

    %Distanz über normierten Vektor bestimmen, Mindestabstand speichern
    dist_vec = vecnorm(rV - rS, 2, 2);      
    [min_dist, idx] = min(dist_vec);

    %Entsprechenden Tag speichern
    t_min = t(idx);
    
    %Differenz zurückgeben, wird minimiert
    diff = min_dist;         
end

function [val, term, dir] = distanceMars(t, y, bestphi, target)

    %Abstand berechnen
    rS = y(1:2)';           
    rV = posMars(t, bestphi);
    dist = norm(rV - rS);

    %Stoppen, wenn Zieldistanz erreicht ist
    val = dist - target;                  
    term = 1;                             
    dir = -1;
end
