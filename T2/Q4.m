%obs matlab 2012 da problema
clear all;
close all;
m = 7;
Nb = 100000; % Numero de bits transmitidos
L = 2.^m - 1; % Periodo do pseudo-codigo
N = L; % Numero de chips por bit de informacao
chips_amostras = 1;
amostras_bits = chips_amostras*N;
estado_inicial = [1 0 0 0 0 0 0]; %igual ao tamanho de m, estado inicial qualquer
h =  [2 -0.5 0.5]; %canal
SNR = 10;
x = randi([0 1], 1,Nb);
x_n = kron(x*2-1,ones([1,L]));
objetoLFSR = LFSR;
%geracao de codigo, lembrando que o codigo é ciclico
%para m = 7, tabela 7.1 livro
taps = [7 6 5 4 2 1];
%geracao de codigo, lembrando que o codigo é ciclico
codigo = (objetoLFSR.lfsr(estado_inicial,taps,m));
codigo = (codigo.*2 -1);
codigo = repmat(codigo,1,Nb); 
s = codigo.*x_n;
%passa pelo canal
s_hat = filter(h,1,s);
Eb = sum(s_hat.^2)/Nb;
for ruido = 1:SNR
    %gerar ruido linearmente
    ruido_linear= Eb/10^((ruido)/10);
    ruido_gerado = randn(1,length(s_hat)).*sqrt(ruido_linear/2);
    %adicionando ruido
    r = s_hat + ruido_gerado; 
    y = r.*codigo;
    aux = reshape(y,[amostras_bits,Nb]); %127 x 100000 (dividindo a representacao de cada bit)
    correlator = sum(aux)./amostras_bits;
    %limiar
    y_rec  = correlator > 0;
    [num_x_hat(ruido+1), taxa(ruido+1)] = biterr(x,y_rec);
    Pb_teorico(ruido+1) = qfunc(sqrt(2.*(10^(ruido/10))));
  
end

figure();
semilogy(0:SNR,taxa,'r');
hold on;
semilogy(0:SNR,Pb_teorico,'g');
hold off;
legend('Desempenho simulado','Desempenho teórico');
xlabel('Eb/N0');
ylabel('Pb');
title('Análise de Desempenho')

