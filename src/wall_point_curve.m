function P = wall_point_curve(R, wall_y, wall_dydx, x_guess)
% wall_point_curve
% Finds wall point P on a known curved contour.
%
% INPUTS:
%   R         : interior point coming from right-running characteristic (C-)
%   wall_y    : function handle for wall y(x)
%   wall_dydx : function handle for wall dy/dx
%   x_guess   : initial guess for wall-point x location
%
% OUTPUT:
%   P         : wall point structure with fields
%               x, y, theta, nu, M, mach_angle

    % Root function: characteristic line minus wall curve
    fun = @(xP) wall_residual(xP, R, wall_y, wall_dydx);

    % Solve for x-coordinate of wall point
    xP = fzero(fun, x_guess);

    % Wall geometry at xP
    yP = wall_y(xP);
    thetaP = atand(wall_dydx(xP));

    % Compatibility along C- from R to wall point P
    nuP = R.theta + R.nu - thetaP;

    % Flow properties at wall point
    MP = M_from_PM(nuP);
    mach_angleP = machAngle_from_M(MP);

    % Store output
    P.x = xP;
    P.y = yP;
    P.theta = thetaP;
    P.nu = nuP;
    P.M = MP;
    P.mach_angle = mach_angleP;

end


function res = wall_residual(xP, R, wall_y, wall_dydx)
% Residual between characteristic line and wall curve

    % Wall point geometry
    yP = wall_y(xP);
    thetaP = atand(wall_dydx(xP));

    % Compatibility along C-
    nuP = R.theta + R.nu - thetaP;

    % Flow properties
    MP = M_from_PM(nuP);
    mach_angleP = machAngle_from_M(MP);

    % Characteristic slope (C-)
    m_c = tand( 0.5*((R.theta - R.mach_angle) + (thetaP - mach_angleP)) );

    % Residual: line value - wall value
    y_line = R.y + m_c*(xP - R.x);
    res = y_line - yP;

end