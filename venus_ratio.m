function val = venus_ratio(d, rV)

    r_test = rV + [0; d];
    y = [r_test; 0; 0];

    [~, a_S, a_E, a_V] = grav_calc(0, y);
    a_total = a_S + a_E + a_V; 

    val = norm(a_V)/norm(a_total) - 0.01; %bei erreichen von 1% Nullstelle
end