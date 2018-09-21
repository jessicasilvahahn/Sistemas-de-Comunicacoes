%obs matlab 2012 da problema
clear all;
close all;
m = 7;
Nb = 100000; % Numero de bits transmitidos
L = 2.^m - 1; % Periodo do pseudo-codigo
N = L; % Numero de chips por bit de informacao
estado_inicial = [0 0 0 0 0 0 1]; %igual ao tamanho de L, estado inicial qualquer
h =  [2 -0.5 0.5]; %canal
SNR = 10;
x = kron(randi([0 1],1,Nb)*2-1,ones([1,L]));

objetoLFSR = LFSR;
%geracao de codigo, lembrando que o codigo é ciclico
for i=1:3
        taps = objetoLFSR.rand_vetor(i);
        %geracao de codigo, lembrando que o codigo é ciclico
        codigos{i} = objetoLFSR.lfsr(estado_inicial,taps,m)
        codigos{i} = repmat(codigos{i},1,Nb); 
        
end

