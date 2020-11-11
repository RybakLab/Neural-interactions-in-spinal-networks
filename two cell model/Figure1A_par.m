%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 1A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
f_name = 'Figure 1A';
time_max = 35000;
col =  [ 'r' 'b'];
par_name = 'gGap';
par = [ 0; 0.05; 0.1; 0.2 ];      % nS   -  gap junction conductance    
Npar = length(par);
g_NaP = [4; 4]; 
Nlines = 3;
Tlength = 11;
Tticks = [0 2 4 6 8 10];
Tlb = {'0','2 ','4','6','8','10 '};
%% PANELS A1-A3   # both neurons incorporate INaP
EL1(1:Nlines) = -69;
EL2 = [-72.2; -65.5; -64.9];
T0 = [ 6.4    6      6.5;  
       8.1    12.25  6.1;  
       9.39   15     13.5;
       11.09  13.1   11.7;
     ];    
% Eleak = [-69; -72.2];   % Fig 1A1   # In1 is in a bursting mode, In2 is silent
% Eleak = [-69; -65.5];   % Fig 1A2   # both neurons are in a  bursting mode
% Eleak = [-69; -64.9];   % Fig 1A3   # In1 is in bursting mode, In2 is tonically active
