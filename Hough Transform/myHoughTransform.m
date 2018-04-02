function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
%Your implementation here
%Im - grayscale image - 
%threshold - prevents low gradient magnitude points from being included
%rhoRes - resolution of rhos - scalar
%thetaRes - resolution of theta - scalar

%%% Note: (row,col) = (-y,x)

[rows,cols] = size(Im);
maxRho = sqrt(rows^2 + cols^2);
H = zeros(round(maxRho/rhoRes)+1,round(2*pi/thetaRes)+1);

% threshold edge image
Im = Im.*(Im>threshold);

for i=1:cols
    for j=1:rows
        x = i;
        y = rows+1-j;
        if Im(y,x) ~= 0
            for theta=0:thetaRes:2*pi
                rho = round((x*cos(theta) + y*sin(theta))/rhoRes);
                if (rho > 0)
                    theta = round(theta/thetaRes);
                    H(rho+1,theta+1) = H(rho+1,theta+1)+1;
                end
            end
        end
    end
end

rhoScale = 0:rhoRes:maxRho;
thetaScale = 0:thetaRes:2*pi;

end
        
        
