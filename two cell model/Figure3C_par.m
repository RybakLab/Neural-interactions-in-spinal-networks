%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 3C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
f_name = 'Figure 3C';
time_max = 35000;
col =  [ 'k' 'b'];
par_name = 'wSyn';
par = [ 0; 0.5; 1; 2 ];      % nS   -  gap junction conductance    
Npar = length(par);
g_NaP = [0; 4]; 
Nlines = 2;
Tlength = 11;
Tticks = [0 2 4 6 8 10];
Tlb = {'0','2 ','4','6','8','10 '};
%% PANELS C1,C2   # only target neuron (In2) has INaP
EL1(1:Nlines) = -58.4;
EL2 = [-72.2; -69];
T0 = [ 13.    12;     
       10.63    21.2;  
       12.75    14.1;  
       15.7    14.65;
       ];
% Eleak = [-58.4; -72.2];    % Fig 3C1    # In1 is tonically active , In2 is silent
% Eleak = [-58.4; -69];      % Fig 3C2    # In1 is tonically active , In2 is bursting

