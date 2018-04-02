function [img1] = myImageFilterX(img0, h)

img0 = double(img0);
h = flipud(h); % flip horizontally
[irows,icols] = size(img0);
[hrows,hcols] = size(h);

t = (hrows-1)/2;
img0_padded = padarray(img0, [t,t]);

colI = im2col(img0_padded, [hrows,hcols]);
vecH = h(:); % convert matrix to vector
colH = repmat(vecH, [1,length(colI)]); % repeat the vector

img = [];
for i=1:length(colI)
    I = colI(:,i);
    H = colH(:,i);
    img(end+1) = dot(I,H);
end

img1 = reshape(img, [irows,icols]);

end