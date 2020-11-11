from brian2 import *
from brian2.units.allunits import *
import IPython
set_device('cpp_standalone',directory=None)
# prefs.devices.cpp_standalone.openmp_threads = 4
sd = 123
seed(sd)
numpy.random.seed(sd)
####################################################################################################################
# simulation parameters
####################################################################################################################
defaultclock.dt = 0.02 * ms                    # integration step
dt      = defaultclock.dt
#### to estimate results
thr    = -35           * mV                    # thresholh for spike counting
binH   =  100           * ms                    # bin to plot histogram of neuron population activity
t_scale = binH*dt/ (ms*second)
trsh_scale = 0.5                                # threshold to determine bursting activity in neuron population 
##### to plot results
shiftV = 80           * mV                    # shift to plot neuron activity
duration = 60         * second                # duration of simulation
t_start  = 20          * second                # start time to calculate bursting parameters
tsim = arange(0,duration-t_start,dt)        # time vector to calculate bursting parameters 
t0   = int(t_start/dt)+1                       # start index to calculate bursting parameters
####################################################################################################################
# Model parameters
####################################################################################################################
N = 100                                        # number of neurons
ENa = 55    * mV
EK  = -80   * mV
##### General neuron parameters
Cm        =  40* pF                           # membrane capacitance
g_L       =  1   * nsiemens                     # mean leak conductance 
var_gL    =  0.2                                   # varience of leak conductance
E_Lnap    = -74  * mV                           # mean leak reversal potential
var_ELnap =  0.2                                # varience of leak reversal potential
E_L       = -70  * mV                           # mean leak reversal potential
var_EL    =  0.2                               # varience of leak reversal potential
g_Na      =  80  * nsiemens                     # mean fast sodium conductance
var_gNa   =  0.                                  # varience of sodium conductance
g_Kdr     =  100   * nsiemens                     # mean potassium rectifier conductance
var_gKdr  =  0.                                   # varience of potassium rec tifier conductance                                                          
g_NaP     =  4.0 * nsiemens                     # mean persistent sodium conductance
var_gNaP  =  0.2                                  # varience of persistent sodium conductance
Nnap      = 40                                  # initialization of Nu of neurons with NaP                  
###### Connections
gGap = 0.03 * nS                           # gap junction conductance
pGap = 0.3
wSyn = 0   * mV                           # chemical synapse conductance
pSyn = 0.1
dSyn = 2      * ms
f = open(f'wSyn_gGap_nNaP={Nnap/N*100:.0f}_gNaP={g_NaP/nS:.1f}.txt',"a")
##### Parameters of ionic currents
## Fast sodium (Na fast)
mV12  = -42.5    * mV                           # activation half-voltage of Na fast
mk    =  6.5       * mV                           # activation slope of Na fast
hV12  = -65.5    * mV                           # inactivation half-voltage of  of Na fast
hk    = -10.8    * mV                           # inactivation slope of Na fast
h_tau  =  35.2   * ms                           # inactivation time costant of Nafast
hTV12 = -65.5    * mV                           # half-voltage of inactivation time constant of Nafast
hTk   = 12.8     * mV                           # slope of inactivation time constant of Nafast
## Potassium rectifier (Kdr)
nV12  = -34.5    * mV                           # activation half-voltage of Kdr 
nk    =  5       * mV                           # activation slope of Kdr
n_tau  =  10       * ms                           # activation time costant of Kdr
nTV12 = -34.5    * mV                           # half-voltage of activation time constant of Kdr
nTk   = 10       * mV                           # slope of activation time constant of Kdr
## Persistent sodium (NaP from Brocard et al 2013)
mPV12  = -52     * mV                           # activation half-voltage of NaP
mPk    =  3.2    * mV                           # activation slope of NaP
hPV12  = -57     * mV                           # inactivation half-voltage of  of NaP
hPk    = -5      * mV                           # inactivation slope of NaP
hP_tau =  9000  * ms                           # inactivation time costant of NaP
hPTV12 = -57     * mV                           # half-voltage of inactivation time constant of NaP
hPTk   = 8     * mV                           # slope of inactivation time constant of NaP
####################################################################################################################
# Model description
####################################################################################################################
#### Neurons
eqs  = Equations('''
                ### leak current
                    IL       =  gL*(v-EL)                          : amp
                ### na fast current
                    INa      =  gNa*m**3*h*(v-ENa)                 : amp
                    m        =  1/(1+exp(-(v-mV12)/mk))            : 1
                    hinf     =  1/(1+exp(-(v-hV12)/hk))            : 1
                    htau     =  h_tau/cosh((v-hTV12)/hTk)          : second
                    dh/dt    =  (hinf-h)/htau                      : 1
                ### Kdr current 
                    IKdr     =  gKdr*n**4*(v-EK)                   : amp
                    ninf     =  1/(1+exp(-(v-nV12)/nk))            : 1
                    ntau     =  n_tau/cosh((v-nTV12)/nTk)          : second
                    dn/dt    =  (ninf-n)/ntau                      : 1
                ### distributed parameters    
                    EL                                             : volt
                    gL                                             : siemens
                    gNa                                            : siemens
                    gKdr                                           : siemens
                    ''')
