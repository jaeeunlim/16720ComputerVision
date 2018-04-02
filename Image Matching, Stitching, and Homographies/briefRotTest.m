im1 = rgb2grayscale(imload('../data/model_chickenbroth.jpg'));
[locs1, desc1] = briefLite(im1);

ratio = 0.8; %%
angles = linspace(10,350,10);
n = length(angles);
correctMatches = zeros(1,n);

for i=1:n
    angle = angles(i);
    im2 = imrotate(im1,angle);
    
    [locs2, desc2] = briefLite(im2);
    matches = briefMatch(desc1, desc2, ratio);
    
    correctMatches(i) = ; %%
end

figure();
plot(angles, correctMatches);
xlabel('Rotation (degree)');
ylabel('Correct Matches');
