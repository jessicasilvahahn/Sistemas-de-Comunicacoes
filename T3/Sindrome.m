function vetor_funcoes = Sindrome
    vetor_funcoes.HDD = @HDD;
    vetor_funcoes.SDD = @SDD;  
end

function [u_hat] = HDD(b,struct_info)
    k = struct_info.k;
    lut = struct_info.lut;
    h = struct_info.h;
    s = mod(b*h',2);
    [l,c] = size(lut);
    u_hat = 0;
    for i=1:l
       if(s == lut(i,1:k-1))
          erro = lut(i,(length(s))+1:end);
          palavra_codigo = xor(erro,b);
          u_hat = palavra_codigo(1:k);
          break
       end
    end
end

function [u_hat] = SDD(r,struct_info,n)
    c = struct_info.c;
    c_mod = (c * 2) -1;
    k = struct_info.k;
    for i = 1:length(c)
        %distancia euclidiana
        r = repmat(r(i, 1:end), size(c_mod, 1), 1);
        distancia = sum((c_mod - r).^2, 2);
        [valor_min indice] = min(distancia);
        c_hat(i, 1:n) = c_mod(indice, :);
    end
    u_hat = c_hat(1:end, 1:k);
   
end


