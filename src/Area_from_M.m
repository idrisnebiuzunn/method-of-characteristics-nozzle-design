function A_ratio = Area_from_M(M)
% Area_from_M
% Computes isentropic area ratio A/A* from Mach number M.

gamma = 1.4;

if any(M <= 0)
    error('Area_from_M requires M > 0');
end

A_ratio = (1./M).*(2/(gamma+1)*(1 + ((gamma-1)/2).*M.^2)).^((gamma+1)/(2*(gamma-1)));
end
