
X = [+1 +1 (-1) (-1) -1 +1 -1 +1]
N = 4
mi = 2
col = length(X)/N;
serial_paralelo = reshape(X,[N,col]); %serial para parelo dividindo em 4 subcanais com 2 símbolos
inversa = ifft(serial_paralelo,N,1)
pref_ciclico = inversa([(N-mi+1) N],:)
Info_ciclico = [pref_ciclico;inversa]
%paralelo serial
paralelo_serial = reshape(Info_ciclico,1,[]);   
x = paralelo_serial
h = [1 0.25]
snr = 100
n = length(x);
conv_circular = filter(h,1,x) %convolucao
y = awgn(conv_circular,snr)

%serial - paralelo
col = length(y)/(N+mi)
serial_paralelo2 = reshape(y,[N+mi,col])
%remocao prefixo ciclico
serial_paralelo2([1:mi],:) = []
%fft
Y = fft(serial_paralelo2)
H = fft(h,N) %pega todas as frequencias
H_t = H.'
rep = repmat(H_t,1,size(Y,2))
% %equalizacao
X_hat = Y./rep

%paralelo_serial
paralelo_serial2 = reshape(X_hat,1,[])