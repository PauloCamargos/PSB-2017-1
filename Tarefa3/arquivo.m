%% Função para criar uma função X = B - B*t, onde 'B' é constante de
% decaimento da função definida pelo usuário como parâmetro,
% juntamente com a quantidade de amostras. 

% Variáveis de entrada:
% B: constante (escalar) de decaimento da função (reta).
% qnt_amostras: constante (escalar) representando a quantidade de amostras da função
% 
% Variáveis internas:
% fa:   constante representando a frequência de amotragem, dada em [Hz].
% T:    Periodo de amostragem, dado em [s].
% t:    vetor de tempo analógico, dado em [s]
%
% Variáveis de saída:
% X:    vetor (1,qnt_amostras) contendo os valores da função X.

%%
function [X] = arquivo(B,qnt_amostras)
fa = 1000;  
T = 1/fa;  % Tempo de amostragem em [s]
t = 0:T:(qnt_amostras-1)*T; % Tempo analógico

X=B-B*t; % Vetor de amostras

end