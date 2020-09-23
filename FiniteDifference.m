function [out] = FiniteDifference(cr, cc, vm, cellsize)
%FINITEDIFFERENCE the third-order finite difference method (also called Horn¡¯s method)
%   cr is the row number of the central cell.
%   cc is the column number of the central cell.
%   vm is the vector matrix that consist of (X, Y)
%   cellsize is the resolution of the raster.


% see the formula (1) in paprer.
fx =(([vm(cr - 1, cc + 1, 1), vm(cr - 1, cc + 1, 2)] - [vm(cr - 1, cc - 1, 1), vm(cr - 1, cc - 1, 2)])...
    + 2.* ([vm(cr, cc + 1, 1), vm(cr, cc + 1, 2)] - [vm(cr, cc - 1, 1), vm(cr, cc - 1, 2)])...
    + ([vm(cr + 1, cc + 1, 1), vm(cr + 1, cc + 1, 2)] - [vm(cr + 1, cc - 1, 1), vm(cr + 1, cc - 1, 2)]))./(8.*cellsize);

fy =(([vm(cr + 1, cc - 1, 1), vm(cr + 1, cc - 1, 2)] - [vm(cr - 1, cc - 1, 1), vm(cr - 1, cc - 1, 2)])...
    + 2.* ([vm(cr + 1, cc, 1), vm(cr + 1, cc, 2)] - [vm(cr - 1, cc, 1), vm(cr - 1, cc, 2)])...
    + ([vm(cr + 1, cc + 1, 1), vm(cr + 1, cc + 1, 2)] - [vm(cr - 1, cc + 1, 1), vm(cr - 1, cc + 1, 2)]))./(8.*cellsize);

% see formula (6) in paper.
key = sqrt(norm(fx).^2 + norm(fy).^2);
out = atan(key).*(180./pi);

end