eqs += Equations('''                    
                ### NaP current    
                    INaP     =  gNaP*mP*hP*(v-ENa)                 : amp
                    mP       =  1/(1+exp(-(v-mPV12)/mPk))          : 1
                    hPinf    =  1/(1+exp(-(v-hPV12)/hPk))          : 1
                    hPtau    =  hP_tau/cosh((v-hPTV12)/hPTk)       : second
                    dhP/dt   =  (hPinf-hP)/hPtau                   : 1
                ### distributed parameter    
                    gNaP                                           : siemens                
                    ''')
eqs += Equations('''dv/dt = -(IL+INa+IKdr+INaP-Igap)/Cm      : volt
                    Igap                                                   : amp 
                ''')                     
neu_pop = NeuronGroup(N, eqs, threshold='v>thr', method='rk2', refractory='v>thr')
####################################################################################################################
# Initial conditions and parameter ramdomization 
####################################################################################################################
neu_pop.v    = E_L*(1+0.05*randn(N))              # initial values for memrane potentials (normal)
# neu_pop.EL   = E_L*(1+var_EL*randn(N))            # leak reversal potentials

####
neu_pop.h    = 0.6                                # initial values for Na fast inactivation variable 
neu_pop.gNa   = g_Na*(1+var_gNa*randn(N))         # Na fast conductance
####
neu_pop.n    = 0.002                              # initial values for Kdr actvation variable 
neu_pop.gKdr  = g_Kdr*(1+var_gKdr*randn(N))       # Kdr conductance
####  
neu_pop.hP    = 0.6                               # initial values for NaP inactivation variable
neu_pop.gNaP[Nnap:N] = 0
neu_pop.gNaP[0:Nnap] = g_NaP*(1+var_gNaP*randn(Nnap))        # NaP conductance
neu_pop.EL[0:Nnap]    = E_Lnap*(1+var_ELnap*randn(Nnap))            # leak reversal potentials
neu_pop.gNaP[Nnap:N] = 0
neu_pop.EL[Nnap:N]   = E_L*(1+var_EL*randn(N-Nnap))            # leak reversal potentials
neu_pop.gL   = g_L*(1+var_gL*randn(N))            # leak conductance
# neu_pop.gNaP = g_NaP*rand(N) 
# neu_pop.kNaP = k_NaP 
####################################################################################################################
# Connections
####################################################################################################################
#### electical synapses
Sgap = Synapses(neu_pop, neu_pop, '''
             w                                : siemens            # gap junction conductance
             Igap_post = w * (v_pre - v_post) : amp (summed)       # gap junction current
             ''')
