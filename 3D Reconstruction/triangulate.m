function [ P, err ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

%       P - Nx3 matrix of 3D coordinates
%       err - scalar of the reprojection error

% Q4.2:
%       Implement a triangulation algorithm to compute the 3d locations
%

% triangulation
N = size(p1,1);
P = zeros(N,3);
A = zeros(4,4);
for i=1:N
    A(1,:) = p1(i,2)*C1(3,:)' - C1(2,:)';
    A(2,:) = C1(1,:)' - p1(i,1)*C1(3,:)';
    A(3,:) = p2(i,2)*C2(3,:)' - C2(2,:)';
    A(4,:) = C2(1,:)' - p2(i,1)*C2(3,:)';
    [~,~,v] = svd(A'*A);
    P(i,:) = v(1:3,end)'/v(4,end);
end

% reprojection error
proj1 = C1*horzcat(P,ones(N,1))';
proj1 = proj1(1:2,:)./proj1(3,:);
proj2 = C2*horzcat(P,ones(N,1))';
proj2 = proj2(1:2,:)./proj2(3,:);
err = sum(sum((p1-proj1').^2 + (p2-proj2').^2));

end
