clear all;
close all;
n = 7
codigo.k = 4;
codigo.G = [1 0 0 0 1 1 0; 0 1 0 0 1 0 1; 0 0 1 0 0 1 1; 0 0 0 1 1 1 1];
codigo.lut = [0 0 0 0 0 0 0 0 0 0; 0 0 1 0 0 0 0 0 0 1; 0 1 0 0 0 0 0 0 1 0; 
    1 0 0 0 0 0 0 1 0 0; 1 1 1 0 0 0 1 0 0 0; 0 1 1 0 1 0 0 0 0 0;
    1 1 0 1 0 0 0 0 0 0];

codigo.h = [1 1 0 1 1 0 0; 1 0 1 1 0 1 0; 0 1 1 1 0 0 1];
objeto_sindrome = Sindrome;
b = randi([0 1],1,n);
u = objeto_sindrome.HDD(b,codigo);

figure()
subplot(211);
stem(b,'r');
title('Informação Recebida (b)');
subplot(212);
stem(u,'k');
title('Informação Decodificada usando HDD');
