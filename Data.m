clear all
close all
clc

%% Dati di targa
Pn = 150e3; % Potenza nominale (W)
Vn = 220; % Tensione nominale (V)
fn = 300; % Frequenza nominale (Hz)
sigman = 0.015; % 
p = 6; % Poli
J = 5; % Momento di Inerzia (kgm^2)

%% Dati di targa non pervenuti
eta = 0.98;
imn = 0.2*Pn/Vn;
% Tk = ;

%% Dati motore
% Rs = ;
% Ls = ;
% Rr = ;
% Lr = ;
% Lmu = ;

%% Dati convertitore 
Vdc = 350; % tensione alimentazione convertitore (V)
delta = 10e-3; % delta per isteresi