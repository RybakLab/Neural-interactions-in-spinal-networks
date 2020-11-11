global C gL  ENa EK Esyn                         %% general parameters 
global gNaF mV12 mk hV12 hk htau hTV12 hTk       %% Fast sodium (NaF)
global gKdr nV12 nk ntau nTV12 nTk               %% Potassium delayed rectifier (Kdr)
global mPV12 mPk hPV12 hPk hPtau hPTV12 hPTk     %% Persistent sodium (NaP)                                %% synaptic conductances 
global sV12 sk alphaS tauS wS                      %% AMPA parameters                           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  general parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C  = 40;
gL = 1;
gNaF = 80; 
gKdr = 100; 
ENa  =  55;        % mV                          # sodium reversal potential 
EK   = -80;        % mV                          # potassium reversal potential
Esyn = 0;         % mV                           # AMPA synapse reversal potential
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  parameters of intrinsic currents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NaF (from Brocard et al 2013)
mV12  = -42.5;    % mV                           # activation half-voltage of NaF
mk    =  6.5;     % mV                           # activation slope of NaF
hV12  = -65.5;    % mV                           # inactivation half-voltage of  of NaF
hk    = -10.8;    % mV                           # inactivation slope of NaF
htau  =  35.2;    % ms                           # inactivation time costant of NaF
hTV12 = -65.5;    % mV                           # half-voltage of inactivation time constant of NaF
hTk   = 12.8;     % mV                           # slope of inactivation time constant of NaF
%% Kdr (from Brocard et al 2013)
nV12  = -34.5;    % mV                           # activation half-voltage of Kdr 
nk    =  5;       % mV                           # activation slope of Kdr
ntau  =  10;      % ms                           # activation time costant of Kdr
nTV12 = -34.5;    % mV                           # half-voltage of activation time constant of Kdr
nTk   =  10;      % mV                           # slope of activation time constant of Kdr
%% Persistent sodium (from Brocard et al 2013)
mPV12  = -52;     % mV                           # activation half-voltage of NaP
mPk    =  3.2;    % mV                           # activation slope of NaP
hPV12  = -57;     % mV                           # inactivation half-voltage of  of NaP
hPk    = -5;      % mV                           # inactivation slope of NaP
hPtau  =  9000;   % ms                           # inactivation time costant of NaP
hPTV12 = -57;     % mV                           # half-voltage of inactivation time constant of NaP
hPTk   = 8;       % mV                           # slope of inactivation time constant of NaP   
%% chemical synapse (AMPA, Compte et al JNP03)
sV12 = -20; sk = 2;                  
alphaS = 1; tauS = 15;    
wS = [ 0     0;
       1     0  ];   
