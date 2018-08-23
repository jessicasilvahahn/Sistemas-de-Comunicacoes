%fazer superamostragem 
%c(t) = codigo
%x(t) = info
%s = tamanho 100000
%t = [0,Tb) com um milhão de pontos
%f = [-fa/2,fa/2]
clear all;
close all;
Nb = 1e3;
L = 200;
N = 10;
fc = 40e3;
Rb = 1e3;
amostra_chip = 100;
bits = randi([0 1],1,Nb);
codigo = randi([0 1],1,L);
up = Nb*(amostra_chip*N);
samples_bit = up/Rb;
fa = Rb*samples_bit;
t = 0:up-1;
%superamostragem
filtro = ones(1,up);
bits_up = filter(filtro,1, upsample(bits,sample_bit));
%repmat - replicar 5 vezes
% codigo tem que ser replicado para ser periodico ate ficar com mesmo
% tamanho de x
