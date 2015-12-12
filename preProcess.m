function [im] = getColor(i)

%Gamma correction
im = igamm(i,2.2);

%Scaling the image (For faster processing)
im = iscale(im,0.5);

%Rank filtering to remove noise layer by layer
rl = irank(im(:,:,1), ones(3,3), 5);
gl = irank(im(:,:,2), ones(3,3), 5);
bl = irank(im(:,:,3), ones(3,3), 5);

%Concatenating the individual rank filtered layers
im = cat(3,rl,gl,bl);

%Displaying the image
idisp(im);
