function [composite_img] = compositeH(H2to1, template, img)

template = warpH(template, inv(H2to1), size(img), 0);
img(find(template~=0)) = template(find(template~=0));
composite_img = img;

end