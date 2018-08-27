clear all;
close all;
X = [+1 +1 (-1) (-1) (-1) +1 (-1) +1];
N = 4;
mi = 2;
ha = [1];
hb = [1 0.25];
hc = [1 0.25 0.50];
hd = [1 0.25 0.50 0.25];

snr = 100;
objetoOFDM = OFDM;

x_n = objetoOFDM.transmissor(X,N,mi)
canal_a = objetoOFDM.canal(x_n,ha,snr)
canal_b = objetoOFDM.canal(x_n,hb,snr)
canal_c = objetoOFDM.canal(x_n,hc,snr)
canal_d = objetoOFDM.canal(x_n,hd,snr)

X_hat_k_a = objetoOFDM.receptor(canal_a,ha,N,mi)
X_hat_k_b = objetoOFDM.receptor(canal_b,hb,N,mi)
X_hat_k_c = objetoOFDM.receptor(canal_c,hc,N,mi)
X_hat_k_d = objetoOFDM.receptor(canal_d,hd,N,mi)

%para comparacao 
infoa = real(X_hat_k_a);
infob = real(X_hat_k_b);
infoc = real(X_hat_k_c);
infod = real(X_hat_k_d);

figure()
subplot(511);
stem(X);
title('Informação original');
subplot(512);
stem(infoa,'r','linewidth',2);
title('Informação recebida que passou pelo canal ha');
ylim([-1 1]);
subplot(513);
stem(infob,'g','linewidth',2);
title('Informação recebida que passou pelo canal hb');
ylim([-1 1]);
subplot(514);
stem(infoc,'y','linewidth',2);
title('Informação recebida que passou pelo canal hc');
ylim([-1 1]);
subplot(515);
stem(infod,'k','linewidth',2);
title('Informação recebida que passou pelo canal hd');
ylim([-1.5 1.5]);

%destaque
figure()
stem(infod,'k','linewidth',2);
title('Informação recebida que passou pelo canal hd');
ylim([-1.5 1.5]);
