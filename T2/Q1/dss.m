%fazer superamostragem 
%c(t) = codigo
%x(t) = info
%s = tamanho 100000
%t = [0,Tb) com um milhão de pontos
%f = [-fa/2,fa/2]
clear all;
close all;
Nb = 800; % Numero de bits transmitidos
L = 200; % Periodo do pseudo-codigo
N = 10; % Numero de chips por bit de informacao
fc = 40e3; % frequencia da modulacao BPSK
Rb = 1e3; % taxa de bits
amostra_chip = 100; % Numero de amostras por chip

x_t = randi([0 1],1,Nb);
c_t = randi([0 1],1,L);
up = Nb*(amostra_chip*N); % taxa de amostragem
samples_bit = up/Rb; % numero de amostras
fa = Rb*samples_bit; % frequencia de amostragem
t = 0:up-1; % periodo

%superamostragem
filtro = ones(1,up);
x_t_up = filter(filtro,1, upsample(x_t,samples_bit));
%c_t_up = repmat(c_t,Nb/L);
%s_t = x_t_up.*c_t_up;

%plot
% subplot(4,1,1); plot(x_t)
% subplot(4,1,2); plot(c_t)
% subplot(4,1,3); plot(s_t)