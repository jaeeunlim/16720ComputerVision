function residuals = rodriguesResidual(K1, M1, p1, K2, p2, x)
% rodriguesResidual:
% Inputs:
%   K1 - 3x3 camera calibration matrix 1
%   M1 - 3x4 projection matrix 1
%   p1 - Nx2 matrix of (x, y) coordinates
%   K2 - 3x3 camera calibration matrix 2
%   p2 - Nx2 matrix of (x, y) coordinates
%   x - (3N + 6)x1 flattened concatenation of P, r_2 and t_2

% Output:
%   residuals - 4Nx1 vector
N = size(p1,1);

% parse x
P = reshape(x(1:3*N,1),[N,3]);
P = horzcat(P,ones(N,1));
R2 = rodrigues(x(3*N+1:3*N+3,1));
t2 = x(3*N+4:end,1);
M2 = horzcat(R2,t2);

% estimated projection
p1_estimate = K1*M1*P';
p1_estimate = p1_estimate./p1_estimate(3,:);
p2_estimate = K2*M2*P';
p2_estimate = p2_estimate./p2_estimate(3,:);

% residuals
residuals = [p1-p1_estimate(1:2,:)'; p2-p2_estimate(1:2,:)'];
residuals = residuals(:);

end
