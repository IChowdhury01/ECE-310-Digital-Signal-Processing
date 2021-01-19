% Ivan Chowdhury
% 12/3/2019
% Digital Signal Processing
% Problem Set 5

clc, close all, clear all;
%% Problem 2
% b
w1 = linspace(-pi,pi,128);
w2 = linspace(-pi,pi,128);
[W1,W2] = meshgrid(w1,w2);
F = (1/2)*(-1 + cos(W1) + cos(W2) + cos(W1).*cos(W2));  % The values are bounded between -1,1

figure
contour(W1,W2,F)
title("Contour Plot of F(w1,w2)");

