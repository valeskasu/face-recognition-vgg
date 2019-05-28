function extrair_caracteristicas_por_pasta( net, dirName, saveDir, label, filename, features)
%Funcao que extrai características dada uma pasta contendo imagens cortadas
%de um mesmo individuo e a label correspondente

% run('E:\vlsk\Deep Learning\matconvnet-1.0-beta22\matlab\vl_setupnn.m');
% net = load('E:\vlsk\Deep Learning\matconvnet-1.0-beta22\examples\vggfaces\vgg-face.mat');
% net = vl_simplenn_tidy(net) ;
dirData = dir(dirName);      %# Get the data for the current directory
dirIndex = [dirData.isdir];  %# Find the index for directories
fileList = {dirData(~dirIndex).name}';  %'# Get a list of the files
if ~isempty(fileList)
    fileList = cellfun(@(x) fullfile(dirName,x),...  %# Prepend path to files
        fileList,'UniformOutput',false);
end

if(nargin == 5)
    inicio_for = 1;
    final_for = numel(fileList);
else
    load(features);
    inicio_for = size(allfeatures,1)+1;
    final_for = size(allfeatures,1)+numel(fileList);
    tamanho_features = size(allfeatures,1);
end

for i=inicio_for:final_for
    if(nargin == 5)
        im = imread(fileList{i}) ;
        %disp(fileList{i});
    else
        im = imread(fileList{i-tamanho_features}) ;
        %disp(fileList{i-tamanho_features});
    end
    im = imag_improve_rgb(im);%comepnsaçao de iluminaçao
    im_ = single(im) ; % note: 255 range
    im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
    im_ = bsxfun(@minus,im_,net.meta.normalization.averageImage) ;
    res = vl_simplenn(net, im_) ;
    labels(i,1) = label; %recebe a label
    for j=1:4096
        allfeatures(i,j) = res(35).x(1,1,j); %as colunas recebem os valores do vetor de 4096 dimensoes da camada 34
    end
    
end
allfeaturestable = array2table(allfeatures);
allfeaturestable.Group = labels;
if 7~=exist(saveDir, 'dir')
    mkdir(saveDir);
end
saveDir = [saveDir filename];

disp(saveDir)
if 7~=exist(saveDir, 'dir')
    mkdir(saveDir);
end

save([saveDir '\' filename '.mat'], 'allfeaturestable','allfeatures', 'labels');
%save ('E:\TrainingSets\Single_Sample_Training\adjust_motblur_comb\motion_blur.mat','allfeaturestable','allfeatures', 'labels');

end

