% Ivan Chowdhury
% 10/7/2019
% Digital Signal Processing
% Problem Set 2

clc, close all, clear all;

%% 1d)
% H(z)
p1 = [1/3,-5/2,-5/2];
z1 = [1/2;-4];
[b1, a1] = zp2tf(z1,p1,1);
[phil,w1] = phasez(b1,a1);

% Hmin(z)
p2 = [-2/5;-2/5;1/3];
z2 = [0;1/2;-1/4];
[b2,a2] = zp2tf(z2,p2,1);
[phi2,w2] = phasez(b2,a2);

% A(z)
p3 = [-4;-2/5;-2/5];
z3 = [0;-1/4;-5/2];
[b3,a3] = zp2tf(z3,p3,1);
[phi3,w3] = phasez(b3,a3);

figure
plot(rad2deg(phil),rad2deg(w1))

hold on
plot(rad2deg(phi2),rad2deg(w2))
plot(rad2deg(phi3),rad2deg(w3))

title("Phase Response");
legend("H(z)","Hmin(z)","A(z)");
xlabel("Frequency(rad)");
ylabel("Phase(rad)");