Sgap.connect('i != j', p = pGap)                    # connecting neurons by electrical synapses with probability pGap                   
Sgap.w = gGap                                       # setting gap junction weights  
#### chemical synapses
Ssyn = Synapses(neu_pop, neu_pop, on_pre='v += wSyn', delay=dSyn)  # ampa synapse
Ssyn.connect(p=pSyn)                                # connecting neurons by chemical synapses with probability p               
####################################################################################################################
# Monitoring 
####################################################################################################################
M = StateMonitor(neu_pop, 'v', record=[2,3,1,22,52,43, 41])                       # membrane potentials of sample neurons
neuH = PopulationRateMonitor(neu_pop)                               # populational activity to build histogram
neuR = SpikeMonitor(neu_pop)                                        # spike moments to build raster plot                                       
####################################################################################################################
# Running simulation
####################################################################################################################
run(duration)

def calc_bursting_par(activity,scale):
    it_st = Nburst = 0
    b_start, b_end, per, b_len, ratio, ampl = [], [], [], [], [], []
    simT = len(activity)
    # trsh  = scale*max(activity)-min(activity)
    trsh  = 18
    for it in range(simT-1):
        if it+1 <= simT:
            if activity[it] <= trsh and activity[it+1] > trsh: 
                it_st = it_st+1
                b_start.append(it)
    if it_st > 0:
        for ib in range(it_st-1):
            per.append((b_start[ib+1]-b_start[ib])*t_scale)
            flag_burst = False
            for it in range(b_start[ib],b_start[ib+1]):
                if activity[it] > trsh and activity[it+1] <= trsh:
                    b_end.append(it)
                    Nburst = Nburst+1   
                    b_len.append((b_end[ib]-b_start[ib])*t_scale)                 
                    ratio.append(b_len[ib]/(per[ib]-b_len[ib]))
                    ampl.append(max(activity[b_start[ib]:b_end[ib]]))
                    flag_burst = True
                    if flag_burst:
                        break
    return (Nburst,per,b_len,ampl)
pop_activity = 100*neuH.smooth_rate(width=binH)[t0:]/(N*Hz)
bn= 100 #binH/ms
ave_pop_act = []
ib = 0
for i in range (0,len(pop_activity)-bn,bn):
    sum = 0
    ib=ib+1
    for j in range (0,bn-1):
        sum = sum+pop_activity[ib*bn+j]
    ave_pop_act.append(sum/bn)   
(Nburst,period,burstL,burstA) = calc_bursting_par(ave_pop_act,trsh_scale)
res=f'----\n'
f.write(res)
res= f'gGap = {gGap/nS:.3f}\n' 
f.write(res)
res= f'wSyn = {wSyn/mV:.2f}\n' 
f.write(res)
meanP = mean(period)
stdP  = std(period)
res = f'period = {meanP:.2f}\n'
f.write(res)
res = f'stdP = {stdP:.2f}\n'
f.write(res)
meanA = mean(burstA)
stdA = std(burstA)
res = f'amplitude = {meanA:.1f}\n'
f.write(res) 
res = f'stdA = {stdA:.1f}\n'
f.write(res) 
# print(period)
print("wSyn = ",wSyn/mV, end = '')
print("      gGap = ",gGap/nS)
print("amp  = %.2f" % meanA, end = '')
print("      stdA = %.2f" % stdA)
print("P    = %.2f" % meanP, end = '')
print("      stdP = %.2f" % stdP)
f.close
###################################################################################################################
# Plotting results
####################################################################################################################
figure(figsize=(6, 9))
# xlim=(t_start/second,duration/second)
xlim=(40,60)
# xlim=(20,40)
# populational activity 
ax=subplot(311)
title('Populational activity')
ylabel('Mean frequency, Hz')
xticks([])
plot(neuH.t/second, 100*neuH.smooth_rate(width = binH) /(N*Hz))
ax.set_xlim(xlim)
ax.set_ylim(0,60)
# raster plot
ax=subplot(312)
title('Populational raster')

yticks([])
scatter(neuR.t/second, neuR.i, s=1, lw=0, alpha=0.25)
ax.set_xlim(xlim)
# membrane potentials of sample neurons
ax=subplot(313)
title('Neuron activity')
ylabel('Voltage, mV')
xticks([])
for ip in [0,1,2,3,4,5,6]:
   plot(M.t/second, (M.v[ip]+(ip-1)*shiftV)/mV)
xlabel('sec')
ax.set_xlim(xlim)
#IPython.embed()
show()