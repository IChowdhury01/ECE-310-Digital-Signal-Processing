% Ivan Chowdhury
% 12/9/2019
% Digital Signal Processing
% Problem Set 7

clc, close all, clear all;
%% Problem 4
% a
h = [0.15774243 0.69950381 1.06226376 0.44583132 -0.31998660 -0.18351806 0.13788809 0.03892321 -0.04466375 -7.83251152E-4 6.75606236E-3 -1.52353381E-3];

H0 = h;

N=12;
k = 0:N-1;
H1 = (-1).^k .* h(N-k);
F0 = h(N-k);
F1 = (-1).^k .* h(k+1);

%c
n = 1000;
H0resp = freqz(h,1,n);
H1resp = freqz(H1,1,n);
F0resp = freqz(F0,1,n);
F1resp = freqz(F1,1,n);

figure;

hold on;
w = linspace(0,pi,1000);
plot(w, abs(H0resp));
plot(w, abs(H1resp));
hold off;
title("Magnitude Response of H0, H1");
xlabel("Frequency (rad)");
ylabel("Magnitude");
legend("|H0(w)|", "|H1(w)|");

%d
c = abs(H0resp(2,1)).^2 + abs(H1resp(2,1)).^2 % Value is approximately 4
error = max(abs(c-4))