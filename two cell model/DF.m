function dx = DF(t,x)
global gNaF mV12 mk hV12 hk htau hTV12 hTk                     %% Fast sodium (NaF)
global gKdr nV12 nk ntau nTV12 nTk                             %% Potassium rectifier (Kdr)
global gNaP mPV12 mPk hPV12 hPk hPtau hPTV12 hPTk              %% Persistent sodium (NaP)
global wSyn wS Esyn gGap                                          %% synaptic conductances  
global sV12 sk alphaS tauS                                      %% AMPA parameters
global C gL Eleak ENa EK                                 %% general parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 2;
dx = 0*x;
v  = x(1:N);
I  = gL*(v-Eleak);
j = 1;
% NaF
m_inf = (1+exp(-(v-mV12)/mk)).^(-1);
j     = j+1;
h     = x((j-1)*N+1:j*N);
h_inf = (1+exp(-(v-hV12)/hk)).^(-1); 
tau   = htau*cosh((v-hTV12)/hTk).^(-1); 
dx((j-1)*N+1:j*N) = (h_inf-h)./tau;
INaF  = gNaF*m_inf.^3.*h.*(v-ENa);
I     = I+INaF;
%Kdr
j     = j+1;
n     = x((j-1)*N+1:j*N);
n_inf = (1+exp(-(v-nV12)/nk)).^(-1); 
tau   = ntau*cosh((v-nTV12)/nTk).^(-1); 
dx((j-1)*N+1:j*N) = (n_inf-n)./tau;
IKdr  = gKdr*n.^4.*(v-EK);
I     = I+IKdr; 
% NaP
mP_inf = (1+exp(-(v-mPV12)/mPk)).^(-1); 
j      = j+1;
hP     = x((j-1)*N+1:j*N);
hP_inf = (1+exp(-(v-hPV12)/hPk)).^(-1); 
tau    = hPtau*cosh((v-hPTV12)/hPTk).^(-1); 
dx((j-1)*N+1:j*N)  = (hP_inf-hP)./tau;
INaP   = gNaP.*mP_inf.*hP.*(v-ENa); 
I      = I+INaP;
% Gap 
%     I(1) = I(1)+gGap*(v(1)-v(2));  
%     I(2) = I(2)+gGap*(v(2)-v(1)); 
vdif = repmat(v,1,N)-repmat(v',N,1);
Igap = gGap*sum(vdif,2);
I = I+Igap;
% AMPA
j      = j+1;
s      = x((j-1)*N+1:j*N);         %AMPA s variable
s_inf = (1+exp(-(v-sV12)/sk)).^(-1);
dx((j-1)*N+1:j*N) = (s_inf.*(1-s)-alphaS*s)/tauS;
sAMPA = wSyn*wS*s;
Iampa = sAMPA.*(v-Esyn);
I = I+Iampa;
% voltage
dx(1:N) = -I/C;
t
