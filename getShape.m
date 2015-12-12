function [blobs] = getShape(binaryImage,shape,bulk)

%Getting the blobs from the binary image (Area paramter is chosen such that small blobs(noise) and the background blob are automatically excluded
blobs = iblobs(binaryImage, 'area', [1000 1000000]);

%Getting the circularity of the blobs
circ = blobs.circularity;

%Selecting blobs based on shape and size
if (strcmp(shape,'Square') || strcmp(shape,'square') || strcmp(shape,'S') || strcmp(shape,'s'))
	square_blobs_index = circ > 0.8 & circ < 0.9;
	blobs = blobs(square_blobs_index);
	area = blobs.area;
	if (strcmp(bulk,'Small') || strcmp(bulk,'small') || strcmp(bulk,'S') || strcmp(bulk,'s'))
		[minarea area_index] = min(area);
		blobs = blobs(area_index);
	elseif (strcmp(bulk,'Large') || strcmp(bulk,'large') || strcmp(bulk,'L') || strcmp(bulk,'l'))
		[maxarea area_index] = max(area);
		blobs = blobs(area_index);
	end
elseif (strcmp(shape,'Circle') || strcmp(shape,'circle') || strcmp(shape,'C') || strcmp(shape,'c'))
	circle_blobs_index = circ > 0.91;
	blobs = blobs(circle_blobs_index);
	area = blobs.area;
	if (strcmp(bulk,'Small') || strcmp(bulk,'small') || strcmp(bulk,'S') || strcmp(bulk,'s'))
		[minarea area_index] = min(area);
		blobs = blobs(area_index);
	elseif (strcmp(bulk,'Large') || strcmp(bulk,'large') || strcmp(bulk,'L') || strcmp(bulk,'l'))
		[maxarea area_index] = max(area);
		blobs = blobs(area_index);
	end
elseif (strcmp(shape,'Triangle') || strcmp(shape,'triangle') || strcmp(shape,'T') || strcmp(shape,'t'))
	triangle_blobs_index = circ > 0.6 & circ < 0.7;
	blobs = blobs(triangle_blobs_index);
	area = blobs.area;
	if (strcmp(bulk,'Small') || strcmp(bulk,'small') || strcmp(bulk,'S') || strcmp(bulk,'s'))
		[minarea area_index] = min(area);
		blobs = blobs(area_index);
	elseif (strcmp(bulk,'Large') || strcmp(bulk,'large') || strcmp(bulk,'L') || strcmp(bulk,'l'))
		[maxarea area_index] = max(area);
		blobs = blobs(area_index);
	end
end
