clear all
close all
clc

%% Dati di targa motore
P_n = 150000;
Vs_n = 220;
f_n = 300;
s_n = 0.015;
p = 6;
J = 5;
Vdc = 350;


%% dati arbitrari (sono stati scelti da noi in riferimento ad un Datasheet di un motore di pari potenza)
eta = 0.92;
cos_phi = 0.9;
k_lim = 2.5;                  %rapporto Tk_n/T_n
k_im = 0.4;                 %rapporto Im_n/Is_n
k_eps = 0.01;


%% dati calcolati
Vsn_y = Vs_n/sqrt(3);       %Tensione Vs a stella
Pa = P_n/eta;               %Potenza assorbita
w_n = 2*pi*f_n;             %pulsazione nominale
wr_n = w_n/p*(1-s_n);       %velocità rotorica nominale 
Is_n = Pa/(3*Vsn_y*cos_phi);    %Corrente statorica nominale
Im_n = k_im*Is_n;               %Corrente magnetizzante nominale
T_n = P_n/wr_n;                 %Coppia nominale
Tk_n = k_lim*T_n;               %Coppia di rovesciamento nominale

Pdelta = T_n*(w_n/p);           %Potenza al traferro
Pjs = (Pa-Pdelta);              %Potenza dissipata sulla resistenza
Rs = (Pjs/3)/(Is_n^2);          %Resistenza statorica
Rr = Rs;                        %Resistenza rotorica

Phi_n = Vsn_y/(w_n);            %Flusso nominale
Lm = Phi_n/Im_n;                %Induttanza di magnetizzazione

Ltot = (3*p/(2*Tk_n))*(Vsn_y/w_n)^2;    %Induttanza totale
Ls = Ltot/2;                            %Ind. di dispersione statorica
Lr = Ltot/2;                            %Ind. di dispersione rotorica
L_S = Lm+Ls;                            %Ind. totale statorica
sigma_r = Lr/Lm;
sigma_s = Ls/Lm;
sigma = 1/(1+sigma_r)/(1+sigma_s);
Tr = Lm*(1+sigma_r)/Rr;                 %Costante di tempo rotorica

% eps_i=k_eps*Is_n*sqrt(2);               %Banda di isteresi (usata per provare controllo bang-bang)

fs = 10e3;                          %Frequenza di campionamento
Ts = 1/fs;                          %Tempo di campionamento
kp_w = Tk_n/(0.05*wr_n);          %Cost prop. regolatore velocità
ki_w = 0.5*(kp_w^2)/J;              %Cost. integrale regolatore veloictà

%
kpi=(1/2)*Ltot/Ts;
kii=(1/2)*kpi^2/Ltot;
