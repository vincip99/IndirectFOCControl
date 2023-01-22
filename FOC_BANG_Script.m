clc
clear all



P_n = 150000;
Vs_n = 220;
f_n = 300;
s_n = 0.015;
p = 6;
Vdc=350;

%% dati arbitrari
eta = 0.92;
cos_phi = 0.95;
k_lim = 2;                  %rapporto Tk_n/T_n
k_im = 0.4;                 %rapporto Im_n/Is_n
Tau = 2e-3;
J = 5;
k_eps = 0.01;





%% dati calcolati
Vsn_y = Vs_n/sqrt(3);

Pa = P_n/eta;
w_n = 2*pi*f_n;
wr_n = w_n/p*(1-s_n);
ws_n = w_n-p*wr_n;
Is_n = Pa/(3*Vsn_y*cos_phi);
Im_n = k_im*Is_n;
T_n = P_n/wr_n;
Tk_n = k_lim*T_n;

Pdelta = T_n*(w_n/p);
Pjs = (Pa-Pdelta);
Rs = (Pjs/3)/(Is_n^2);
Rr = Rs;

Phi_n = Vsn_y/(w_n);
Lm = Phi_n/Im_n;

 %calcolo con costante di tempo
% Ls = Rs*Tau;       
% Lr = Ls;

 %calcolo con coppia di rovesciamento
Ltot = (3*p/(2*Tk_n))*(Vsn_y/w_n)^2;
Ls = Ltot/2;
Lr = Ltot/2;
sigma_r = Lr/Lm;
sigma_s = Ls/Lm;
Tr = Lm*(1+sigma_r)/Rr;

eps_i=k_eps*Is_n*sqrt(2);

fs = 20e3; % Frequenza di campionamento
Ts = 1/fs;
kp_w = T_n/(0.05*wr_n)/5;
%kp_w = 10000*Ls*fs;
ki_w = 0.5*(kp_w^2)/J;
%ki_w = 0.5*kp_w^2/Ls;
T_rate_max = T_n/0.01;

