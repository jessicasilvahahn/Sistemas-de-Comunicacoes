taps = [1 3]; 
estado = [1 0 0 ]; %nao pode ser [0 0 0] %estado inicial
m = 3; % número de bits de estado

objetoLFSR = LFSR;

%geracao de codigo, lembrando que o codigo é ciclico
codigo = objetoLFSR.lfsr(estado,taps,m)