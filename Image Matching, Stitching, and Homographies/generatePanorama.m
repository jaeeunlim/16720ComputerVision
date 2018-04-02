function im3 = generatePanorama(im1, im2)

% get homography
im1g = rgb2gray(im1);
im2g = rgb2gray(im2);
[locs1, desc1] = briefLite(im1g);
[locs2, desc2] = briefLite(im2g);
ratio = 1;
matches = briefMatch(desc1, desc2, ratio);
locs1 = locs1(matches(:,1),:);
locs2 = locs2(matches(:,2),:);
[H2to1, inliers] = computeH_ransac(locs1, locs2);
H2to1/H2to1(3,3)
% stitch images
[im3] = imageStitching_noClip(im1, im2, H2to1);

end