%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
f_name = 'Figure 2';
time_max = 40000;
col =  [ 'r' 'k'];
par_name = 'gNaP';
par = [ 3; 4; 5];      % nS   -  gap junction conductance    
Npar = length(par);
Nlines = 1;
Tlength = 20.0;
Tticks = [0 5 10 15 20];
Tlb = {'0','5','10','15','20'};
%% PANELS B1-B3   # only In1 has INaP
EL1 = [-71.4; -71.4];
EL2 = [-58.4; -58.4];
T0 = [ 14; 18;  19 ];         
% Eleak = [-71.4; -58.4];   