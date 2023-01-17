clear all
close all
clc

%% Dati di Targa
Pn = 150e3; % Potenza nominale (W)
Vn = 220; % Tensione nominale (V)
fn = 300; % Frequenza nominale (Hz)
sn = 0.015; % Scorrimento nominale
p = 6; % Poli
J = 5; % Momento di Inerzia (kgm^2)
w0 = 2*pi*fn/p; % Velocità Campo Magnetico Rotante (rad/s)

%% Dati di Targa Stimati
eta = 0.97; % Rendimento % Rendimento tipico di un motore asincrono di quella potenza
Imn = 0.3*Pn/Vn; % Corrente di Magnetizzazione (A) 
wn = w0*(1-sn); % Velocità nominale (rad/s) % stima a partire da sn
Tk = 3*Pn/wn; % Coppia di Rovesciamento (Nm) % circa 3 volte la coppia nominale
In = Imn/0.35; % Corrente nominale (A) % stima a partire da Imn

%% Dati Motore Calcolati
Ldt = 3*p*(Vn/sqrt(3))^2/(4*pi*fn*Tk); % Induttanza di Dispersione totale (H)
Lds = Ldt/2; % Induttanza di Dispersione statorica (H)
Ldr = Ldt/2; % Induttanza di Dispersione rotorica (H)
Rr = Pn*sn/3/In^2/(1-sn); % Resistenza Rotorica (Ohm)
Pj = Pn*(1-eta)/eta; % Potenza dissipata per eff. Joule (W)
Pjs = Pj - 3*Rr*In^2; % Potenza statorica per eff. Joule (W)
Rs = Pjs/3/In^2; % Resistenza Statorica (Ohm)
Lmu = (Vn/sqrt(3))/Imn/(2*pi*fn); % Induttanza di Magnetizzazione (H)

Ls = Lmu + Lds;
sigmas = Lds/Lmu;
sigmar = Ldr/Lmu;
sigma = 1/(1+sigmar)/(1+sigmas);

%% Dati Convertitore 
Vdc = 350; % tensione alimentazione convertitore (V)
delta = 0; % delta per isteresi

%% Dati Controllo
fs = 20e3; % Frequenza di campionamento
Ts = 1/fs;
Tr = (Lmu + Ldr)/Rr; % Costante di tempo rotorica totale (H/Ohm)
kp = 0.5*Lds*fs; % Coefficente proporzionale
ki = 0.5*kp^2/Lds; % Coefficente Integrale