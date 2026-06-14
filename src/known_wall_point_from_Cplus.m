function P = known_wall_point_from_Cplus(F, wall_y, theta_wall, x_start, x_end)

    fun = @(xP) wall_residual_from_Cplus(xP, F, wall_y, theta_wall);

    x_sample = linspace(x_start, x_end, 300);
    f_sample = nan(size(x_sample));

    for k = 1:numel(x_sample)
        f_sample(k) = fun(x_sample(k));
    end

    found = false;

    for k = 1:numel(x_sample)-1
        f1 = f_sample(k);
        f2 = f_sample(k+1);

        if isfinite(f1) && f1 == 0
            xP = x_sample(k);
            found = true;
            break;
        end

        if isfinite(f1) && isfinite(f2) && f1*f2 < 0
            xP = fzero(fun, [x_sample(k), x_sample(k+1)]);
            found = true;
            break;
        end
    end

   if ~found
    P = [];
    return;
end


    yP = wall_y(xP);
    thetaP = theta_wall(xP);

    K_plus = F.theta - F.nu;
    nuP = thetaP - K_plus;

    MP = M_from_PM(nuP);
    mach_angleP = machAngle_from_M(MP);

    P.x = xP;
    P.y = yP;
    P.theta = thetaP;
    P.nu = nuP;
    P.M = MP;
    P.mach_angle = mach_angleP;
end


function res = wall_residual_from_Cplus(xP, F, wall_y, theta_wall)

    if ~isfinite(xP) || xP <= F.x
        res = NaN;
        return;
    end

    thetaP = theta_wall(xP);

    K_plus = F.theta - F.nu;
    nuP = thetaP - K_plus;

    nu_max = PM_from_M(100); %100 mach olsun cok sacmaliyor contour kotu

    if ~isfinite(thetaP) || ~isfinite(nuP) || nuP <= 0 || nuP >= nu_max
        res = NaN;
        return;
    end

    MP = M_from_PM(nuP);
    mach_angleP = machAngle_from_M(MP);

    m_plus = tand(0.5*((F.theta + F.mach_angle) + (thetaP + mach_angleP)));

    y_line = F.y + m_plus*(xP - F.x);
    res = y_line - wall_y(xP);

    if ~isfinite(res)
        res = NaN;
    end
end
