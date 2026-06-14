function P = centerline_point(R)
% centerline_point
% Finds centerline point P from a known point R coming with a
% right-running characteristic (C-).
%
% INPUT:
%   R : known point structure with fields
%       x, y, theta, nu, M, mach_angle
%
% OUTPUT:
%   P : centerline point structure with fields
%       x, y, theta, nu, M, mach_angle

%% 1) Centerline conditions
thetaP = 0;
yP = 0;

%% 2) Compatibility along C-
K_minus = R.theta + R.nu;
nuP = K_minus - thetaP;   % since thetaP = 0

%% 3) Flow properties at point P
MP = M_from_PM(nuP);
mach_angleP = machAngle_from_M(MP);

%% 4) Characteristic slope (C-) from R to P
m_minus = tand( 0.5*((R.theta - R.mach_angle) + (thetaP - mach_angleP)) );

%% 5) Solve for x-coordinate using yP = 0
xP = R.x + (yP - R.y)/m_minus;

%% 6) Store output
P.x = xP;
P.y = yP;
P.theta = thetaP;
P.nu = nuP;
P.M = MP;
P.mach_angle = mach_angleP;

end