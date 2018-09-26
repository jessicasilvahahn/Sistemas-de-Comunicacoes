function vetor_funcoes = LFSR
    vetor_funcoes.lfsr = @lfsr;
    vetor_funcoes.main = @main;
    vetor_funcoes.rand_vetor = @rand_vetor;
    
end

function [saida] = lfsr(estado,taps,m)
    if 1 && all(estado == 0)   
       saida = 'erro'
    else
       numero_estados = 2.^m -1; % Numero de estados 
       saida = ones(1,numero_estados); % igual saida do codigo
       for i=1:numero_estados
           entrada = mod(sum(estado(taps)),2); %xor
           saida(i) = estado(end);
           estado = circshift(estado,numero_estados,2);
           estado(1) = entrada;

       end 
    end
    
end

function [vetor] = rand_vetor(j)
    if j==1
        vetor = [1 3];
    elseif j==2
        vetor = [5 2];
    elseif j==3
        vetor = [5 4 2 1];
    end
end

function [codigos] = main()
    estado = [1 0 0];
    m = 3;
    codigos = cell(1,3);
    for i=1:3
        taps = rand_vetor(i);
        %geracao de codigo, lembrando que o codigo é ciclico
        codigos{i} = lfsr(estado,taps,m); 
        estado = [1 0 0 0 0];
        m = 5;
    end
end