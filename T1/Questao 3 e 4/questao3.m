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
figure()
scatterplot(bpsk);
X = bpsk;
objetoOFDM = OFDM;
x_n = objetoOFDM.transmissor(X,N,mi);
for r = 0:SNR
    x_recebido = awgn(x_n,r,'measured');
    y = objetoOFDM.canal(x_recebido,h);
    X_hat_k = objetoOFDM.receptor(y,h,N,mi);
    %taxa de erro de bit
    info_recebida = X_hat_k > 0; %pq e bpsk
    [num_x_hat(r+1), taxa(r+1)] = biterr(info,info_recebida);
    Pb_teorico(r+1) = qfunc(sqrt(2.*(10^(r/10))));
end
figure();
hold on;
semilogy(0:SNR,taxa);
semilogy(0:SNR,Pb_teorico);
hold off;
