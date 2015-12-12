function [calibration_circles large_blue_circle] = getCalibration(b2d)

%Finding all the blue circles/blobs
calibration_circles = iblobs(b2d, 'area', [1000 1000000]);

%Finding the large blue circle
area = calibration_circles.area;
[maxarea area_index] = max(area);
large_blue_circle = calibration_circles(area_index);
