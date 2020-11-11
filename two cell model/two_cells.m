tic;
clear all;
global Eleak gNaP gGap wSyn
% uncomment the corresponding line to generate particular figure
% Figure1A_par;
% Figure1B_par;
% Figure2_par;
% Figure3A_par;
% Figure3B_par;
Figure3C_par;
figure('Name',f_name,'NumberTitle','off');
neuron_par;
nplot = 0; 
time = 0:0.1:time_max;
for il = 1:Nlines
    Eleak = [EL1(il); EL2(il)];
    for ip = 1:Npar    
        nplot = nplot+1;    
        Tmin = T0(ip,il);
        Tmax = Tmin+Tlength;
        switch par_name
            case 'gGap'
                gGap = par(ip);
                wSyn = 0;
                gNaP = g_NaP;
            case 'wSyn' 
                gGap = 0;
                wSyn = par(ip);
                gNaP = g_NaP;
            case 'gNaP' 
                gGap = 0.1;
                wSyn = 0;           
                gNaP = [par(ip); 0];
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% initial conditions
        %      V        hNaF      hNaP       nK        sAMPA
        x0=[-74 -70   0.3 0.3   0.3  0.3   0.03 0.03   0   0 ];                         
        [t,x] = ode15s('DF',time,x0);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for i = 1:2
            subplot(3,Npar,nplot); 
            plot(time/1000,x(:,i)-100*(i-1),'Color',col(i),'LineWidth',1.);
            hold on;
            set(gca,'TickDir','out');
            set(gca,'TickLength',[0.02 1]);
            yline(-60-100*(i-1),':k','LineWidth',1. );            
            hold on;
            if il == 1
                title(strcat(par_name,'=',num2str(par(ip)),' nS'),'FontSize',[12]);
            else
                title(' ');
            end
            if il == Nlines
                xlabel('Time, s', 'FontSize',[10],'FontWeight','Bold');
%                 xticklabels({'0','2 ','4','6','8','10 '})
                xticklabels(Tlb)
            else
                xlabel(' ');
                xticklabels({' '})
            end
            if ip == 1
                ylabel('Voltage, mV', 'FontSize',[10],'FontWeight','Bold');
                yticklabels({'-80','-40','0','-80','-40','0'})
            else
                ylabel(' ');
                yticklabels({' '})
            end
%             xticks([Tmin Tmin+2 Tmin+4  Tmin+6 Tmin+8 Tmin+10 ])
            xticks(T0(ip,il)+Tticks)
            yticks([-180 -140 -100 -80 -40 -0 ])
            axis([Tmin Tmax -180 0]);    
        end
    end
end
toc;