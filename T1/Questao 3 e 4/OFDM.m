function vetor_funcoes = OFDM
    vetor_funcoes.transmissor = @transmissor;
    vetor_funcoes.receptor = @receptor;
    vetor_funcoes.canal = @canal;
end

%Questao1
function [x_n] = transmissor(X,N,mi)
    col = length(X)/N;
    aux = [N,col];
    paralelo = serial_paralelo(X,aux);  %serial para parelo dividindo em 4 subcanais com 2 símbolos
    inversa = ifft(paralelo,N,1);
    pref_ciclico = inversa([(N-mi+1):N],:);
    info_prefixo = [pref_ciclico;inversa];
    x_n = paralelo_serial(info_prefixo);
end

function [p] = serial_paralelo(serial,aux)
    p = reshape(serial,aux);
end

function s = paralelo_serial(paralelo)
    s = reshape(paralelo,1,[]);
end

%Questao 2
function [y] = canal(x,h,snr)
    convolucao = filter(h,1,x); %convolucao
    y = awgn(convolucao,snr,'measured');
end

function [X_k] = receptor(x,h,N,mi)
    col = length(x)/(N+mi);
    paralelo =  serial_paralelo(x,[(N+mi),col]);
    %remocao prefixo ciclico
    paralelo([1:mi],:) = [];
    %fft
    Y = fft(paralelo);
    H = fft(h,N); %pega todas as frequencias
    H_t = H.';
    rep = repmat(H_t,1,size(Y,2));
    % %equalizacao
    X_hat = Y./rep;
    X_k = paralelo_serial(X_hat);
    
end

