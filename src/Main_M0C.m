clear; clc; close all;

%% =========================================================
%  MAIN SCRIPT - SUPERSONIC MINIMUM-LENGTH NOZZLE BY MOC
%
%  Purpose:
%    Generate a planar minimum-length supersonic nozzle contour
%    directly from a prescribed exit Mach number using the
%    Method of Characteristics (MOC).
%
%  Required helper functions:
%    PM_from_M.m
%    M_from_PM.m
%    machAngle_from_M.m
%    centerline_point.m
%    interior_point.m
%    wall_point_design_from_Cplus.m
%    make_point_from_K.m
%
%  Notes:
%    - This script builds the planar MOC nozzle first.
%    - The output contour is the upper wall of a minimum-length nozzle.
%    - If desired, the final geometry can be uniformly scaled to a
%      prescribed throat height and/or target nozzle length.
%% =========================================================

%% ---------------------------------------------------------
% 1) USER SETTINGS
%% ---------------------------------------------------------
M_exit = 2.4;             % prescribed supersonic exit Mach number
Nchar = 10;               % number of characteristic lines in initial fan
theta_first = 0.375;      % small initial wall turning angle [deg]
throat_height = 1.0;      % planar throat half-height [m]
target_nozzle_length =16; % optional: set [] to keep natural MOC length

%% ---------------------------------------------------------
% 2) EXIT PM ANGLE AND MAXIMUM WALL TURNING
%% ---------------------------------------------------------
nu_exit = PM_from_M(M_exit);
theta_w_max = 0.5 * nu_exit;
theta_fan = linspace(theta_first, theta_w_max, Nchar);

%% ---------------------------------------------------------
% 3) INITIAL CENTERED EXPANSION FAN FROM THROAT CORNER
%
% For a centered Prandtl-Meyer fan starting at sonic conditions:
%   nu = theta
%   K_minus = theta + nu = 2*theta
%   K_plus  = theta - nu = 0
%% ---------------------------------------------------------
Fan = cell(Nchar, 1);

for i = 1:Nchar
    K_minus = 2 * theta_fan(i);
    K_plus = 0;

    Fan{i} = make_point_from_K(K_minus, K_plus);
    Fan{i}.x = 0;
    Fan{i}.y = throat_height;
end

%% ---------------------------------------------------------
% 4) CENTERLINE POINTS
%
% Centerline condition:
%   theta = 0
%
% Incoming C- from Fan{i} carries K_minus.
%% ---------------------------------------------------------
Center = cell(Nchar, 1);

for i = 1:Nchar
    K_minus = Fan{i}.theta + Fan{i}.nu;
    K_plus = -K_minus;

    Center{i} = make_point_from_K(K_minus, K_plus);
    Center{i}.theta = 0;

    CenterGeom = centerline_point(Fan{i});
    Center{i}.x = CenterGeom.x;
    Center{i}.y = CenterGeom.y;
end

%% ---------------------------------------------------------
% 5) INTERIOR POINTS
%% ---------------------------------------------------------
P = cell(Nchar - 1, Nchar - 1);

for i = 1:Nchar - 1
    P{i, 1} = interior_point(Fan{i + 1}, Center{i});
end

for j = 2:Nchar - 1
    npts = Nchar - j;
    for i = 1:npts
        R = P{i + 1, j - 1};
        L = P{i, j - 1};
        P{i, j} = interior_point(R, L);
    end
end

%% ---------------------------------------------------------
% 6) STRAIGHTENING WALL POINTS
%
% Minimum-length nozzle design:
%   wall straightens the flow until final theta = 0 at exit.
%% ---------------------------------------------------------
K_minus_wall = 2 * theta_w_max;
Wall = cell(Nchar + 1, 1);

Wall{1} = Fan{Nchar};

for i = 1:Nchar - 1
    F = P{i, Nchar - i};
    Wall{i + 1} = wall_point_design_from_Cplus(F, Wall{i}, K_minus_wall);
end

Wall{Nchar + 1} = wall_point_design_from_Cplus(Center{Nchar}, Wall{Nchar}, K_minus_wall);

%% ---------------------------------------------------------
% 7) OPTIONAL GEOMETRIC SCALING
%
% The contour obtained up to this point is already the planar
% minimum-length nozzle (MLN) solution for the prescribed M_exit.
% The scaling block below is optional and only changes the physical
% size of the geometry. It does not change the MOC flow solution,
% characteristic structure, or exit Mach number.
%
% Leave target_nozzle_length = [] to keep the natural MLN length.
%% ---------------------------------------------------------
if ~isempty(target_nozzle_length)
    scale_factor = target_nozzle_length / Wall{end}.x;

    for i = 1:Nchar
        Fan{i}.x = Fan{i}.x * scale_factor;
        Fan{i}.y = Fan{i}.y * scale_factor;
        Center{i}.x = Center{i}.x * scale_factor;
        Center{i}.y = Center{i}.y * scale_factor;
    end

    for j = 1:Nchar - 1
        for i = 1:(Nchar - j)
            P{i, j}.x = P{i, j}.x * scale_factor;
            P{i, j}.y = P{i, j}.y * scale_factor;
        end
    end

    for i = 1:Nchar + 1
        Wall{i}.x = Wall{i}.x * scale_factor;
        Wall{i}.y = Wall{i}.y * scale_factor;
    end
