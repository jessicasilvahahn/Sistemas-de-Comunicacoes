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
codigo.c = C*2-1
% Informacao: b
%b = randi([0 1], 1,codigo.n)
b= [0 1 1 1 0 0 1];
r = awgn(b, 10);
r_polar = r*2-1
objeto_sindrome = Sindrome;
u_estimado = objeto_sindrome.SDD(r,codigo) 