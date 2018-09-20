taps = [1 3]; 
estado = [1 0 0 ]; %nao pode ser [0 0 0] %estado inicial
%n_xor = length(taps)-1; % Numero de xors a ser feito
m = 3; % número de bits de estado
numero_estados = 2.^m -1; % Numero de estados 
saida = ones(1,numero_estados); % igual saida do codigo
%xor = mod(sum(estado(taps),2) %somatorio modulo 2
for i=1:numero_estados
   entrada = mod(sum(estado(taps)),2); %xor
   saida(i) = estado(end);
   deslocamento = circshift(estado,numero_estados,2)
   deslocamento(1) = entrada;
   estado = deslocamento;
   
end; 