clear all
close all
clc

%% Dati di Targa da progetto
Pn = 150e3; % Potenza nominale (W)
Vn = 220; % Tensione nominale (V)
fn = 300; % Frequenza nominale (Hz)
sn = 0.015; % Scorrimento nominale
p = 6; % Poli
J = 5; % Momento di Inerzia (kgm^2)

%% Grandezze ricavate
w = 2*pi*fn; % pulsazione nominale (rad/s)
w0 = w/p; % Velocità Campo Magnetico Rotante (rad/s)
Vny = Vn/sqrt(3); % Tensione nominale di fase (V)

%% Dati di Targa Stimati
eta = 0.97; % Rendimento % Rendimento tipico di un motore asincrono di quella potenza
cos_phi = 0.95; % cos phi stiamto % tipico di un motore asincrono di quella potenza
Pa = Pn/eta; % potenza assorbita all'ingresso (W)
In = Pa/(3*Vny*cos_phi); % Corrente nominale (A)
Imn = 0.35*In; % Corrente di Magnetizzazione (A) 
wn = w0*(1-sn); % Velocità nominale (rad/s) % ricavata a partire da sn
Tn = Pn/wn; % coppia nominale (Nm)
Tk = 2*Tn; % Coppia di Rovesciamento (Nm) % circa 2 volte la coppia nominale

%% Dati Motore Calcolati
Ldt = 3*p*Vny^2/(2*w^2*Tk); % Induttanza di Dispersione totale (H)
Lds = Ldt/2; % Induttanza di Dispersione statorica (H)
Ldr = Ldt/2; % Induttanza di Dispersione rotorica (H)
Lmu = Vny/(Imn*w); % Induttanza di Magnetizzazione (H)

Pdelta = Tn*w0;
Pjs = (Pa-Pdelta);
Rs = (Pjs/3)/(In^2);
Rr = Rs;
% Rr = Pn*sn/3/In^2/(1-sn); % Resistenza Rotorica (Ohm)
% Pj = Pn*(1-eta)/eta; % Potenza dissipata per eff. Joule (W)
% Pjs = Pj - 3*Rr*In^2; % Potenza statorica per eff. Joule (W)
% Rs = Pjs/3/(In^2); % Resistenza Statorica (Ohm)


Ls = Lmu + Lds;
sigmas = Lds/Lmu;
sigmar = Ldr/Lmu;
sigma = 1/(1+sigmar)/(1+sigmas);

%% Dati Convertitore 
Vdc = 350; % tensione alimentazione convertitore (V)
delta = 0; % delta per isteresi

%% Dati Controllo
T_rate_max = Tn/0.01;
fs = 20e3; % Frequenza di campionamento
Ts = 1/fs;
Tr = (Lmu + Ldr)/Rr; % Costante di tempo rotorica totale (H/Ohm)
kp = Tn/(0.05*wn)/5; % Coefficente proporzionale
ki = 0.5*(kp^2)/J; % Coefficente Integrale