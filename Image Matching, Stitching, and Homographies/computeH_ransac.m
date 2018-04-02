function [bestH2to1, inliers] = computeH_ransac(locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q3.3
N = size(locs1,1);
inliers = zeros(N,1);
bestIn = 0;
threshold = 20; %%
iterations = 500; %%

for i=1:iterations 
    % get four point correspondences (random)
    idx = randi(N,1,4);
    p1 = locs1(idx,:);
    p2 = locs2(idx,:);
    
    % compute homography
    H = computeH_norm(p1,p2);
    l1 = H*horzcat(locs2,ones(N,1))';
    l1 = (l1(1:2,:)./l1(3,:))';
    
    % count inliers
    dist = sqrt((l1(:,1)-locs1(:,1)).^2+(l1(:,2)-locs1(:,2)).^2);
    tempInliers = find(dist < threshold);
    in = length(tempInliers);
    
    if in > bestIn
        bestInliers = tempInliers;
        bestIn = in;
    end
end

% recompute H using all inliers
inliers(bestInliers) = 1;
p1 = locs1(bestInliers,:);
p2 = locs2(bestInliers,:);
bestH2to1 = computeH_norm(p1, p2);

%%%
end
