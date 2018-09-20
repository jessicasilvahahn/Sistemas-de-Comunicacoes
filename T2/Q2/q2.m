clear all;
close all;
N = 4; %fator de espalhamento, 4 chips - 1 bit
L = N; %periodo
bits = 2;
%codigo polar
Rb = 200e3;
chips_amostras = 50;
amostras_bits = chips_amostras*N;
Tb = 1/Rb;
Tc = Rb/N;
SNR = 100;%sem ruido
user0 = [-1 -1]; %00
user1 = [1 -1]; %10
user2 = [0 0]; %silencioso
user3 = [-1 1]; %01

codigo = hadamard(N);
%repetir a informacao de cada usuario de acordo com o fator do espalhamento
x1_rep = kron(user0,ones([1,L])); 
x2_rep = kron(user1,ones([1,L])); 
x3_rep = kron(user2,ones([1,L])); 
x4_rep = kron(user3,ones([1,L]));

%codigos
%perguntar
codigo1 = repmat(codigo(1,:),1,2); %pegar a linha correspondente
codigo2 = repmat(codigo(2,:),1,2);
codigo3 = repmat(codigo(3,:),1,2);
codigo4 = repmat(codigo(4,:),1,2);

s1 = x1_rep.*codigo1;
s2 = x2_rep.*codigo2;
s3 = x3_rep.*codigo3;
s4 = x4_rep.*codigo4;

soma_s = s1 + s2 + s3 + s4;
r = awgn(soma_s,SNR);

%dominio tempo
filtro = ones(1,chips_amostras);
%superamostragem
x1_t = filter(filtro,1,upsample(x1_rep,chips_amostras));
x2_t = filter(filtro,1,upsample(x2_rep,chips_amostras));
x3_t = filter(filtro,1,upsample(x3_rep,chips_amostras));
x4_t = filter(filtro,1,upsample(x4_rep,chips_amostras));

s1_t = filter(filtro,1,upsample(s1,chips_amostras));
s2_t = filter(filtro,1,upsample(s2,chips_amostras));
s3_t = filter(filtro,1,upsample(s3,chips_amostras));
s4_t = filter(filtro,1,upsample(s4,chips_amostras));

r_t =filter(filtro,1,upsample(r,chips_amostras));
t = bits*Tb*((0:length(x4_t)-1)/length(x4_t));

figure();
subplot(411);
plot(t,x1_t,'r');
title('x1(t)');
ylim([-1.5 1.5]);
subplot(412);
plot(t,x2_t,'g');
ylim([-1.5 1.5]);
title('x2(t)');
subplot(413);
plot(t,x3_t);
title('x3(t)');
ylim([-1.5 1.5]);
subplot(414);
plot(t,x4_t,'k');
title('x4(t)');
ylim([-1.5 1.5]);

figure();
subplot(411);
plot(t,s1_t,'r');
ylim([-1.5 1.5]);
title('s1(t)');
subplot(412);
plot(t,s2_t,'g');
ylim([-1.5 1.5]);
title('s2(t)');
subplot(413);
plot(t,s3_t);
ylim([-1.5 1.5]);
title('s3(t)');
subplot(414);
plot(t,s4_t,'k');
ylim([-1.5 1.5]);
title('s4(t)');

figure();
plot(t,r_t);
title('r(t)');

%receptor
y1 = codigo1.*r;
y2 = codigo2.*r;
y3 = codigo3.*r;
y4 = codigo4.*r;
%superamostragem
y1_t = filter(filtro,1,upsample(y1,chips_amostras));
y2_t = filter(filtro,1,upsample(y2,chips_amostras));
y3_t = filter(filtro,1,upsample(y3,chips_amostras));
y4_t = filter(filtro,1,upsample(y4,chips_amostras));

figure();
subplot(411);
plot(t,y1_t,'r');
title('y1(t)');
subplot(412);
plot(t,y2_t,'g');
title('y2(t)');
subplot(413);
plot(t,y3_t);
title('y3(t)');
subplot(414);
plot(t,y4_t,'k');
title('y4(t)');
%integral e correlator
%y1
int1 = sum(y1_t(1:length(y1_t)/2))/amostras_bits;
int1_2 = sum(y1_t(length(y1_t)/2+1:end))/amostras_bits;
correlator1 = [int1 > 0 int1_2 > 0];
%y2
int2 = sum(y2_t(1:length(y2_t)/2))/amostras_bits;
int2_2 = sum(y2_t(length(y2_t)/2+1:end))/amostras_bits;
correlator2 = [int2 > 0 int2_2 > 0];

%y3
int3 = sum(y3_t(1:length(y3_t)/2))/amostras_bits;
int3_2 = sum(y3_t(length(y3_t)/2+1:end))/amostras_bits;
correlator3 = [int3 > 0 int3_2 > 0];

%y4
int4 = sum(y4_t(1:length(y4_t)/2))/amostras_bits;
int4_2 = sum(y4_t(length(y4_t)/2+1:end))/amostras_bits;
correlator4 = [int4 > 0 int4_2 > 0];


