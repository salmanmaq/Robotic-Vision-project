%This is the script you need to run. It gets everything done.
%Please acknowledge the author Salman Maqbool if you use this script in its original form or edit it and use it. A note of thanks
%at salmanmaq@gmail.com will be appreciated.
%You can also contact me on my email for any queries and help.
%This script isn't very robust as the threshhols for getColor function will have to be changed for any variation of the image.

clear all
clc
close all

%Importing the image
i = iread('rvf.jpg','double');

%Pre-processing the image
%NOTE: Mex files in Machine Vision Toolbox (MVTB) directory /mex need to be built using make.m for the irank function in preProcess to work. You can....
%....comment out the line below but that will change the results a little due to different thresholds required for both cases
i = preProcess(i);

%Getting the binary images
r2d = getColor(i,'r');
g2d = getColor(i,'g');
b2d = getColor(i,'b');

%Getting all the shape blobs
%Red blobs
small_red_circle = getShape(r2d,'c','s');
large_red_circle = getShape(r2d,'c','l');
small_red_square = getShape(r2d,'s','s');
large_red_square = getShape(r2d,'s','l');
small_red_triangle = getShape(r2d,'t','s');
large_red_triangle = getShape(r2d,'t','l');

red_shapes = [small_red_circle,large_red_circle,small_red_square,large_red_square,small_red_triangle,large_red_triangle];
red_shapes.plot_box('g');

%Green blobs
small_green_circle = getShape(g2d,'c','s');
large_green_circle = getShape(g2d,'c','l');
small_green_square = getShape(g2d,'s','s');
large_green_square = getShape(g2d,'s','l');
small_green_triangle = getShape(g2d,'t','s');
large_green_triangle = getShape(g2d,'t','l');

green_shapes = [small_green_circle,large_green_circle,small_green_square,large_green_square,small_green_triangle,large_green_triangle];
green_shapes.plot_box('b');

all_shapes = [red_shapes green_shapes];

%Getting the blue calibration circles
[blue_calibration_circles large_blue_circle] = getCalibration(b2d);
blue_calibration_circles.plot('r*');
large_blue_circle.plot('g*');


%Getting the homography matrix
[H p2] = getHomography(blue_calibration_circles);

%Plotting the warped homographic image
figure(2);
wimg = homwarp(H,i,'full');
idisp(wimg);

%Getting the blobs centroids in pixel coordinates
pcentroid = all_shapes.p;

%Getting the blobs centroids in Cartesian coordinates
ccentroid = homtrans(H,pcentroid);

%Printing the output results
clc
fprintf('================================================================\n');
fprintf('Red 2D Objects\t\tBlob pos (pixels)\t\tXY Pos (mm)\n');
fprintf('1: Small Circle\t\t(%0.2f,%0.2f)\t\t\t(%0.2f,%0.2f)\n',pcentroid(1,1),pcentroid(2,1),ccentroid(1,1),ccentroid(2,1));
fprintf('2: Large Circle\t\t(%0.2f,%0.2f)\t\t\t(%0.2f,%0.2f)\n',pcentroid(1,2),pcentroid(2,2),ccentroid(1,2),ccentroid(2,2));
fprintf('3: Small Square\t\t(%0.2f,%0.2f)\t\t(%0.2f,%0.2f)\n',pcentroid(1,3),pcentroid(2,3),ccentroid(1,3),ccentroid(2,3));
fprintf('4: Large Square\t\t(%0.2f,%0.2f)\t\t\t(%0.2f,%0.2f)\n',pcentroid(1,4),pcentroid(2,4),ccentroid(1,4),ccentroid(2,4));
fprintf('5: Small Triangle\t(%0.2f,%0.2f)\t\t\t(%0.2f,%0.2f)\n',pcentroid(1,5),pcentroid(2,5),ccentroid(1,5),ccentroid(2,5));
fprintf('6: Large Triangle\t(%0.2f,%0.2f)\t\t\t(%0.2f,%0.2f)\n',pcentroid(1,6),pcentroid(2,6),ccentroid(1,6),ccentroid(2,6));
fprintf('================================================================\n');
fprintf('Green 2D Objects\tBlob pos (pixels)\t\tXY Pos (mm)\n');
fprintf('1: Small Circle\t\t(%0.2f,%0.2f)\t\t\t(%0.2f,%0.2f)\n',pcentroid(1,7),pcentroid(2,7),ccentroid(1,7),ccentroid(2,7));
fprintf('2: Large Circle\t\t(%0.2f,%0.2f)\t\t\t(%0.2f,%0.2f)\n',pcentroid(1,8),pcentroid(2,8),ccentroid(1,8),ccentroid(2,8));
fprintf('3: Small Square\t\t(%0.2f,%0.2f)\t\t\t(%0.2f,%0.2f)\n',pcentroid(1,9),pcentroid(2,9),ccentroid(1,9),ccentroid(2,9));
fprintf('4: Large Square\t\t(%0.2f,%0.2f)\t\t(%0.2f,%0.2f)\n',pcentroid(1,10),pcentroid(2,10),ccentroid(1,10),ccentroid(2,10));
fprintf('5: Small Triangle\t(%0.2f,%0.2f)\t\t\t(%0.2f,%0.2f)\n',pcentroid(1,11),pcentroid(2,11),ccentroid(1,11),ccentroid(2,11));
fprintf('6: Large Triangle\t(%0.2f,%0.2f)\t\t(%0.2f,%0.2f)\n',pcentroid(1,12),pcentroid(2,12),ccentroid(2,12),ccentroid(2,12));
