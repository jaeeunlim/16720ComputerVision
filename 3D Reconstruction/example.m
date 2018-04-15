% %% Q2.1
% I1 = imread('../data/im1.png');
% I2 = imread('../data/im2.png');
% load('../data/some_corresp.mat');
% M = max(length(I1),length(I2));
% F = eightpoint(pts1, pts2, M);
% displayEpipolarF(I1, I2, F);
% save('q2_1.mat','F','M','pts1','pts2');

% %% 2.2
% I1 = imread('../data/im1.png');
% I2 = imread('../data/im2.png');
% % h = cpselect(I1,I2);
% pts1 = [65.65 134.95; 479.83 101.23; 
%         519.96 236.08; 224.58 377.35; 
%         117.02 332.40; 144.31 208.79; 
%         447.72 395.01];
% pts2 = [67.25 123.71; 468.59 99.63;
%         519.96 184.71; 226.18 393.40;
%         123.44 319.56; 139.49 178.29;
%         460.56 406.25];
% M = max(length(I1),length(I2));
% F = sevenpoint(pts1, pts2, M);
% F = F{2}
% displayEpipolarF(I1, I2, F);
% save('q2_2.mat','F','M','pts1','pts2');

% %% 3.1
% load('../data/intrinsics.mat');
% load('q2_1.mat');
% [ E ] = essentialMatrix( F, K1, K2 );

% %% 4.1
% I1 = imread('../data/im1.png');
% I2 = imread('../data/im2.png');
% load('../data/some_corresp.mat');
% M = max(length(I1),length(I2));
% F = eightpoint(pts1, pts2, M);
% [coordsIM1, coordsIM2] = epipolarMatchGUI(I1, I2, F);
% save('q4_1.mat','F','pts1','pts2');

% %% 5.1
% I1 = imread('../data/im1.png');
% I2 = imread('../data/im2.png');
% load('../data/some_corresp_noisy.mat');
% M = max(length(I1),length(I2));
% F = eightpoint(pts1, pts2, M);
% displayEpipolarF(I1, I2, F);
% % [F,inliers] = ransacF( pts1, pts2, M );
% % displayEpipolarF(I1, I2, F);

