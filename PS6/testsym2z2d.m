%% testsym2z2d
% ECE310 DSP   Cooper Union Fall 2019   Prof FF
%
z1=sym('z1'); z2=sym('z2');
zvars= [z1,z2];
N1N2= [2,3];
N1= N1N2(1); N2= N1N2(2);
M1= 2*N1+1; M2= 2*N2+1;
h= reshape(1:M1*M2,M1,M2); % [n1,n2], -N1<=n1<=N1, -N2<=n2<=N2
H= sym(0);
for n1=1:M1
    for n2= 1:M2
        H= H+h(n1,n2)*z1^(n1-1-N1)*z2^(n2-1-N2);
    end
end
h  % 2D FIR filter
H  % 2D z transform (symbolic)
h0= sym2z2d(H,zvars,N1N2)   % should return same FIR filter coeff matrix


    