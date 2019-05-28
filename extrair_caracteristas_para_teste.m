function allfeatures = extrair_caracteristas_para_teste( dirName )
%Extrai caracteristicas e retorna o vetor com as mesmas

run('E:\vlsk\Deep Learning\matconvnet-1.0-beta22\matlab\vl_setupnn.m');
net = load('E:\vlsk\Deep Learning\matconvnet-1.0-beta22\examples\vggfaces\vgg-face.mat');
net = vl_simplenn_tidy(net) ;

dirData = dir(dirName);      %# Get the data for the current directory
  dirIndex = [dirData.isdir];  %# Find the index for directories
  fileList = {dirData(~dirIndex).name}';  %'# Get a list of the files
  if ~isempty(fileList)
    fileList = cellfun(@(x) fullfile(dirName,x),...  %# Prepend path to files
                       fileList,'UniformOutput',false);
  end
  
  for i=1:numel(fileList)
%       i
      disp(fileList{i});
      im = imread(fileList{i}) ;
      im = imag_improve_rgb(im);%compensacao de iluminaço
      im_ = single(im) ; % note: 255 range
      im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
      im_ = bsxfun(@minus,im_,net.meta.normalization.averageImage) ;
      res = vl_simplenn(net, im_) ;
      %     allfeatures(1,1) = 1; %primeira coluna recebe a label
      for j=1:4096
          allfeatures(i,j) = res(35).x(1,1,j); %as colunas 1 a 4096 recebem os valores do vetor de 4096 dimensoes da camada 35
      end
  end
  
  allfeatures=array2table(allfeatures);

end

