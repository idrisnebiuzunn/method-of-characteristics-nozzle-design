function P = make_point_from_K(K_minus, K_plus)
% make_point_from_K
% Creates a flow-property struct from characteristic invariants.
%
% Convention:
%   K_minus = theta + nu
%   K_plus  = theta - nu

thetaP = 0.5*(K_minus + K_plus);
nuP    = 0.5*(K_minus - K_plus);

MP = M_from_PM(nuP);
mach_angleP = machAngle_from_M(MP);

P.x = NaN;
P.y = NaN;
P.theta = thetaP;
P.nu = nuP;
P.M = MP;
P.mach_angle = mach_angleP;
end
