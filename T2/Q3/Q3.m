close all;
clear all;
exemplos = LFSR;
codigos = exemplos.main();
for i = 1:3
    codigos{i}
end

%correlacao1
j = 1;
L1 = 2.^3 -1;
for i = -8:8
    polar = (codigos{1}*2)-1;
    codigo_ciclico = circshift(polar,i,2);
    correlacao1(j) = ((sum(polar.*codigo_ciclico))/L1);
    j = j+1;
    
end
%correlacao2
j = 1;
L = 2.^5 - 1;
for i = -32:32
    polar = (codigos{2}*2)-1;
    codigo_ciclico = circshift(polar,i,2);
    correlacao2(j) = ((sum(polar.*codigo_ciclico))/L);
    j = j+1;
    
end

%correlacao3
j = 1;
for i = -32:32
    polar = (codigos{3}*2)-1;
    codigo_ciclico = circshift(polar,i,2);
    correlacao3(j) = ((sum(polar.*codigo_ciclico))/L);
    j = j+1;
    
end

%rand
aleatorio = randi([0 1], 1, 31);
j = 1;
for i = -32:32
    %aleatorio = (aleatorio*2)-1;
    codigo_ciclico = circshift(aleatorio,i,2);
    correlacao4(j) = ((sum(aleatorio.*codigo_ciclico))/L);
    j = j+1;
    
end

figure();
subplot(411);
plot([-8:8],correlacao1,'r')
title('Exemplo 1');
subplot(412);
plot([-32:32],correlacao2)
title('Exemplo 2');
xlim([-32 32]);
subplot(413);
plot([-32:32],correlacao3,'k')
title('Exemplo 3');
xlim([-32 32]);
subplot(414);
plot([-32:32],correlacao4,'g')
title('Aleatório (ver  com professor)');
xlim([-33 33]);




