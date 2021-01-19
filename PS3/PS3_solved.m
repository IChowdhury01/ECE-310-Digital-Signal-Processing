% Ivan Chowdhury
% 11/1/2019
% Digital Signal Processing
% Problem Set 3

clc, close all, clear all;

%% 1
%c
Wp = [1.2e6 1.5e6] * 2*pi;
Ws = [1e6 1.6e6] * 2*pi;

[nB,WnB] = buttord(Wp,Ws,2,30,'s');
[nC1,WnC] = cheb1ord(Wp,Ws,2,30,'s');
[nC2, WnC2] = cheb2ord(Wp,Ws,2,30,'s');
[nE,WnE] = ellipord(Wp,Ws,2,30,'s');

[zB,pB,kB] = butter(nB,WnB,'s');
[zC1,pC1,kC1] = cheby1(nC1,2,Wp,'s');
[zC2,pC2,kC2] = cheby2(nC2, 30, Ws,'s');
[zE,pE,kE] = ellip(nE,2,30,Wp,'s');

%d
subplot(2,2,1)
zplane(zB,pB);
title("Analog Butterworth");

subplot(2,2,2)
zplane(zC1,pC1);
title("Analog Chebyshev I");

subplot(2,2,3)
zplane(zC2,pC2);
title("Analog Chebyshev II");

subplot(2,2,4)
zplane(zE,pE);
title("Analog Elliptic");

%e
[nL, WpL] = ellipord(1,1.59,2,30,'s');
[zL,pL,kL] = ellip(nL,2,30,1,'s');
figure();
zplane(zL,pL);
title("Elliptic Lowpass Prototype");

%f
w = linspace(0,2e6,1000)*2*pi;

[bB, aB] = zp2tf(zB,pB,kB);
hB = freqs(bB,aB,w);
figure()
subplot(2,1,1)
magB = mag2db(abs(hB));
plot(w*1/(2*pi),magB);
title("Butterworth Filter: Magnitude Response");
xlim([0 2e6]);
xlabel("Frequency (Hz)");
ylim( [-50 0]);
ylabel("Magnitude (dB)");
line([0 200e3], [-30 -30], "LineStyle", "--");
line([0 200e3], [-2 -2], "LineStyle", "--");
line([100e3 100e3], [-100 0], "LineStyle", "--");
line([130e3 130e3], [-100 0], "LineStyle", "--");
line([90e3 90e3], [-100 0], "LineStyle", "--");
line([140e3 140e3], [-100 0], "LineStyle", "--");
subplot(2,1,2)
plot(w*1/(2*pi), unwrap(angle(hB))*180/pi);
title("Butterworth Filter: Phase Response");
xlim([0 2e6]);

[bC1,aC1] = zp2tf(zC1,pC1,kC1);
hC1 = freqs(bC1,aC1,w);
figure()
subplot(2,1,1)
magC1 = mag2db(abs(hC1));
plot(w*1/(2*pi),magC1);
title("Chebyshev I: Magnitude Response");
xlim([0 2e6]);
xlabel("Frequency (Hz)");
ylim([-50 0]);
ylabel("Magnitude (dB)");
line([0 200e3], [-30 -30], "LineStyle", "--");
line([0 200e3], [-2 -2], "LineStyle", "--");
line([100e3 100e3], [-100 0], "LineStyle", "--");
line([130e3 130e3], [-100 0], "LineStyle", "--");
line([90e3 90e3], [-100 0], "LineStyle", "--");
line([140e3 140e3], [-100 0], "LineStyle", "--");
subplot(2,1,2)
plot(w*1/(2*pi),unwrap(angle(hC1))*180/pi);
title("Chebyshev I: Phase Response");
xlabel("Frequency (Hz)");
ylabel("Phase (degrees)");
xlim([0 2e6]);

