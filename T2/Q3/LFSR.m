function vetor_funcoes = LFSR
    vetor_funcoes.lfsr = @lfsr;
    
end

function [saida] = lfsr(estado,taps,m)
    if 1 && all(estado == 0)   
       saida = 0;
    else
       numero_estados = 2.^m -1; % Numero de estados 
       saida = ones(1,numero_estados); % igual saida do codigo
       for i=1:numero_estados
           entrada = mod(sum(estado(taps)),2); %xor
           saida(i) = estado(end);
           deslocamento = circshift(estado,numero_estados,2)
           deslocamento(1) = entrada;
           estado = deslocamento;

        end; 
    end
    
end