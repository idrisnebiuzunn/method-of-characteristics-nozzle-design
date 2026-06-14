function nu = PM_from_M(M)
% PM_from_M
% Computes Prandtl-Meyer angle nu in degrees from Mach number M.

gamma = 1.4;

if any(M < 1)
    error('PM_from_M is only valid for M >= 1');
end

nu_rad = sqrt((gamma+1)/(gamma-1))*atan(sqrt((gamma-1)/(gamma+1)*(M.^2 - 1))) ...
       - atan(sqrt(M.^2 - 1));

nu = nu_rad*180/pi;
end