[bC2,aC2] = zp2tf(zC2,pC2,kC2);
hC2 = freqs(bC2,aC2,w);
figure()
subplot(2,1,1)
magC2 = mag2db(abs(hC2));
plot(w*1/(2*pi),magC2);
line([0 200e3], [-30 -30], "LineStyle", "--");
line([0 200e3], [-2 -2], "LineStyle", "--");
line([100e3 100e3], [-100 0], "LineStyle", "--");
line([130e3 130e3], [-100 0], "LineStyle", "--");
line([90e3 90e3], [-100 0], "LineStyle", "--");
line([140e3 140e3], [-100 0], "LineStyle", "--");
title("Chebyshev II Magnitude Response");
xlim([0 2e6]);
xlabel("Frequency (Hz)");
ylim([-50 0]);
ylabel("Magnitude (dB)");
subplot(2,1,2)
plot(w*1/(2*pi),unwrap(angle(hC2))*180/pi);
title("Chebyshev II: Phase Response");
xlabel("Frequency (Hz)");
ylabel("Phase degrees)");
xlim([0 2e6]);

[bE, aE] = zp2tf(zE,pE,kE);
hE = freqs(bE,aE,w);
figure()
subplot(2,1,1)
magE = mag2db(abs(hE));
plot(w*1/(2*pi),magE);
title("Elliptic Filter: Magnitude Response");
xlim([0 2e6]);
xlabel("Frequency (Hz)");
ylim([-50 0]);
ylabel("Magnitude (dB)");
line([0 200e3], [-30 -30], "LineStyle", "--");
line([0 200e3], [-2 -2], "LineStyle", "--");
line([100e3 100e3], [-100 0], "LineStyle", "--");
line([130e3 130e3], [-100 0], "LineStyle", "--");
line([90e3 90e3], [-100 0], "LineStyle", "--");
line([140e3 140e3], [-100 0], "LineStyle", "--");
subplot(2,1,2)
plot(w*1/(2*pi),unwrap(angle(hE))*180/pi);
title("Elliptic Filter: Phase Response");
xlabel("Frequency (Hz)");
ylabel("Phase (degrees)");
xlim([0 2e6]);

%g
figure()
hold on
plot(w*1/(2*pi),magB);
plot(w*1/(2*pi),magC1);
plot(w*1/(2*pi),magC2);
plot(w*1/(2*pi),magE);
xlim([1.15e6 1.55e6]);
ylim([-2.5 .5]);
title("Zoomed in Magnitude Response");
hold off

%h

Low_Stopband = [magB(450); magC1(450); magC2(450); magE(450)];
High_Stopband = [magB(700); magC1(700); magC2(700); magE(700)];
t = table(["Butterworth"; "Chebyshev I"; "Chebyshev II"; "Elliptic"],Low_Stopband,High_Stopband)

%% 2
%b
fs = 6e6;
Wp_digital = [1.2e6 1.5e6]*2/fs;
Ws_digital = [1.0e6 1.6e6]*2/fs;

[nb,wn] = buttord(Wp_digital,Ws_digital,2,30);      
[zb,pb,kb] = butter(nb,wn,'bandpass');
[nc1,wp1] = cheb1ord(Wp_digital,Ws_digital,2,30);  
[zc1,pc1,kc1] = cheby1(nc1,2,wp1,'bandpass');
[nc2,wp2] = cheb2ord(Wp_digital,Ws_digital,2,30);  
[zc2,pc2,kc2] = cheby2(nc2,30,wp2,'bandpass');
[ne,we] = ellipord(Wp_digital,Ws_digital,2,30);  
[ze,pe,ke] = ellip(ne,2,30,we,'bandpass');

% Butterworth Filter Order: 16
% Chebyshev I Filter Order: 10
% Chebyshev II Filter Order: 10
% Eliptical Filter Order: 6

%c
f = linspace(0, fs/2, 2000);

[bb, ab] = butter(nb,wn);
[bcheb1, acheb1] = cheby1(nc1,2,wp1);
[bcheb2, acheb2] = cheby2(nc2,30,wp2);
[be,ae] = ellip(ne,2,30,we);

