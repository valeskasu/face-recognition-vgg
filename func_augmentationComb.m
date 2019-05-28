function func_augmentationComb(dirName, operacoes, simDir)
% Funcion that generates augmented images with the combined joining method
%dirName: source path where are the input images
%operacoes - lista de numeros onde cada numero corresponde a uma operacao
% 1 - brightness
% 2 - contrast
% 3 - saturation
% simDir: destination path to save the resulting images
%

subjects = dir(dirName);
for i=3:numel(subjects)
    lista{i-2} = subjects(i).name;
end
mkdir(simDir);
simDir = [simDir 'Comb\'];
mkdir(simDir);

for i = 1:size(operacoes,2)-1
    switch operacoes(i)
        case 1
            simDir = strcat(simDir, 'Bright');
        case 2
            simDir = strcat(simDir, 'Contr');
        case 3;
        case 5
            simDir = strcat(simDir, 'Sat');
    end
end
dirName = simDir;

switch operacoes(size(operacoes,2))
        case 1
            simDir = strcat(simDir, 'Bright');
        case 2
            simDir = strcat(simDir, 'Contr');
        case 3
            simDir = strcat(simDir, 'Sat');
end
mkdir(simDir);



for i=1:numel(lista)
    diretorio = [simDir '\' lista{i}];
    mkdir(diretorio);
    
    switch operacoes(size(operacoes,2))
        case 1
            imageBrightness([dirName '\' lista{i}], diretorio);
        case 2
            imageContrast([dirName '\' lista{i}], diretorio);
        case 3
            imageSaturation([dirName '\' lista{i}], diretorio);
    end
    
end



end
