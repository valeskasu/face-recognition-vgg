function coluna = retorna_coluna_tabela_teste(total_classes, classe_atual, yfit)

for i=1:total_classes
    coluna(i,1) = numel(find(yfit==i));
end
end