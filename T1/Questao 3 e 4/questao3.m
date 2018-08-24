close all; 
clear all;
N = 16;
mi = 4;
L = 50e3;
n = N*L;
SNR = 10;
h = [2 -0.5 0.5];
%PSK 
M = 2;
info = randint(1,n,M);
%bpsk
bpsk = pskmod(info,M);
scatterplot(bpsk);
X = bpsk;
objetoOFDM = OFDM;
x_n = objetoOFDM.transmissor(X,N,mi);
for r = 0:SNR
    %passa pelo canal
    y = objetoOFDM.canal(x_n,h,r);
    X_hat_k = objetoOFDM.receptor(y,h,N,mi);
    %taxa de erro de bit
    info_recebida = pskdemod(X_hat_k,M); %demodula psk
    [num_x_hat(r+1), taxa(r+1)] = biterr(info,info_recebida);
    Pb_teorico(r+1) = qfunc(sqrt(2.*(10^(r/10))));
end
figure();
semilogy(0:SNR,taxa,'r');
hold on;
semilogy(0:SNR,Pb_teorico,'g');
hold off;
legend('Desempenho simulado','Desempenho teórico');
xlabel('Eb/N0');
ylabel('Pb');
