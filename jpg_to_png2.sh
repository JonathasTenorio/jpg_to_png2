#!/bin/bash

converte_imagem(){
    local caminho_imagem=$1
    local imagem_sem_extensao=$(ls $caminho_imagem | awk -F. '{ print $1 }') # recebe o nome do arquivo e armazena o nome sem a extensão
    convert $imagem_sem_extensao.jpg $imagem_sem_extensao.png #converte o arquivo para png e armazena dentro do diretorio png
    }

varrer_diretorio(){
    cd $1
    for arquivo in *
    do
        local caminho_arquivo=$(find ~/imagens-novos-livros -name $arquivo)
        echo $caminho_arquivo
        if [ -d $caminho_arquivo ]
        then
            varrer_diretorio $caminho_arquivo
        else
            converte_imagem $caminho_arquivo
        fi
    done
}


varrer_diretorio ~/imagens-novos-livros # Chama a função e armazena os erros em um arquivo chamado erros_conversao.txt


if [ $? -eq 0 ] #verifica o resultado da execução da função
then
    echo "Conversão realizada com sucesso" # Não houve erros, resultado igual a 0
else
    echo "Houve uma falha no processo de conversão" # Houve erros, resultado foi igual a 1
fi