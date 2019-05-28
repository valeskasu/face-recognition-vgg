function reconhecimentoVideo( modelFile, arquivoModel, nameSaveFile)
%
load([arquivoModel '.mat']);
load label_names.mat;
run('C:\Users\Valeska\Documents\Deep Learning\matconvnet-1.0-beta22\matlab\vl_setupnn.m');
net = load('C:\Users\Valeska\Documents\Deep Learning\matconvnet-1.0-beta22\examples\vggfaces\vgg-face.mat');
net = vl_simplenn_tidy(net) ;

[path, name, ext] = fileparts(modelFile);
vidObj = VideoReader(modelFile);
faceDetector = vision.CascadeObjectDetector;
fid = fopen([name 'deteccoes.csv'],'w');
fid2 = fopen([name 'frames4.csv'],'w');
vidWidth = vidObj.Width;
vidHeight = vidObj.Height;
numFrames = vidObj.NumberOfFrames;

outputVideo = VideoWriter([name '-output.avi']);

mkdir([name 'deteccaoPele']);
for i=1:numel(label_names)
    mkdir([name 'deteccaoPele/' label_names{i}]);
end
outputVideo.FrameRate = vidObj.FrameRate;
open(outputVideo);
cont = 0;
p4 = 0;
n = 0;

tempo = zeros(numFrames,1);
for i = 1:numFrames
    disp(['Frame ' int2str(i) ' de ' int2str(numFrames)]);
    tic

    cont1 = 0;
    I = read(vidObj, i);
    I_copia = I;
    I_copia2 = I;
    regiaoDePele = procuraPele(I, 15);
    [li2, co2] = find(regiaoDePele);
    x13 = min(li2);
    y13= min(co2);
    x23 = max(li2);
    y23 = max(co2);

    regiaoDeFace = I(x13:x23,y13:y23,:);
    bboxes = step(faceDetector, regiaoDeFace);
    if size(bboxes,1)~=0
        if( ~(isempty(x13)||isempty(x23)||isempty(y13)||isempty(y23)))
            bboxes(:,1) = bboxes(:,1)+y13;
            bboxes(:,2) = bboxes(:,2)+x13;
            anotacoesPorFrame(i) = struct('imgname', ['FRAME (' num2str(i) ').jpg'],'faces' , bboxes(:,:));
        end
    end
    
    for j = 1:size(bboxes,1)
%         j
        cont1 = cont1 + 1;
        croppada = imcrop(I_copia, bboxes(j,:));
        im_ = single(croppada) ; 
      im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
      im_ = bsxfun(@minus,im_,net.meta.normalization.averageImage) ;
      res = vl_simplenn(net, im_) ;
%       save('resultttt.mat','croppada','im_','res');
     for z=1:4096
        allfeatures(1,z) = res(35).x(1,1,z); %as colunas recebem os valores do vetor de 4096 dimensoes da camada 34
    end
        allfeatures=array2table(allfeatures);
        yfit = predict(trainedClassifierWeightedKNN13classes, allfeatures{:,trainedClassifierWeightedKNN13classes.PredictorNames});
        clear allfeatures;
        imwrite(croppada,[name 'deteccaoPele/' label_names{yfit} '/imagem(' int2str(i) '-' int2str(j) ').jpg']);
        I_copia2 = insertObjectAnnotation(I_copia2, 'rectangle', bboxes(j,:), label_names{yfit});
        fprintf(fid, '%d %d %d %d\n',bboxes(j,1), bboxes(j,2), bboxes(j,1)+...
            bboxes(j,3)-1, bboxes(j,2)+bboxes(j,4)-1);
        cont = cont+1;
        p4 = p4+1;
        
    end
    
    tempo(i,1) = toc;
    writeVideo(outputVideo,I_copia2);
    fprintf(fid2,'%d\n', cont1);
    exibir = [name 'Frame ' num2str(i)];
    disp(exibir);
end
%
anotacoesPorFrame=anotacoesPorFrame';
fprintf(fid2, '%d', cont );
close(outputVideo);
fclose(fid);
fclose(fid2);
save ([name 'anotacoes.mat'], 'anotacoesPorFrame');
end
