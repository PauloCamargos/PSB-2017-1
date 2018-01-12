%% Realizar o corte de 5 trechos de uma matriz e calcula suas respectivas
% Transformadas de Fourier normalizada, fases, potencias e freq. mediana.
% Vari�veis de entrada:
% ti:   (vetor 1x5) Tempo inicial [s];
% tf:   (vetor 1x5) Tempo final [s];
% 
% Vari�veis internas:
% coma: (matriz 20x2500) Matriz orignal com todos eletrodos [uV];
% eletrodo: (constante) N�mero referente ao eletrodo selecionado 
%   [admensional];
% fa: (constante) frequencia de amostragem [Hz];
% T: (constante) Per�odo [ms];
% X: (vetor 1:L, onde L � o numero de colunas em fun��o de tf) Vetor de 
%   dados que cotem o sinal separado por trechos (X1,X2,...,X5);
% 
% Vari�veis de sa�da:
% XN: vetor de modulo normalizado da transformada, dimensao Nf, [W/Hz],
%   de cada vetor � corresponde a um tempo tf (XN1,...,XN5);
% XFF: vetor de fase da transformada de Fourier, dimensao Nf, [rad], 
%   de cada vetor � corresponde a um tempo tf (XFF1,...,XFF5);
% P: (constante) potencia espectral total do sinal, de cada trecho,
%   (P1,...,P5). 
% fm: (constante) frequencia mediana do sinal [Hz], de cada trecho,
%   (FM1,...FM5).
%
% Os arquivos coma.mat, fourier_fct.m, integral.m e integralMod.m deve
% estar presetes no mesmo diret�rio de execu��o deste programa.
%%
load coma;

%%Defini��o e obten��o das vari�veis auxiliares
fa = 250;
T = 1/fa;
eletrodo = 6; % F4

ti=zeros(1:5);
tf=zeros(1:5);
% Solicita vetor de tempos
for k=1:5
    % concatena 
    ti = ones(1,5);
    % ti(k) = input(horzcat('Entre com o tempo inicial (s) do trecho ', num2str(k),' : '));
    tf(k) = input(horzcat('Entre com o tempo final (s) do trecho ', num2str(k), ' : '));
    disp('--------------');
end

% Faz a sele��o de trechos a partir dos vetores de tempo definidos
X1 = coma(eletrodo,(1+ti(1)*250):(tf(1)*250));
X2 = coma(eletrodo,(1+ti(2)*250):(tf(2)*250));
X3 = coma(eletrodo,(1+ti(3)*250):(tf(3)*250));
X4 = coma(eletrodo,(1+ti(4)*250):(tf(4)*250));
X5 = coma(eletrodo,(1+ti(5)*250):(tf(5)*250));

% Calculo do modulo, fase, potencia e fm para cada trecho

[t1,f1,XFF1,P1,XN1,fm1] = fourier_fct(X1,fa);
[t2,f2,XFF2,P2,XN2,fm2] = fourier_fct(X2,fa);
[t3,f3,XFF3,P3,XN3,fm3] = fourier_fct(X3,fa);
[t4,f4,XFF4,P4,XN4,fm4] = fourier_fct(X4,fa);
[t5,f5,XFF5,P5,XN5,fm5] = fourier_fct(X5,fa);

% Gr�ficos 
% plotando f x XN:
figure;
hold on;
plot(f1,XN1,'b');
plot(f2,XN2,'k');
plot(f3,XN3,'y');
plot(f4,XN4,'g');
plot(f5,XN5,'r');
title(horzcat('M�dulo da trasnformada X Frequ�ncia'));
ylabel('M�dulo normalizado da transformada [W/Hz]');
xlabel ('Frequ�ncia [Hz]');

% plotando f x XFF
%subplot(1,5,1);
figure;
plot(f1,XFF1);
title(horzcat('Fase X Frequ�ncia para tempo final = ', num2str(tf(1))));
ylabel('Fase [rad]');
xlabel ('Frequ�ncia [Hz]');

%subplot(1,5,2);
figure;
plot(f2,XFF2);
title(horzcat('Fase X Frequ�ncia para tempo final = ', num2str(tf(2))));
ylabel('Fase [rad]');
xlabel ('Frequ�ncia [Hz]');

%subplot(1,5,3);
figure;
plot(f3,XFF3);
title(horzcat('Fase X Frequ�ncia para tempo final = ', num2str(tf(3))));
ylabel('Fase [rad]');
xlabel ('Frequ�ncia [Hz]');

%subplot(1,5,4);
figure
plot(f4,XFF4);
title(horzcat('Fase X Frequ�ncia para tempo final = ', num2str(tf(4))));
ylabel('Fase [rad]');
xlabel ('Frequ�ncia [Hz]');

%subplot(1,5,5);
figure;
plot(f5,XFF5);
title(horzcat('Fase X Frequ�ncia para tempo final = ', num2str(tf(5))));
ylabel('Fase [rad]');
xlabel ('Frequ�ncia [Hz]');
