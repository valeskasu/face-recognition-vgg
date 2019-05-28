function imageBrightness( dirName, simulationDir )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% disp(dirName);
% disp(simulationDir);
dirData = dir(dirName);      %# Get the data for the current directory
dirIndex = [dirData.isdir];  %# Find the index for directories
fileListName = {dirData(~dirIndex).name}';  %'# Get a list of the files

if ~isempty(fileListName)
    fileListFullPath = cellfun(@(x) fullfile(dirName,x),...  %# Prepend path to files
        fileListName,'UniformOutput',false);
else
    disp(dirName);
end


for i = 1:numel(fileListFullPath)
    if ~isempty(regexpi(fileListName{i},'.jpg')) || ~isempty(regexpi(fileListName{i},'.ppm'))
        I = imread(fileListFullPath{i});
        HSV = rgb2hsv(I);
        
        im1 = HSV;
        im1(:,:,3) = HSV(:,:,3)*0.8; %diminuir brilho em 20 por cento
        im1(im1>1)=1;
        im1 = hsv2rgb(im1);
        
        im2 = HSV;
        im2(:,:,3) = HSV(:,:,3)*1.2; %aumentar o brilho em 20 por cento
        im2(im3>1)=1;
        im2 = hsv2rgb(im2);
        
        
        imwrite(im1,[simulationDir '/' fileListName{i} '-20decreasedBrightness.jpg']);
        imwrite(im2,[simulationDir '/' fileListName{i} '-20inscreasedBrightness.jpg']);
        
    end
end

end

