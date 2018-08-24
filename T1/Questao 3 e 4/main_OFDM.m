X = [+1 +1 (-1) (-1) (-1) +1 (-1) +1];
N = 4;
mi = 2;
ha = 1;
hb = [1 0.25];
hc = [1 0.25 0.50];
hd = [1 0.25 0.50 0.25];
snr = 100;
objetoOFDM = OFDM;
x_n = objetoOFDM.transmissor(X,N,mi);
X_hat_k_a = objetoOFDM.receptor(x_n,ha,N,mi)
X_hat_k_b = objetoOFDM.receptor(x_n,hb,N,mi)
X_hat_k_c = objetoOFDM.receptor(x_n,hc,N,mi)
X_hat_k_d = objetoOFDM.receptor(x_n,hd,N,mi)

%para comparacao 
infoa = real(X_hat_k_a)
infob = real(X_hat_k_b)
infoc = real(X_hat_k_c)
infod = real(X_hat_k_d)