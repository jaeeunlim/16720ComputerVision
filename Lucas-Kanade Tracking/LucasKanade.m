function [u,v] = LucasKanade(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u, v] in the x- and y-directions.

It = im2double(It);
It1 = im2double(It1);

x1 = floor(rect(1)); y1 = floor(rect(2));
x2 = floor(rect(3)); y2 = floor(rect(4));
[X,Y] = meshgrid(x1:x2,y1:y2);
T = interp2(It,X,Y);

%% Iterate
[Ix,Iy] = gradient(double(It1));
threshold = 0.5; 
delP = [1;1]; % start with value larger than threshold
p = [0;0];
n = 0;
while(norm(delP) > threshold && n < 100)
    % Warp I with W(x;p) to compute I(W(x;p))
    Iwarp = It1(y1+p(2):y2+p(2),x1+p(1):x2+p(1)); 
    
    % Compute error image I(W(x;p)) - T(x)
    b = T - Iwarp;
    
    % Warp gradient Del I with W(x;p)
    delIx = Ix(y1+p(2):y2+p(2),x1+p(1):x2+p(1));
    delIy = Iy(y1+p(2):y2+p(2),x1+p(1):x2+p(1));
    delI = double([delIx(:),delIy(:)]);

    % Evaluate the Jacobian at (x;0) - skip since it is an identity matrix
    % Compute the steepest descent images
    A = delI;

    % Compute the inverse Hessian matrix
    H = A'*A;

    % Compute delta P
    delP = inv(H)*(A'*b(:));

    % Update warp
    p = p + delP;
    n = n + 1;
end

u = p(1);
v = p(2);

end
