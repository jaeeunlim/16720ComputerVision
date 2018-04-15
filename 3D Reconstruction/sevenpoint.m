function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - 7x2 matrix of (x,y) coordinates
%   pts2 - 7x2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup
N = size(pts1,1);

% Normalize points
pts1_norm = pts1/M;
pts2_norm = pts2/M;

% Construct Nx9 matrix A
x1 = pts1_norm(:,1);
y1 = pts1_norm(:,2);
x2 = pts2_norm(:,1);
y2 = pts2_norm(:,2);
N = size(pts1,1);
A = [x2.*x1 x2.*y1 x2 y2.*x1 y2.*y1 y2 x1 y1 ones(N,1)];

% Find F
[~,~,v] = svd(A'*A);
F1 = reshape(v(:,8),[3 3])';
F2 = reshape(v(:,9),[3 3])';

% Enforce rank 2 constraint on F
syms lam
f = det(F1 + lam*F2);
lambda = solve(f,lam);
lambda = double(lambda);

if lambda(1) == lambda(2)
    F = cell(1);
    F{1} = F1 + lambda(3)*F2;
elseif lambda(2) == lambda(3)
    F = cell(1);
    F{1} = F1 + lambda(1)*F2;
else
    F = cell(3,1);
    F{1} = F1 + lambda(1)*F2;
    F{2} = F1 + lambda(2)*F2;
    F{3} = F1 + lambda(3)*F2;
end

% Unnormalize F
T = diag([1/M 1/M 1]);
for i=1:length(F)
    F{i} = T'*F{i}*T; 
end

end

