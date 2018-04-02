function [Im Io Ix Iy] = myEdgeFilter(img, sigma)

% Gaussian kernal
hsize = 2*ceil(3*sigma)+1;
h = fspecial('gaussian',hsize,sigma);

% Smooth image
smoothI = myImageFilter(img, h);

fy = (1/8)*[1 2 1; 0 0 0; -1 -2 -1]; % y oriented Sobel filter
fx = fy'; % x oriented Sobel filter

Ix = myImageFilter(smoothI, fx);
Iy = myImageFilter(smoothI, fy);
Io = atan2(Iy,Ix);
Im = (Ix.^2+Iy.^2).^(1/2);

% non-maximal suppression
cases = [0, pi/4, pi/2, 3*pi/4];
[rows,cols] = size(Im);

mask0 = [0 0 0; 1 1 1; 0 0 0];
mask45 = [0 0 1; 0 1 0; 1 0 0];
mask90 = [0 1 0; 0 1 0; 0 1 0];
mask135 = [1 0 0; 0 1 0; 0 0 1];

dilatedIm0 = imdilate(Im,mask0);
dilatedIm45 = imdilate(Im,mask45);
dilatedIm90 = imdilate(Im,mask90);
dilatedIm135 = imdilate(Im,mask135);

for i=1:rows
    for j=1:cols
        elem = Io(i,j);
        [m,idx] = min(abs(sign(elem)*cases-elem));
        
        if idx==1 % 0 degree
            dilatedP = dilatedIm0(i,j);
        elseif idx==2 % 45 degrees
            if sign(elem) < 0
                dilatedP = dilatedIm135(i,j);
            else
                dilatedP = dilatedIm45(i,j);
            end
        elseif idx==3 % 90 degrees
            dilatedP = dilatedIm90(i,j);
        else % 135 degrees
            if sign(elem) < 0
                dilatedP = dilatedIm45(i,j);
            else
                dilatedP = dilatedIm135(i,j);
            end
        end
        
        if Im(i,j) ~= dilatedP
            Im(i,j) = 0;
        end
    end
end

end