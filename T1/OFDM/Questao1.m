clear all;
close all;
X = [+1 +1 (-1) (-1) (-1) +1 (-1) +1];
N = 4;
mi = 2;
objetoOFDM = OFDM;
x_n = objetoOFDM.transmissor(X,N,mi)  
