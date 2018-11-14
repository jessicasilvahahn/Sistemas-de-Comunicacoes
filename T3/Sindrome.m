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

function [u_hat] = SDD(r,struct_info)
     c = struct_info.c;		     
     c_mod = (c * 2) -1;
     k = struct_info.k;		     
     dist = r * c';		     
     [M, index] = max(dist);
     c_hat = (c(index,:)+1)/2;
     u_hat = c_hat(1:k);
   
end


