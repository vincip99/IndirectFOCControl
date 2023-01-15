clear all
close all
clc

%% Dati di Targa
Pn = 150e3; % Potenza nominale (W)
Vn = 220; % Tensione nominale (V)
fn = 300; % Frequenza nominale (Hz)
sigman = 0.015; % Coefficiente di Attrito
p = 6; % Poli
J = 5; % Momento di Inerzia (kgm^2)
w0 = 2*pi*fn/p; % Velocità Camppo Magnetico Rotante (rad/s)

%% Dati di Targa Stimati
eta = 0.98; % Rendimento % Rendimento tipico di un motore asincrono di quella potenza
Imn = 0.2*Pn/Vn; % Corrente di Magnetizzazione (A) 
Tk = 360; % Coppia di Rovesciamento (Nm) 
sn = 0.02; % Scorrimento nominale % Scorrimento tipico tra 0.02 e 0.05
In = Imn/0.35; % Corrente nominale (A) % stima a partire da Imn
wn = w0*(1-sn); % Velocità nominale (rad/s) % stima a partire da sn

%% Dati Motore Calcolati
Ldt = 3*p*(Vn/sqrt(3))^2/(4*pi*fn*Tk); % Induttanza di Dispersione totale (H)
Lds = Ldt/2; % Induttanza di Dispersione statorica (H)
Ldr = Ldt/2; % Induttanza di Dispersione rotorica (H)
Rr = Pn*sn/3/In^2/(1-sn); % Resistenza Rotorica (Ohm)
Pj = Pn*(1-eta)/eta; % Potenza dissipata per eff. Joule (W)
Pjs = Pj - 3*Rr*In^2; % Potenza statorica per eff. Joule (W)
Rs = Pjs/3/In^2; % Resistenza Statorica (Ohm)
Lmu = (Vn/sqrt(3))/Imn/(2*pi*fn); % Induttanza di Magnetizzazione (H)

%% Dati Convertitore 
Vdc = 350; % tensione alimentazione convertitore (V)
delta = 0; % delta per isteresi

%% Dati Controllo
Tr = (Lmu + Ldr)/Rr; % Costante di tempo rotorica totale
kp = 1;
ki = 10;