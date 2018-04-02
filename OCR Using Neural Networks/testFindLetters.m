img1 = imread('../images/01_list.jpg');
[lines, bw] = findLetters(img1);

img2 = imread('../images/02_letters.jpg');
[lines, bw] = findLetters(img2);

img3 = imread('../images/03_haiku.jpg');
[lines, bw] = findLetters(img3);

img4 = imread('../images/04_deep.jpg');
[lines, bw] = findLetters(img4);
