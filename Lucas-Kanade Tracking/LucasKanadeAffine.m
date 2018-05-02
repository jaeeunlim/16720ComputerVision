function M = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 
% output - M affine transformation matrix

It = im2double(It);
It1 = im2double(It1);

%% Pre-Compute
% Evaluate gradient Del T of the tamplate T(x)
x1 = 1; y1 = 1;
x2 = size(It,2); y2 = size(It,1);
T = It;
[Tx, Ty] = gradient(T);
delT = [Tx(:),Ty(:)];

% Evaluate the Jacobian at (x;0)
J = [1 1 0 0 0 0;
     0 0 0 1 1 0];

% Compute the steepest descent images
A = delT*J;

% Compute the inverse Hessian matrix
H = A'*A;


%% Iterate
threshold = 1.25;
delP = [1;1;1;1;1;1]; % start with value larger than threshold
p = [0;0;0;0;0;0];
while(norm(delP) > threshold)
    % Warp I with W(x;p) to compute I(W(x;p))
    M = [1+p(1), p(2), p(3); p(4), 1+p(5), p(6); 0, 0, 1];
    m = affine2d(inv(M));
    Iwarp = imwarp(It1,m);

    % Compute error image I(W(x;p)) - T(x)
    b = Iwarp - T;

    % Compute delta P
    delP = inv(H)*(A'*b(:));

    % Update warp
    p = p - delP;
end

end
