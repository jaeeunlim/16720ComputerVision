function [M2, P] = bundleAdjustment(K1, M1, p1, K2, M2_init, p2, P_init)
% bundleAdjustment:
% Inputs:
%   K1 - 3x3 camera calibration matrix 1
%   M1 - 3x4 projection matrix 1
%   p1 - Nx2 matrix of (x, y) coordinates
%   K2 - 3x3 camera calibration matrix 2
%   M2_init - 3x4 projection matrix 2
%   p2 - Nx2 matrix of (x, y) coordinates
%   P_init: Nx3 matrix of 3D coordinates
%
% Outputs:
%   M2 - 3x4 refined from M2_init
%   P - Nx3 refined from P_init
R2 = M2_init(:,1:3);
t2 = M2_init(:,end);
x_init = vertcat(P_init(:),invRodrigues(R2),t2);
fun = @(x) rodriguesResidual(K1, M1, p1, K2, p2, x);
x = lsqnonlin(fun,x_init);

N = size(p1,1);
P = reshape(x(1:3*N,1),[N,3]);
R2 = rodrigues(x(3*N+1:3*N+3,1));
t2 = x(3*N+4:end,1);
M2 = horzcat(R2,t2);

end
