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


% Parâmetros da função
A = 1;   % Amplitude
M = 10;  % Número de atrasos

% Função de transferência H(z)
z = tf('z', 1);
H = A*(1 + z^(-1) + z^(-2) + z^(-3) + z^(-4) + z^(-5) + z^(-6) + z^(-7) + z^(-8) + z^(-9) + z^(-10));

% Coeficientes numéricos da função de transferência
[num, den] = tfdata(H, 'v');
b = num;
a = den;

% Plot da resposta em frequência
w = linspace(0, pi, 1000);
Hw = freqz(b, a, w);
figure(1);
plot(w/pi, abs(Hw));
xlabel('Frequência (x \pi rad/sample)');
ylabel('|H(e^{j\omega})|');
title('Resposta em frequência');
grid on;

% Plot do diagrama de polos e zeros
figure(2);
zplane(b, a);
xlabel('Parte real');
ylabel('Parte imaginária');
title('Diagrama de polos e zeros');
grid on;

% Plot do sinal no tempo
figure(3);
n = 0:M;
x = A*(n <= M);
stem(n, x);
xlabel('n');
ylabel('x[n]');
title('Sinal discreto x[n]');
grid on;

% Transformada de Fourier
N = 1024;  % Número de amostras
Xw = fft(x, N);
w = linspace(0, 2*pi, N);

% Plot do módulo da transformada de Fourier
figure(4);
plot(w/pi, abs(Xw));
xlabel('Frequência (x \pi rad/sample)');
ylabel('|X(e^{j\omega})|');
title('Transformada de Fourier (módulo)');
grid on;

% Plot da fase da transformada de Fourier
figure(5);
plot(w/pi, angle(Xw));
xlabel('Frequência (x \pi rad/sample)');
ylabel('\angle X(e^{j\omega})');
title('Transformada de Fourier (fase)');
grid on;
