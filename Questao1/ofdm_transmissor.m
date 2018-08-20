function ofdm_transmissor(X,N,mi)
  col = length(X)/N;
  serial_paralelo = reshape(X,[N,col]); %serial para parelo dividindo em 4 subcanais com 2 símbolos
  inversa = ifft(serial_paralelo,N,1)
  pref_ciclico = inversa([(N-mi+1) N],:)
  Info_ciclico = [pref_ciclico;inversa]
  %paralelo serial
  paralelo_serial = reshape(Info_ciclico,1,[]);   
end