else
    scale_factor = 1.0;
end

%% ---------------------------------------------------------
% 8) WALL ARRAYS AND BASIC RESULTS
%% ---------------------------------------------------------
x_wall = zeros(Nchar + 1, 1);
y_wall = zeros(Nchar + 1, 1);

for i = 1:Nchar + 1
    x_wall(i) = Wall{i}.x;
    y_wall(i) = Wall{i}.y;
end

throat_height_final = y_wall(1);
exit_height_final = y_wall(end);
length_final = x_wall(end);
height_ratio = exit_height_final / throat_height_final;
M_exit_from_wall = Wall{end}.M;

%% ---------------------------------------------------------
% 9) PLOT
%% ---------------------------------------------------------
figure;
hold on; grid on; axis equal;

h_wall = plot(x_wall, y_wall, 'k-', 'LineWidth', 2);
h_centerline = plot([0, max(x_wall) * 1.05], [0, 0], 'k:');

has_cminus = false;
for i = 1:Nchar
    h = plot([Fan{i}.x, Center{i}.x], [Fan{i}.y, Center{i}.y], 'g-');
    if ~has_cminus
        h_cminus = h;
        has_cminus = true;
    end
end

has_cplus = false;
for i = 1:Nchar - 1
    plot([Fan{i + 1}.x, P{i, 1}.x], [Fan{i + 1}.y, P{i, 1}.y], 'g-');
    h = plot([Center{i}.x, P{i, 1}.x], [Center{i}.y, P{i, 1}.y], 'm-');
    if ~has_cplus
        h_cplus = h;
        has_cplus = true;
    end
end

for j = 2:Nchar - 1
    npts = Nchar - j;
    for i = 1:npts
        plot([P{i + 1, j - 1}.x, P{i, j}.x], [P{i + 1, j - 1}.y, P{i, j}.y], 'g-');
        plot([P{i, j - 1}.x, P{i, j}.x], [P{i, j - 1}.y, P{i, j}.y], 'm-');
    end
end

for i = 1:Nchar - 1
    F = P{i, Nchar - i};
    plot([F.x, Wall{i + 1}.x], [F.y, Wall{i + 1}.y], 'm-');
end

plot([Center{Nchar}.x, Wall{Nchar + 1}.x], ...
     [Center{Nchar}.y, Wall{Nchar + 1}.y], 'm-');

h_center_points = gobjects(Nchar, 1);
for i = 1:Nchar
    h_center_points(i) = plot(Center{i}.x, Center{i}.y, ...
        'bs', 'MarkerFaceColor', 'b', 'MarkerSize', 6);
end

h_interior = [];
for j = 1:Nchar - 1
    for i = 1:(Nchar - j)
        h = plot(P{i, j}.x, P{i, j}.y, 'ro', ...
            'MarkerFaceColor', 'r', 'MarkerSize', 5);
        if isempty(h_interior)
            h_interior = h;
        end
    end
end

h_wall_points = gobjects(Nchar + 1, 1);
for i = 1:Nchar + 1
    h_wall_points(i) = plot(Wall{i}.x, Wall{i}.y, ...
        'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 6);
end

xlabel('x [m]');
ylabel('y [m]');
title(sprintf('Minimum-Length Supersonic Nozzle by MOC (M_{exit} = %.3f)', M_exit), ...
    'Interpreter', 'tex');

legend([h_wall, h_centerline, h_cminus, h_cplus, h_center_points(1), h_interior, h_wall_points(1)], ...
       {'Designed wall', 'Centerline', 'C- characteristics', 'C+ characteristics', ...
        'Centerline points', 'Interior points', 'Wall points'}, ...
       'Location', 'bestoutside');

%% ---------------------------------------------------------
% 10) DISPLAY RESULTS
%% ---------------------------------------------------------
fprintf('--- SUPERSONIC MOC NOZZLE RESULTS ---\n');
fprintf('M_exit (target)          = %.6f\n', M_exit);
fprintf('M_exit (from last wall)  = %.6f\n', M_exit_from_wall);
fprintf('nu_exit                  = %.6f deg\n', nu_exit);
fprintf('theta_w_max              = %.6f deg\n', theta_w_max);
fprintf('Nchar                    = %d\n', Nchar);
fprintf('Scale factor             = %.6f\n', scale_factor);
fprintf('Throat height            = %.6f m\n', throat_height_final);
fprintf('Exit height              = %.6f m\n', exit_height_final);
fprintf('Exit/Throat height ratio = %.6f\n', height_ratio);
fprintf('Nozzle length            = %.6f m\n', length_final);

%% ---------------------------------------------------------
% 11) OPTIONAL EXPORT
%% ---------------------------------------------------------
wall_data = [x_wall, y_wall];
save('moc_wall_contour.txt', 'wall_data', '-ascii');
