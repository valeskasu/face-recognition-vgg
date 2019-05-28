function func_augmentationNotComb(lista, dirName, operacoes)
% 1 - brightness
% 2 - contrast
% 3 - saturation
%lista: list with subjects names
%dirName: path to save augmented images


for i = 1:size(operacoes,2)
    switch operacoes(i)
        case 1
            simDir = strcat(simDir, 'Bright');
        case 2
            simDir = strcat(simDir, 'Contr');
        case 3
            simDir = strcat(simDir, 'Mot');
        case 4
            simDir = strcat(simDir, 'Rot');
        case 5
            simDir = strcat(simDir, 'Sat');
    end
end
mkdir(simDir);

for j = 1:size(operacoes,2)
    
    for i=1:numel(lista)
        diretorio = [simDir '\' lista{i}];
        mkdir(diretorio);
        
        switch operacoes(j)
            case 1
                imageBrightness([dirName '\' lista{i}], diretorio);
            case 2
                imageContrast([dirName '\' lista{i}], diretorio);
            case 3
                imageSaturation([dirName '\' lista{i}], diretorio);
        end
        
        
    end
    
    
end

