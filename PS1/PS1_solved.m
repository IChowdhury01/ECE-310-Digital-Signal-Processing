% Ivan Chowdhury
% 9/24/2019
% Digital Signal Processing
% Problem Set 1

clc, close all, clear all;

%6
fs = 100*10^3; % system parameters
f = 20*10^3;
wlen = 1000;
N = 1024;

t2 = wlen/fs;   % time interval
step = t2/1000;
t = 0:step:t2 - step;

wave = 2*sin(2*pi*f.*t);    % Create corrupted sine wave
noise = normrnd(0, sqrt(0.2), 1, wlen);
noisywave = wave + noise;

window = chebwin(wlen,30);  % Chebychev filter
windowedsig = window' .* noisywave;

dft = fftshift(fft(windowedsig,N)); % DFT
freq = linspace(-50*10^3,(50*10^3) - (fs/N),N);

figure
plot(freq,20*log10(abs(dft)));
title("Magnitude Spectrum of Corrupted Sinewave");
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");

%%
%7
%a
b = [1 .1 -.72];    % Transfer function coefficients (found by hand)
a = [1 .95 .9025];

[zeros,poles,k] = tf2zpk(b,a);
zeros
poles

figure
zplane(zeros,poles);
title("Zero-Pole Plot");
xlabel("Real Component");
ylabel("Imaginary Component");