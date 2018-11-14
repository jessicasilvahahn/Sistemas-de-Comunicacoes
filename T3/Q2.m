clear all;
close all;
% Codigo de Hamming
codigo.n = 7;
codigo.k = 4;
% Taxa do codigo
R = codigo.k/codigo.n;
% Matriz geradora
codigo.G = [1 0 0 0 1 1 0; 0 1 0 0 1 0 1; 0 0 1 0 0 1 1; 0 0 0 1 1 1 1];
% Palavras codigo
u_decimal = [0:2^codigo.k-1];
codigo.u = dec2bin(u_decimal);
% Codigo de bloco
C = mod(codigo.u*codigo.G,2)
codigo.c = (C*2)-1
% Informacao: b
b = randi([0 1], 1,codigo.n);
r = awgn(b, 60);
r_polar = r*2-1
objeto_sindrome = Sindrome;
u_estimado = objeto_sindrome.SDD(r,codigo);

figure()
subplot(211);
stem(b,'r');
title('Informação Recebida (b)');
subplot(212);
stem(u_estimado,'k');
title('Informação Decodificada usando SDD');