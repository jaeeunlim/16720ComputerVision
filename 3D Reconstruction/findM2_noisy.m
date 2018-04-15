% Q5.3:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, C2, p1, p2, R and P to q3_3.mat

close all;

% Load data: images, point correspondences, Ks
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
load('../data/some_corresp_noisy.mat');
load('../data/intrinsics.mat');

% Get essential matrix
M = max(length(I1),length(I2));
[F,inliers] = ransacF(pts1, pts2, M);
E = essentialMatrix(F, K1, K2);
p1 = pts1(inliers,:);
p2 = pts2(inliers,:);

% Get Ms
M1 = eye(3,4);
M2s = camera2(E);

% Find correct M
C1 = K1*M1;
for i=1:4
    M2 = M2s(:,:,i);
    C2 = K2*M2;
    [P, ~] = triangulate( C1, p1, C2, p1 );
    if all (P(:,3) > 0)
        break;
    end
end

[M2_opt,P_opt] = bundleAdjustment(K1,M1,p1,K2,M2,p2,P);

% images
figure(); scatter3(P(:,1),P(:,2),P(:,3));
figure(); scatter3(P_opt(:,1),P_opt(:,2),P_opt(:,3));

% reprojection errors
N = size(p1,1);
proj1 = C1*horzcat(P,ones(N,1))';
proj1 = proj1(1:2,:)./proj1(3,:);
proj2 = C2*horzcat(P,ones(N,1))';
proj2 = proj2(1:2,:)./proj2(3,:);
err = sum(sum((p1-proj1').^2 + (p2-proj2').^2))

proj1 = C1*horzcat(P_opt,ones(N,1))';
proj1 = proj1(1:2,:)./proj1(3,:);
proj2 = C2*horzcat(P_opt,ones(N,1))';
proj2 = proj2(1:2,:)./proj2(3,:);
err_opt = sum(sum((p1-proj1').^2 + (p2-proj2').^2))