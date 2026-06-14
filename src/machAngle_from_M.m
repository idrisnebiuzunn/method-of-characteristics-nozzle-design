function mach_angle = machAngle_from_M(M)
% machAngle_from_M
% Computes Mach angle in degrees from Mach number

    if any(M < 1)
        error('Mach angle only valid for M >= 1');
    end

    mach_angle = asind(1./M);

end