%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 3A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
f_name = 'Figure 3A';
time_max = 25000;
col =  [ 'r' 'b'];
par_name = 'wSyn';
par = [ 0; 0.5; 1; 2 ];      % nS   -  gap junction conductance    
Npar = length(par);
g_NaP = [4; 4]; 
Nlines = 3;
Tlength = 11;
Tticks = [0 2 4 6 8 10];
Tlb = {'0','2 ','4','6','8','10 '};
%% PANELS A1-A3   # both neurons incorporate INaP
EL1(1:Nlines) = -65.5;
EL2 = [-71.4; -69; -64.9];
T0 = [ 11.65    12.05     10.45;  
       10.63   12.7   12.75;  
       12.75     12.9   12.82;
       12.75    12.83   12.75;
     ];    
% Eleak = [-65.5; -71.4];    % Fig 3A1   # In is in a bursting mode, In is silent
% Eleak = [-65.5; -69];      % Fig 3A2   #  both neurons are in a  bursting mode
% Eleak = [-65.5; -64.9];    % Fig 3A3   # In1 is in bursting mode, In2 is tonically active

