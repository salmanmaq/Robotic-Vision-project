function [H p2] = getHomography(calibration_circles)

%The real world cenroids of the calibration circles are defined in p1 in Cartesian coordinates. Units are in mm. Please not that these are in a
% particular order based on the order of blue_calibration_circles obtained earlier.
p1= [20,20;20,200;20,380;200,20;200,380;200,200;380,380;380,200;380,20]';

%Getting the pixel coordinates of the centroids
p2 = calibration_circles.p;

%Getting the homography matrix
H = homography(p2,p1);
