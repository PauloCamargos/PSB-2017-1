%% (TAREFA 1)
% Obs.: Para executar este programa, devem estar presentes no mesmo 
% diret�rio o arquivo coma.mat e integral.m
%
% Fun��o para gerar uma matriz "valores1" an�loga � matriz "coma", por�m
% dentro de um intervalo de tempo especificado pelo usu�rio(ti,tf) e 
% um vetor "potencia" que calcula a pot�ncia de cada deriva��o (canal).
%
% Vari�veis de entrada:
% ti (escalar): Tempo inicial medido em [ms]; 
% tf (escalar): Tempo final medido em [ms];
% Obs.: Os valores de ti e tf devem ser multiplos de 4 [ms]
%
% Vari�veis internas:
% coma (matriz de dimens�o rowXcollumn): Matriz de dados;
% T (escalar): Per�odo de amostragem em [s];
% fa (escalar): Frequ�ncia de amostragem em [Hz];
% t (vetor): Vetor de tempo anal�gico;
% L (escalar): N�mero de colunas entre os tempos ti e tf;
% media : valor medio da linha da matriz trabalhada;
% media_por_linha: valor m�dio de cada canal;
% media_total: valor m�dio de toda a matriz;
%
% Vari�veis de sa�da:
% valores1 = Submatriz de "coma" do intervalo ti � tf [20 x 
% (indice_f - indice_i)];
% potencia = Vetor de pot�ncia de cada deriva��o(canal) de "valores1"; 
% [1x20]
%%

% Defini��o e obten��o das vari�veis auxiliares
fa = 250;
T = (1/fa)*1000; % convers�o para [ms]

% Obten��o da matriz coma.mat e tempo inicial e final
load coma

while true
    ti = input('Entre com o tempo inicial: ');
    tf = input('Entre com o tempo final: ');
    if(tf>ti && ti>=0 && tf<=9996 && (tf-ti>4))
        break;
    else
        disp('Intervalo invalido! Tente novamente.');
    end
end
% Criar um indice para acesso a matriz coma
indice_i = ceil(ti*0.25+1); % Arredonda para cima
indice_f = floor(tf*0.25+1); % Arredonda para baixo

% Implementa��o da matriz "valores1"
valores1 = coma(:,indice_i:indice_f);
[N,L] = size(valores1); % N: nro de linhas. L: nro de colunas

% Calculo da media e set para 0
for k=1:N
    media = mean(valores1(k,:));
    valores1(k,:) = valores1(k,:) - media;
end


% Implementa��o da matriz "potencia";
potencia = zeros(1,N);
for k=1:N
    soma_amostra = sum(valores1(k,:).^2);
    pot = (soma_amostra)/L;
    potencia(k) = pot;
end
% FIM DA TAREFA 1

%% (TAREFA 2) 
% Realiza a integra��o de um sinal e plota o sinal integrado juntamente
% com o sinal original.
% Variaveis Internas: 
%   coma - matriz original com todos os canais
%   ti - tempo inicial da submatriz para integra��o desejada
%   tf - tempo final da submatriz para integra��o desejada
% Vari�veis de entrada:
%   canal - numero inteiro representando o canal (1-20) desejado
% Variaveis de saida:
%   Este programa tem possui variaveis de sa�da. Plota os graficos acima
%   descritos
%
%%

while true
    n_canal = input('Entre com o n�mero correspondente ao eletrodo desejado: ');
    if(n_canal>=1 && n_canal<=20)
        break;
    else
        disp('Eletrodo inv�lido! Tente novamente');
    end    
end
sinal_canal = valores1(n_canal, :);

% Cria o vetor tempo
t = ti:T:tf;

% Realiza a integra��o do sinal
[integralTotal,sinalIntegral] = integral(sinal_canal,fa);
% Plota os gr�ficos do sinal e integral
plot(t,sinal_canal);
hold on;
plot(t,sinalIntegral,'r')
% Configura eixos, titulo e legendas do gr�fico
legend('Trecho do sinal', 'Curva de integra��o');
% Texto do t�tulo do gr�fico
s = strcat('Tens�o [uV] x Tempo [ms] - CH ',num2str(n_canal));
s = strcat(s,' (', num2str(ti),'-',num2str(tf),' [ms])'); 
title(s);
ylabel('Tens�o [uV]');
xlabel('Tempo [ms]');
xlim([ti-(tf*0.05) tf+(tf*0.05)]); % Limita o eixo x em +/- 5% de tf
ylim([-70 70]); % limita eixo y

hold off

clearvars -except valores1 potencia % Limpa todas as vari�veis com exce��o
                                    % de valores1 e potencia




