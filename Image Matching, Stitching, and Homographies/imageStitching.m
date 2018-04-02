function [panoImg] = imageStitching(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
img1c = img1(:,:,1:3);
img2c = img2(:,:,1:3);
img1g = rgb2gray(img1c);
img2g = rgb2gray(img2c);

% get BRIEF
[locs1, desc1] = briefLite(img1g);
[locs2, desc2] = briefLite(img2g);
ratio = 1;
matches = briefMatch(desc1, desc2, ratio);
locs1 = locs1(matches(:,1),:);
locs2 = locs2(matches(:,2),:);
[H2to1, inliers] = computeH_ransac(locs1, locs2);

H2to1/H2to1(3,3)
% warp image2
img2c = warpH(img2c, H2to1, size(img1c));

% overlay
img1c(find(img2c>0)) = img2c(find(img2c>0));
panoImg = img1c;

%%%

end