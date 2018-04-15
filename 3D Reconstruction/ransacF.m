function [ F, inliers ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q5.1:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using eightpoint
%          - using ransac

%     In your writeup, describe your algorithm, how you determined which
%     points are inliers, and any other optimizations you made

bestIn = 0;
iterations = 1000;
threshold = 0.0015;
N = size(pts1,1);

for i=1:iterations
    % get 8 point correspondences
    idx = randi(N,1,8);
    p1 = pts1(idx,:);
    p2 = pts2(idx,:);
    
    % compute F
    tempF = eightpoint(p1,p2,M);
    
    % count inliers
    in = 0;
    tempInliers = [];
    for j=1:N
        x1 = horzcat(pts1(j,:), 1);
        x2 = horzcat(pts2(j,:), 1);
        num = x2*tempF*x1';
        if abs(num) < threshold
            in = in + 1;
            tempInliers(end+1) = j;
        end
    end
    
    if in > bestIn
        F = tempF;
        bestIn = in;
        inliers = tempInliers';
    end
end

end