hb_d = freqz(bb,ab,f,fs);
figure
subplot(2,2,1);
plot(f,20*log10(hb_d));
axis([0 fs/2 -50 1]);
title("Butterworth");
ylabel("Magnitude (dB)");
xlabel("Frequency (Hz)");

hc1_d = freqz(bcheb1,acheb1,f,fs);
subplot(2,2,2);
plot(f,20*log10(hc1_d));
axis([0 fs/2 -50 1]);
title("Chebyshev 1");
ylabel("Magnitude (dB)");
xlabel("Frequency (Hz)");

hc2_d = freqz(bcheb2,acheb2,f,fs);
subplot(2,2,3);
plot(f,20*log10(hc2_d));
axis([0 fs/2 -50 1]);
title("Chebyshev 2");
ylabel("Magnitude (dB)");
xlabel("Frequency (Hz)");

he_d = freqz(be,ae,f,fs);
subplot(2,2,4);
plot(f,20*log10(he_d));
axis([0 fs/2 -50 1]);
title("Elliptic");
ylabel("Magnitude (dB)");
xlabel("Frequency (Hz)");

%d
figure
subplot(2,2,1);
zplane(zb,pb)
grid
title("Butterworth Filter")

subplot(2,2,2);
zplane(zc1,pc1)
grid
title("Chebyshev I Filter")

subplot(2,2,3);
zplane(zc2,pc2)
grid
title("Chebyshev II Filter")

subplot(2,2,4);
zplane(ze,pe)
grid
title("Elliptic Filter")
%% 3 
%a
[bc1_a, ac1_a] = cheby1(nC1,2,WnC,'s');
[bc2_a, ac2_a] = cheby2(nC2,30,WnC2,'s');
[bcheb1,acheb1] = impinvar(bc1_a,ac1_a,fs);
[bcheb2,acheb2] = impinvar(bc2_a,ac2_a,fs);

%b
hc1_dig = freqz(bcheb1,acheb1,f,fs);
figure
subplot(2,1,1);
plot(f,20*log10(hc1_dig));
axis([0 fs/2 -50 1]);
title("Chebyshev 1");
ylabel("Magnitude (dB)");
xlabel("Frequency (Hz)");

hc2_dig = freqz(bcheb2,acheb2,f,fs);
subplot(2,1,2);
plot(f,20*log10(hc2_dig));
axis([0 fs/2 -50 1]);
title("Chebyshev 2");
ylabel("Magnitude (dB)");
xlabel("Frequency (Hz)");

%c
figure
subplot(2,1,1);
zplane(bcheb1,acheb1)
grid
title("Chebyshev 1 Filter")

subplot(2,1,2);
zplane(bcheb2,acheb2)
grid
title("Chebyshev 2 Filter")
%% 4
frequency = linspace(0,1,1000);
chebwindow=chebwin(31,30);

figure
zplane(chebwindow.');
title("Chebyshev Window");

[hcheb,wcheb] = freqz(chebwindow,1,1000);
hcheb = hcheb/hcheb(1);

figure
plot(frequency,2*log10(abs(hcheb)))
title("Chebyshev Magnitude Response");
xlabel("Frequency");
ylabel("dB");

% Mainlobe relative to window: 0.464

Beta = 3.14;
kaiserwindow = kaiser(31,Beta);
[hkai,wkai] = freqz(kaiserwindow,1,1000);
hkai = hkai/hkai(1)
figure
hold on
plot(frequency,[abs(hcheb),abs(hkai)])
title('|H(\omega')
xlabel("Frequency");
ylabel("dB");

figure
plot(frequency, [2*log10(abs(hcheb)),2*log10(abs(hkai))]);
title("Superimposed Magnitude Responses")
xlabel("Frequency");
ylabel("dB");

figure
zplane(chebwindow.',kaiserwindow.');
title("Superimposed Zeros")

sideLobe = 20*log10(hkai(1)./abs(hkai));
sideLobe = sideLobe(95:end);
level = min(sideLobe)
Energy = sum(abs(hkai(95:end)).^2/(sum(abs(hkai).^2)))