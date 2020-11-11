%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 1B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
f_name = 'Figure 1B';
time_max = 40000;
col =  [ 'r' 'k'];
par_name = 'gGap';
par = [ 0; 0.05; 0.1; 0.2 ];      % nS   -  gap junction conductance    
Npar = length(par);
g_NaP = [4; 0]; 
Nlines = 3;
Tlength = 11;
Tticks = [0 2 4 6 8 10];
Tlb = {'0','2 ','4','6','8','10 '};
%% PANELS B1-B3   # only In1 has INaP
EL1 = [-71.4; -69; -69];
EL2 = [-59.6; -59.6; -59.3];
T0 = [ 6     11.9   6.6;  
       15.5  10.3   5.1;  
       26    7      11.1;
       13.5  6      13.5;
     ];         
% Eleak = [-71.4; -59.6]; % Fig 1B1   # both neurons are silent
% Eleak = [-69; -59.6];   % Fig 1B2   # In1 is bursting; In2 is silent 
% Eleak = [-69; -59.3];   % Fig 1B3   # In1 is bursting; In2 is spiking 

