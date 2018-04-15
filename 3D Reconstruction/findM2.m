% Q3.3:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, C2, p1, p2, R and P to q3_3.mat

% Load data: images, point correspondences, Ks
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
load('../data/some_corresp.mat');
load('../data/intrinsics.mat');

% Get essential matrix
M = max(length(I1),length(I2));
F = eightpoint(pts1, pts2, M);
E = essentialMatrix(F, K1, K2);

% Get Ms
M1 = horzcat(eye(3),zeros(3,1));
M2s = camera2(E);

% Find correct M
C1 = K1*M1;
for i=1:4
    M2 = M2s(:,:,i);
    C2 = K2*M2;
    [ P, err ] = triangulate( C1, pts1, C2, pts2 );
    if all (P(:,3) > 0)
        % Save data
        save('q3_3.mat','M2','C2','pts1','pts2','P');
        break;
    end
end
