clear 
close all

configfile = 'C:\Users\gomes\code\otm\otm-base\src\main\resources\test_configs\onramp_offramp_1.xml';
sim_dt = 2;
modelname = 'ctm';
lanewidth = 10;
start_time = 0;
duration = 500;
x = Scenario(configfile);
request_links = x.get_link_ids;
request_dt = 2;

otm = OTM(configfile,sim_dt,modelname);

otm.run_simple(start_time,duration,request_links,request_dt)

X = otm.get_state_trajectory;

figure
subplot(211)
plot(X.time,X.vehs,'LineWidth',2)
ylabel('vehicles'), grid
subplot(212)
plot(X.time(1:end-1),X.flows,'LineWidth',2)
ylabel('flow [vph]'), grid
legend(num2str(request_links'))
