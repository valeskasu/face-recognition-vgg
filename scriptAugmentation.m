clear
dirName = 'E:\TrainingSets\lfw\';
simDir = 'E:\TrainingSets\LFWDataAug\';
% 
% ops1 = combntns(1:3,1);
% for i = 1: size(ops1,1)
%     func_augmentationNotComb(dirName, ops1(i,:), simDir);
% end
% 
% copyfile([simDir 'NotComb\Bright'], [simDir 'Comb\Bright']);
% copyfile([simDir 'NotComb\Contr'], [simDir 'Comb\Contr']);
% copyfile([simDir 'NotComb\Mot'], [simDir 'Comb\Mot']);
% copyfile([simDir 'NotComb\Rot'], [simDir 'Comb\Rot']);
% copyfile([simDir 'NotComb\Sat'], [simDir 'Comb\Sat']);
% ops2 = combntns(1:3,2);
% 
% for i = 1: size(ops2,1)
%     func_augmentationComb(dirName, ops2(i,:), simDir);
%     func_augmentationNotComb(dirName, ops2(i,:), simDir);
% end
% ops3 = combntns(1:3,3);
% for i = 1: size(ops3,1)
%     func_augmentationComb(dirName, ops3(i,:),simDir);
%     func_augmentationNotComb(dirName, ops3(i,:),  simDir);
% 
% end

copyfile(dirName, [simDir 'NotComb\Original']);
