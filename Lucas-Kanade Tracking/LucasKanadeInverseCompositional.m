function [u,v] = LucasKanadeInverseCompositional(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u, v] in the x- and y-directions.
It = im2double(It);
It1 = im2double(It1);

%% Pre-Compute
% Evaluate gradient Del T of the tamplate T(x)
x1 = rect(1); y1 = rect(2);
x2 = rect(3); y2 = rect(4);
[X,Y] = meshgrid(x1:x2,y1:y2);
T = interp2(It,round(X),round(Y));
[Tx, Ty] = gradient(T);
delT = [Tx(:),Ty(:)];

% Evaluate the Jacobian at (x;0) - skip since it is an identity matrix
% Compute the steepest descent images
A = delT;

% Compute the inverse Hessian matrix
H = A'*A;


%% Iterate
threshold = 1.25; 
delP = [1;1]; % start with value larger than threshold
p = [0;0];
while(norm(delP) > threshold)
    % Warp I with W(x;p) to compute I(W(x;p))
    x1 = x1+p(1); x2 = x2+p(1);
    y1 = y1+p(2); y2 = y2+p(2);
    [X,Y] = meshgrid(x1:x2,y1:y2);
    Iwarp = interp2(It1,round(X),round(Y)); 

    % Compute error image I(W(x;p)) - T(x)
    b = Iwarp - T;

    % Compute delta P
    delP = inv(H)*(A'*b(:));

    % Update warp
    p = p - delP;
end

u = p(1);
v = p(2);

end