function M = M_from_PM(nu)
% M_from_PM
% Computes Mach number M from Prandtl-Meyer angle nu in degrees.

if ~isscalar(nu) || ~isreal(nu) || ~isfinite(nu)
    error('M_from_PM requires a finite real scalar nu');
end

if nu < 0
    error('M_from_PM requires nu >= 0 degrees');
end

if nu == 0
    M = 1;
    return;
end

M_upper = 100;
nu_upper = PM_from_M(M_upper);

if nu >= nu_upper
    error('M_from_PM: nu = %.6f is outside search range (nu_max = %.6f).', ...
        nu, nu_upper);
end

fun = @(M) PM_from_M(M) - nu;
M = fzero(fun, [1 + 1e-8, M_upper/2]);
end
