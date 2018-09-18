close all; 
clear all;
N = 64;
mi = 16;
Rb = 16e6;
L = 100;
n = N*L;
SNR = 100;
h = [(2/sqrt(5)) 0 1/sqrt(5)];
%BPSK 
M = 2;
info = randint(1,n,M);
%bpsk
X = pskmod(info,M);
objetoOFDM = OFDM;
x_n = objetoOFDM.transmissor(X,N,mi);
y = objetoOFDM.canal(x_n,h,SNR);
%superamostragem/interpolacao
up = 10;
%para o tempo
y_up = interp1(0:length(y)-1,y,0:1/up:length(y)-(1/up),'spline');
x_up = interp1(0:length(x_n)-1,x_n,0:1/up:length(x_n)-(1/up),'spline');
%para frequencia com a anterior da um comportamento estranho
y_up_f = resample(y,up,1); 
x_up_f = resample(x_n,up,1);
Rs = Rb + Rb*(mi/N); %por causa do acrescimo do pc
fa = Rs*up;
ta = 1/fa;
aux = (N+mi)*L*up;
t = 0:ta:aux*ta-ta;
%para pegar um bloco
tamanho_ofdm = (N+mi)*up;
vetor = [-length(t)/2:length(t)/2-1];
f = vetor*fa/2;
%frequencia
X_n = fft(x_up_f);
Y = fft(y_up_f);
figure();
subplot(411);
plot(t(1:tamanho_ofdm),abs(x_up(1:tamanho_ofdm)));
title('Sinal de Saída do Transmissor no Domínio do Tempo')
subplot(412);
plot(f,10*log10(fftshift(abs(X_n))));
title('Sinal de Saída do Transmissor no Domínio da Frequência')
subplot(413);
plot(t(1:tamanho_ofdm),abs(y_up(1:tamanho_ofdm)));
title('Sinal de Saída do Canal no Domínio do Tempo')
subplot(414);
plot(f,10*log10(fftshift(abs(Y)))); %para ficar em DB
title('Sinal de Saída do Canal no Domínio da Frequência')

