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
fc = 40e3; %freq portadora
x_t = randi([0 1],1,Nb)*2-1;
c_t = randi([0 1],1,L)*2-1;
up = amostra_chip*N; % numero de amostras por bit
fa = Rb*up; % frequencia de amostragem (numero de amostras por segundo)
dur = Nb/Rb;
Ta = 1/fa;
t = 0:Ta:dur-Ta; %tempo
pt = cos(2*pi*fc*t);
%superamostragem
filtro = ones(1,up);
x_t_up = filter(filtro,1, upsample(x_t,up));
filtro_c = ones(1,amostra_chip);
c_t_up = filter(filtro_c,1, upsample(c_t,amostra_chip));
c_t_up = repmat(c_t_up,1,length(x_t_up)/length(c_t_up));
s_t = x_t_up.*c_t_up;
psk = s_t.*pt;

%ver melhor vetor de frequencia
%frequencia
vetor = [-length(t)/2:length(t)/2-1];
f = vetor*fa/2;
X = fft(x_t_up);
C = fft(c_t_up);
S = fft(s_t);
PSK = fft(psk);
%tempo
figure()
subplot(411);
plot(t,x_t_up,'r');
title('Sinal x(t)')
xlim([0 4*1/up]);
subplot(412);
plot(t,c_t_up);
title('Sinal c(t)')
xlim([0 4*1/up]);
subplot(413);
plot(t,s_t,'g');
xlim([0 4*1/up]);
title('Sinal s(t)')
subplot(414);
plot(t,psk,'k');
xlim([0 4*1/up]);
title('Sinal s_b_p_s_k_(_t_)');

figure();
plot(f,fftshift(abs(PSK))); 
