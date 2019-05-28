function final_image = procuraPele( img, size_window)
%procuraPele retorna uma imagem binária em que pixels brancos indicam
%presença de pele
%   img é a imagem de entrada
% size window é a largura da janela(bloco)
final_image = zeros(size(img,1), size(img,2));
if(mod(size(img,1),size_window)~=0)
    ind_altura = size(img,1)-size_window-mod(size(img,1),size_window);
else
    ind_altura = size(img,1)-size_window;
end

if(mod(size(img,2),size_window)~=0)
    ind_largura = size(img,2)-size_window-mod(size(img,2),size_window);
else
    ind_largura = size(img,2)-size_window;
end
if(size(img, 3) > 1)
    for i = 1:size_window:ind_altura
        
        for j = 1:size_window:ind_largura
            janela=zeros(size_window,size_window);
            
            regiao_atual = img(i:i+size_window-1,j:j+size_window-1,:);
            for x=1:size(regiao_atual,1)
                for y=1:size(regiao_atual,2)
                    R = regiao_atual(x,y,1);
                    G = regiao_atual(x,y,2);
                    B = regiao_atual(x,y,3);
                    if ~(R > 180 && G > 180 && B > 180) %pixels brancos
                        if(R > 20 && G > 30 && B < 100)
                            
                            if( R > G && R > B)
                                %it is a skin
                                janela(x,y) = 1;
                                
                            end
                            %
                        end
                        
                    end
                    
                    
                    
                end
            end
            
            if(size(find(janela),1)>0.5*size_window*size_window)
                final_image(i:i+size_window-1,j:j+size_window-1)=janela;
            end
            %             pause
        end
        
    end
    
end
end