function P = interior_point(R, L)
% interior_point
% R : point coming from right-running characteristic (C-)
% L : point coming from left-running characteristic (C+)

%% 1) Compatibility invariants
K_minus = R.theta + R.nu;   % along C-
K_plus  = L.theta - L.nu;   % along C+

%% 2) Flow properties at new point P
thetaP = 0.5*(K_minus + K_plus);
nuP    = 0.5*(K_minus - K_plus);

%% 3) Mach number and Mach angle
MP = M_from_PM(nuP);
mach_angleP = machAngle_from_M(MP);

%% 4) Characteristic slopes 
%anderson oyle diyor baba duz cizgiymis dusunecen\
%bu ustten gelen righta giden - olan
m_minus = tand( 0.5*((R.theta - R.mach_angle) + (thetaP - mach_angleP)) );
%bu alttan gelen lefte giden + olan
m_plus  = tand( 0.5*((L.theta + L.mach_angle) + (thetaP + mach_angleP)) );

%% 5) Coordinates of new point
xP = ((L.y - R.y) + m_minus*R.x - m_plus*L.x) / (m_minus - m_plus);
yP = R.y + m_minus*(xP - R.x);

%% 6) Store output
P.x = xP;
P.y = yP;
P.theta = thetaP;
P.nu = nuP;
P.M = MP;
P.mach_angle = mach_angleP;
end