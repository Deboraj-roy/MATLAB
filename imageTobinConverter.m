function DEB = imageTobinConverter(image)

figure
subplot(4,1,1);
imshow(image); 

title('Original Image');
subplot(4,1,2);

grimage = rgb2gray(image); 
grimageAdj = imadjust(grimage);

title('GrayScale Image');
  
binimage = imbinarize(grimageAdj); 
subplot(4,1,3);

imshow(binimage)
title('Binary Image');
s = sum(binimage,2);

subplot(4,1,4);
plot(s)
title('Sum of columns');

disp("Original binary matrix for Image:");
disp(binimage);

DEB = reshape(binimage, 1, numel(binimage));

end

