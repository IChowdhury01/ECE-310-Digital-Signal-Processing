% Ivan Chowdhury
% 11/13/2019
% Digital Signal Processing
% Problem Set 4

clc, close all, clear all;
%% Problem 4
% Given
[z, p, k] = ellip(3, 2, 30, [0.2, 0.4]);
[b, a] = zp2tf(z, p, k);
[d0, d1] = tf2ca(b, a);
p0 = fliplr(d0);
p1 = fliplr(d1);

%a - Bottom of file
%% b
H1 = [p0, d0];
H2 = [p1, d1];

[B, A] = computeTF(H1, H2);

n = 1000;
[h1, w] = freqz(p0, d0, n);
h2 = freqz(p1, d1, w);

freqRespH = freqz(B, A, w);
freqRespH2 = 1/2*(h1-h2);

% Maximum Absolute Error
error = max(abs(freqRespH - freqRespH2))

%% c
magResp = 20*log10(abs(freqRespH));

figure;
subplot(2, 1, 1);
hold on;
plot(w/pi, magResp);
title("Magnitude Response");
xlabel("Frequency (Hz)");
ylabel("Magnitude Response");
xlim([0, 1]);
ylim([-50, (max(magResp) + 20)]);
hold off;

subplot(2, 1, 2);
hold on;
plot(w/pi, unwrap(angle(freqRespH)));
title("Phase Response");
xlabel("Frequency (Hz)");
ylabel("Phase (Radians)");
xlim([0, 1]);
hold off;

%% d
figure;
plotMR(freqRespH, w);

rounding = 16;
scale = 8;
bRounded16 = round((B * scale) * rounding)/(scale * rounding);
aRounded16 = round(A * rounding)/rounding;
rounding = 4;
bRounded4 = round((B * scale) * rounding)/(scale * rounding);
aRounded4 = round(A * rounding)/rounding;

[h16r, w16r] = freqz(bRounded16, aRounded16, n);
plotMR(h16r, w16r);
[h4r, w4r] = freqz(bRounded4, aRounded4, n);
plotMR(h4r, w4r);
legend("Original", "1/16 Quantized", "1/4 Quantized");

%% e
figure;
subplot(3,1,1);
zplane(B, A);
title("Original");

subplot(3,1,3);
zplane(bRounded4, aRounded4);
title("1/4 Quantized");

subplot(3,1,2);
zplane(bRounded16, aRounded16);
title("1/16 Quantized");

% The Zero-Pole plots show that all poles stay inside the unit circle after quantization.

%% f
figure;
plotMR(freqRespH2, w);

rounding = 16;
p0r16 = round((p0 * scale) * rounding)/(scale * rounding);
d0r16 = round(d0 * rounding)/rounding;
p1r16 = round((p1 * scale) * rounding)/(scale * rounding);
d1r16 = round(d1 * rounding)/rounding;

hR16 = 1/2*(freqz(p0r16, d0r16, w) - freqz(p1r16, d1r16, w));
plotMR(hR16, w);

rounding = 4;
p0r4 = round((p0 * scale) * rounding)/(scale * rounding);
d0r4 = round(d0 * rounding)/rounding;
p1r4 = round((p1 * scale) * rounding)/(scale * rounding);
d1r4 = round(d1 * rounding)/rounding;

hR4 = 1/2*(freqz(p0r4, d0r4, w) - freqz(p1r4, d1r4, w));
plotMR(hR4, w);

title("Magnitude Response of 1/2 (H1-H2)");
legend("Original", "1/16 Quantized", "1/4 Quantized");

%% g
figure;

subplot(3,1,1);
zplane(B, A);
title("Original Filter");

subplot(3,1,2);
[bAPr16, aAPr16] = computeTF([p0r16 d0r16], [p1r16 d1r16]);
zplane(bAPr16, aAPr16);
title("1/16 All-Pass Quantized");

subplot(3,1,3);
[bAPr4, aAPr4] = computeTF([p0r4 d0r4], [p1r4 d1r4]);
zplane(bAPr4, aAPr4);
title("1/4 All-Pass Quantized");

% The poles of the quantized allpass sections can be outside the unit
% circle.
%% Part a
function [b, a] = computeTF(H1,H2)
    b1 = H1(1:(length(H1)/2));
    a1 = H1((length(H1)/2+1):end);
    b2 = H2(1:(length(H2)/2));
    a2 = H2((length(H2)/2 + 1):end);
    
    b = conv(b1, a2) - conv(b2, a1);
    a = 2 .* conv(a1, a2);
end

% Function to plot magnitude response
function [] = plotMR(h, w)
    Mag = 20 * log10(abs(h));
    hold on;
    plot(w/pi, Mag);
    title("Magnitude Response");
    xlabel("Frequency (Hz)");
    ylabel("Magnitude Response");
    xlim([0, 1]);
    ylim([-50, (max(Mag) + 20)]);
    hold off;
end