function imageContrast( dirName, simulationDir )

dirData = dir(dirName);      %# Get the data for the current directory
dirIndex = [dirData.isdir];  %# Find the index for directories
fileListName = {dirData(~dirIndex).name}';  %'# Get a list of the files

if ~isempty(fileListName)
    fileListFullPath = cellfun(@(x) fullfile(dirName,x),...  %# Prepend path to files
        fileListName,'UniformOutput',false);
end
% mkdir([simulationDir '/adjust']);
disp(dirName);
for i = 1:numel(fileListFullPath)
    if ~isempty(regexpi(fileListName{i},'.jpg')) || ~isempty(regexpi(fileListName{i},'.ppm'))
        I = imread(fileListFullPath{i});
%         im = imadjust(im, [0 0 0; 1 1 1], [0 0 0; 1 1 1]); normal
%         adjust contrast
        im1 = imadjust(I, [.2 .2 .2; 1 1 1], []); % increase contrast
        im2 = imadjust(I, [0 0 0; .8 .8 .8], []); % decrease contrast
        
        imwrite(im1,[simulationDir '/' fileListName{i} '-' int2str(2) '%incCon1).jpg']);
        imwrite(im2,[simulationDir '/' fileListName{i} '-' int2str(5) '%decCon2).jpg']);
        
    end
end


end
