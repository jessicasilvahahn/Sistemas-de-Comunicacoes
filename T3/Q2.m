% Código de Hamming
codigo.n = 7;
codigo.k = 4;
% Taxa do código
R = codigo.k/codigo.n;
% Matriz geradora
Ik = eye(k,k);
p = [1 1 0;1 0 1;0 1 1;1 1 1];
codigo.G = [Ik,p];
% Palavras código
u_decimal = [0:2^codigo.k-1];
codigo.u = de2bi(u_decimal,codigo.k,2,'left-msb');
% Código de bloco
C = mod(codigo.u*codigo.G,2);
codigo.c = (C*2)-1;
% Informação: b
b = randi([0 1], 1,codigo.n)
b_polar = (b*2)-1;
r = awgn(b_polar,1);
objeto_sindrome = Sindrome;
u_estimado = objeto_sindrome.SDD(r,codigo)