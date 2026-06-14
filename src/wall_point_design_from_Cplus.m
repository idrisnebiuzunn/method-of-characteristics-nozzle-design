function P = wall_point_design_from_Cplus(F, Wprev, K_minus_wall)
% wall_point_design_from_Cplus
% Designs the next wall point from a field point F carrying a C+
% characteristic to the wall.
%
% F carries:
%   K_plus = F.theta - F.nu
%
% Minimum-length straightening wall condition:
%   K_minus_wall = thetaP + nuP
%
% Wprev is the previous wall point and supplies the previous wall tangent.

%% 1) Compatibility at the new wall point
K_plus = F.theta - F.nu;

thetaP = 0.5*(K_minus_wall + K_plus);
nuP    = 0.5*(K_minus_wall - K_plus);

%% 2) Flow properties
MP = M_from_PM(nuP);
mach_angleP = machAngle_from_M(MP);

%% 3) Slopes
m_plus = tand(0.5*((F.theta + F.mach_angle) + (thetaP + mach_angleP)));
m_wall = tand(0.5*(Wprev.theta + thetaP));

%% 4) Coordinates from C+ line and wall tangent intersection
xP = ((Wprev.y - F.y) + m_plus*F.x - m_wall*Wprev.x)/(m_plus - m_wall);
yP = F.y + m_plus*(xP - F.x);

%% 5) Store output
P.x = xP;
P.y = yP;
P.theta = thetaP;
P.nu = nuP;
P.M = MP;
P.mach_angle = mach_angleP;
end
