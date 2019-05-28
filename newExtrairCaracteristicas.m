function newExtrairCaracteristicas(net,imagesPath, originalDir, saveDir, filename)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% run('E:\vlsk\Deep Learning\matconvnet-1.0-beta22\matlab\vl_setupnn.m');
% net = load('E:\vlsk\Deep Learning\matconvnet-1.0-beta22\examples\vggfaces\vgg-face.mat');
% net = vl_simplenn_tidy(net) ;

subjects = dir(imagesPath);
for i=3:numel(subjects)
    lista{1,i-2} = subjects(i).name;
end

% label_names = cell(1, length(lista));
% for n = 1 : length(lista)
%     label_names{1, n} = lista(n).name;
% end

for n = 1 : numel(lista)
    disp('Extraindo características...');
    label = lista{1,n};
    disp(label);
    fid = fopen('lastname.txt', 'w');
    fprintf(fid, [filename '_' label]);
    fclose(fid);
    if n==1
        disp('Criando arquivo...');
        extrair_caracteristicas_por_pasta(net, fullfile(imagesPath, label), saveDir, n, filename);
    else
        extrair_caracteristicas_por_pasta(net, fullfile(imagesPath, label), saveDir, n, filename, [saveDir filename '\' filename '.mat']);
    end
    
    if ~strcmp([imagesPath '\'], originalDir)
        extrair_caracteristicas_por_pasta( net, fullfile(originalDir, label), saveDir, n, filename,[saveDir filename '\' filename '.mat']);
    end
    
end

end

