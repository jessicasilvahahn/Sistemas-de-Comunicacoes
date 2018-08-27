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

x_t = randi([0 1],1,Nb)*2-1;
c_t = randi([0 1],1,L)*2-1;
up = amostra_chip*N; % numero de amostras por bit
fa = Rb*up; % frequencia de amostragem (numero de amostras por segundo)
dur = Nb/Rb;
Ta = 1/fa;
t = 0:Ta:dur-Ta; %tempo

%superamostragem
filtro = ones(1,up);
x_t_up = filter(filtro,1, upsample(x_t,up));
filtro_c = ones(1,amostra_chip);
c_t_up = filter(filtro_c,1, upsample(c_t,amostra_chip));
c_t_up = repmat(c_t_up,1,length(x_t_up)/length(c_t_up));
s_t = x_t_up.*c_t_up;

%plot
% subplot(4,1,1); plot(x_t)
% subplot(4,1,2); plot(c_t)
% subplot(4,1,3); plot(s_t)