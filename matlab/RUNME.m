clear
close all

configfile = 'C:\Users\gomes\code\otm\otm-base\src\main\resources\test_configs\diverges.xml';
sim_dt = 1;
modelname = 'ctm';
lanewidth = 3;
duration = 100;
time_period = [0 duration];

otm = OTM(configfile,sim_dt,modelname);
% otm.show_network(lanewidth)
% otm.animate(time_period)
otm.run_simple(0,duration)
% paths = otm.get_path_travel_times();
[time,X] = otm.get_state_trajectory(sim_dt);

