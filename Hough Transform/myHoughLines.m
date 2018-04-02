function [rhos, thetas] = myHoughLines(H, nLines)

% Non-maximal suppression
[rows,cols] = size(H);
mask = ones(3);
dilatedH = imdilate(H,mask);
newH = H.*(H==dilatedH);

% Find lines
rhos = zeros(nLines,1);
thetas = zeros(nLines,1);
count = 0;
while(count<nLines)
    [m,i] = max(newH(:));
    [row,col] = ind2sub(size(newH),i);
    newH(row,col) = 0;
    rhos(count+1) = row;
    thetas(count+1) = col;
    count = count+1;
end

end
        