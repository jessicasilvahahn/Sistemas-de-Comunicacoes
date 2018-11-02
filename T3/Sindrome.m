function vetor_funcoes = Sindrome
    vetor_funcoes.HDD = @HDD;
    vetor_funcoes.SDD = @SDD;  
end

function [u_hat] = HDD(b,struct_info)
    k = struct_info.k
    lut = struct_info.lut
    h = struct_info.h
    s = mod(b*h',2)
    [l,c] = size(lut)
    for i=1:l
       if(s == lut(i,1:k-1))
          erro = lut(i,(length(s))+1:end)
          palavra_codigo = xor(erro,b)
          u_hat = palavra_codigo(1:k);
          break
       end
    end
end
