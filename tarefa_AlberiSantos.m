%%
% 
% Autor: Alberi Medeiros Santos
%
% E-mail: alberi.santos@ee.ufcg.edu.br
%
% Data: 14/02/2023
%
% Matricula: 118111781
%
% Curso: Engenharia Elétrica
%
% Professor: Prof. Dr. Edmar Candeia Gurjão
%
% Instituição: Universidade Federal de Campina Grande
% 
%
% Descrição: Este script tem como objetivo implantar uma função real cuja
% amplitude seja constante e causal, usando a Transformada Z. O diagrama de
% pólos e zeros, a posição do pólo e a transformada de Fourier da função
% serão desenhados com base nas equações matemáticas fornecidas na teroia
% da disciplina.
%
clear;
clc;

% Definição da função e da variável z
alpha=1 %função constante
syms z; %Variavel em z

% Função x no tempo discreto
syms n; % Variavel no tempo discreto
x=alpha^n; % Função constante e igual a 1

%Transformada z da função x
H=ztrans(x); % Transformada z da função x

% Coeficientes numéricos da função de transferência
[b,a]=numden(H); % numerador e denominador de z
num=sym2poly(b); % transformando dados syms em polinomios
den=sym2poly(a); % transformando dados syms em polinomios
ts=0.01;        % tempo de amostragem no tempo discreto

% Função em z com tempo de amostragem ts
Htf= tf(num, den, ts) 

% Plot do diagrama de polos e zeros
figure(1)
zplane(num, den) %polos e zeros da função em z
xlabel('Parte real');
ylabel('Parte imaginária');
title('Diagrama de polos e zeros');
grid on;

% Criação do sinal discreto xNovo  
xNovo=sym2poly(x) % transforma o x de syms para polinomio
n=0:10-1;       % cria um vetor de tempo n
xNovo=polyval(xNovo, n); % cria um vetor com os valores de x no tempo a partir do polinomio

% Cálculo da transformada de Fourier discreta utilizando a função fft
F=abs(fft(xNovo)); % Calcula o módulo da fft de xNovo

% Criação do eixo de frequências normalizadas de 0 a pi
w = linspace(0, pi, 10);

% Criação do gráfico do módulo da transformada de Fourier discreta
figure(2)
plot(w/pi,F) % Plota o módulo da transformada de Fourier discreta
xlabel('Frequência normalizada (\omega/\pi)') % Adiciona legenda ao eixo x
ylabel('Magnitude') % Adiciona legenda ao eixo y
title('Transformada de Fourier') % Adiciona título ao gráfico
grid on % Adiciona grade ao gráfico para facilitar a visualização

% Plot do sinal no tempo
figure(3)
stem(n,xNovo)
xlabel('n')
ylabel('x[n]')
title('Sinal discreto x[n]')
grid on;
