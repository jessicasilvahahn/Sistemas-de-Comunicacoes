function ofdm_receptor(y,N,mi,h)
  %duvida
  %serial - paralelo
  col = length(y)/N;
  serial_paralelo = reshape(y,[N,col]);
  %remocao prefixo ciclico
  pref_ciclico = serial_paralelo([(N-mi+1) N],:)
  posicao = find(serial_paralelo==pref_ciclico)
  pref_ciclico(posicao,:) = []
  %fft
  %equalizacao
end