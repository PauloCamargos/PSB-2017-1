%% Script para realizar o cálculo da Transformada de Fourier Normalizada 
%(TF), fase da TF, potência e frequência mediana da função X = b - bt, 
% onde 'b' é um parâmetro fonecido pelo usuário e 't' é o tempo de 
% amostragem do sinal.
%
% Variáveis de entrada:
% b: vetor (1, 10) representando constante de decaimento fornecida pelo
% usuário.
%
% Variáveis internas:
% Ta:   constante representando o período de amostragem em [s]
% fa:   constante representando a frequência de amostragem em [Hz]
% t:    vetor (1x5000) de tempos do sinal a ser calculado [s]
% qnt_amostras: constante representandoc o número de colunas da matriz X.
%
% Variáveis de saída:
% X :   matriz (10x5000) que armazena as amostras do sinal calculado
% onde cada linha é calculada a partir do vetor de constantes de
% decaimento.
% fm:   vetor (10X1) com os valores de frequência mediana do sinal.
% XFF:  vetor de fase (10x2501) da transformada de Fourier dado em [rad]
% radianos.
% P:    vetor (10x1) com os valores de potência espectral.
% XN:   matriz (10x2501) com os do modulo normalizado da transformada
% [W/Hz].

% Observação: Para executar este arquivo, devem estar presentes no mesmo
% diretório os programas integral.m e  integralMod.m.

%% Definição de variáveis

qnt_amostras = 5000;
X = zeros(10,qnt_amostras);

fa = 1000;
T = 1/fa;
t = 0:T:(qnt_amostras-1)*T; 

b = zeros(1,10);

%% Loop para entrada do vetor b
for i = 1:10 
    b(i) = input('Entre com a constante de decaimento: ');
%     for k = 1:qnt_amostras
%         X(i,k) = b(i) - b(i)*t(k);  %calculo do vetor com as amostras do sinal
%     end
    X(i,:) = arquivo(b(i), qnt_amostras);
end

%% Cálculo da transformada de fourier

N = length(X);
f1_har = fa/N;
f = 0:f1_har:fa/2;
Nf = length(f);
XF = zeros(10,Nf);
XM = zeros(10,Nf);
XFF = zeros(10,Nf);
XQ = zeros(10,Nf);
P = zeros(10,1);
XN = zeros(10, Nf);
fm = zeros(10,1);

for i = 1:10
    for k = 1 : Nf
        C = cos(2*pi*f(k).*t);
        S = sin(2*pi*f(k).*t);
        Cx = X(i,:) .* C;
        Sx = X(i,:) .* S;
        xrf = integral(Cx, fa);         
        xif = integral(Sx, fa);         
        XF(i,k) = xrf - 1i*xif;           
        XM(i,k) = sqrt(xrf^2 + xif^2);
        % vetor de fase da transformada de Fourier, dimensao Nf, radianos
        XFF(i,k) = atan2d(xif,xrf);   
        XQ(i,k) = XM(i,k)^2;
    end
    
    %% Normalizacao do espectro
    
    P(i,1) = integralMod(XQ(i,:), f);     % Potência espectral total do sinal    
    %vetor de modulo normalizado da transformada, dimensao Nf, [W/Hz].
    XN(i,:) = XM(i,:) ./ sqrt(P(i,1));                     
    soma = 0;
    for j = 1 : Nf
        soma = soma + (XN(i,j) * f(1,j));
    end
    fm(i,1) = soma/sum(XN(i,:));      %frequência mediana do sinal
end

%% Plota as figura (t,Xi), (f,XNi); (f,XFFi), onde i = 1,...,10.

cores = [ 'y' 'm' 'c' 'r' 'k' 'b' 'c' 'k' 'b' 'k' ];
for i = 1:10
    figure(1) % Plota o sinal X
    plot(t,X(i,:), cores(i));
    hold on;
    title('Sinal de Entrada: x3(t) = b – b*t ');
    ylabel('Sinal x3(t)');
    xlabel('Tempo [s]');
    
    figure(2) % Plota o modulo da TF do sinal X
    plot(f, XN(i,:),cores(i));
    hold on;
    title('Transformada de Fourier Normalizada');
    ylabel('Potência [W/Hz]');
    xlabel('Frequência [Hz]');
    %axis([-50 525 -0.5 2.5]);
    
    figure(3) % Plota a fase da TF do sinal X
    plot(f,XFF(i,:),cores(i));
    hold on;
    title('Fase da Transformada');
    ylabel('Fase [graus]');
    xlabel('Frequência [Hz]');
    % axis([-10 510 -100 200]);
end
% Fim do programa                           

