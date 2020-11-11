%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 3B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
f_name = 'Figure 3B';
time_max = 35000;
col =  [ 'r' 'b'];
par_name = 'wSyn';
par = [ 0; 0.5; 1; 2 ];      % nS   -  gap junction conductance    
Npar = length(par);
g_NaP = [4; 0]; 
Nlines = 2;
Tlength = 11;
Tticks = [0 2 4 6 8 10];
Tlb = {'0','2 ','4','6','8','10 '};
%% PANELS B1,B2   # only source neuron (In1) has INaP
EL1(1:Nlines) = -65.5;
EL2 = [-59.6; -59.3];
T0 = [ 13.    13;     
       10.63    20;  
       12.75    12.9;  
       12.75    14.2;   
     ];    
% Eleak = [-65.5; -59.6];    % Fig 3B1   # In1 is in a bursting mode, In2 is silent
% Eleak = [-65.5; -59.3];    % Fig 3B2   # In1 is in a bursting mode, In2 is spiking
