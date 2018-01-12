%% Fun��o para criar uma fun��o X = B - B*t, onde 'B' � constante de
% decaimento da fun��o definida pelo usu�rio como par�metro,
% juntamente com a quantidade de amostras. 

% Vari�veis de entrada:
% B: constante (escalar) de decaimento da fun��o (reta).
% qnt_amostras: constante (escalar) representando a quantidade de amostras da fun��o
% 
% Vari�veis internas:
% fa:   constante representando a frequ�ncia de amotragem, dada em [Hz].
% T:    Periodo de amostragem, dado em [s].
% t:    vetor de tempo anal�gico, dado em [s]
%
% Vari�veis de sa�da:
% X:    vetor (1,qnt_amostras) contendo os valores da fun��o X.

%%
function [X] = arquivo(B,qnt_amostras)
fa = 1000;  
T = 1/fa;  % Tempo de amostragem em [s]
t = 0:T:(qnt_amostras-1)*T; % Tempo anal�gico

X=B-B*t; % Vetor de amostras

end