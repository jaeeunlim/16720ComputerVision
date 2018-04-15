% Q4.2:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3

% Load data
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
load('../data/templeCoords.mat');
load('../data/intrinsics.mat');
load('q4_1.mat');

% Get correspondences
x2 = zeros(size(x1));
y2 = zeros(size(y1));
for i=1:length(x1)
    [x2(i), y2(i)] = epipolarCorrespondence(I1, I2, F, x1(i), y1(i));
end
pts1 = horzcat(x1,y1);
pts2 = horzcat(x2,y2);

% Triangulate
E = essentialMatrix(F, K1, K2);
M1 = horzcat(eye(3),zeros(3,1));
M2s = camera2(E);

% Find correct M
C1 = K1*M1;
for i=1:4
    M2 = M2s(:,:,i);
    C2 = K2*M2;
    [P, ~] = triangulate( C1, pts1, C2, pts2 );
    if all (P(:,3) > 0)
        % Save data
        save('q4_2.mat','F','M1','M2','C1','C2');
        break;
    end
end

% Visualize
figure();
scatter3(P(:,1),P(:,2),P(:,3));
