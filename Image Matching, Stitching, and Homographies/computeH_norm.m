function [H2to1] = computeH_norm(p1, p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation

% translate the mean of the points to teh origin
meanX1 = mean(p1(:,1));
meanY1 = mean(p1(:,2));
p1(:,1) = p1(:,1) - meanX1;
p1(:,2) = p1(:,2) - meanY1;
meanX2 = mean(p2(:,1));
meanY2 = mean(p2(:,2));
p2(:,1) = p2(:,1) - meanX2;
p2(:,2) = p2(:,2) - meanY2;

% scale the points so that the largest distance to the origin is sqrt(2)
[~,I] = max(p1(:,1).^2+p1(:,2).^2);
scale1 = sqrt(2)/sqrt(p1(I,1)^2+p1(I,2)^2);
p1 = scale1*p1;
[~,I] = max(p2(:,1).^2+p2(:,2).^2);
scale2 = sqrt(2)/sqrt(p2(I,1)^2+p2(I,2)^2);
p2 = scale2*p2;

% similarity transforms
T1 = [scale1 0 -meanX1*scale1;
      0 scale1 -meanY1*scale1;
      0 0 1];
T2 = [scale2 0 -meanX2*scale2;
      0 scale2 -meanY2*scale2;
      0 0 1];

% compute homography matrix
H = computeH(p1, p2);
H2to1 = inv(T1)*H*T2;


%%%

end