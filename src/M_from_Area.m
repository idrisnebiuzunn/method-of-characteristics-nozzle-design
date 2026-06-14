function M = M_from_Area(A_ratio, branch)
% M_from_Area
% Computes the Mach number from isentropic area ratio A/A*.
%
% Usage:
%   M = M_from_Area(A_ratio)                 % default: supersonic branch
%   M = M_from_Area(A_ratio, 'supersonic')
%   M = M_from_Area(A_ratio, 'subsonic')

if nargin < 2
    branch = 'supersonic';
end

if A_ratio < 1
    error('M_from_Area requires A_ratio >= 1');
end

if A_ratio == 1
    M = 1;
    return;
end

fun = @(M) Area_from_M(M) - A_ratio;

if strcmp(branch, 'subsonic')
    M = fzero(fun, [1e-8, 1 - 1e-8]);
elseif strcmp(branch, 'supersonic')
    M = fzero(fun, [1 + 1e-8, 50]);
else
    error('Unknown branch. Use ''subsonic'' or ''supersonic''.');
end

end
