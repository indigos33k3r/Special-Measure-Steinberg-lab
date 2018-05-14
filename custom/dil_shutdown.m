% Ayelet Zalic March 2018
%%% Shutdown script for He3 system


global smdata; 


%% Retrieve instrument indices and close connections to machines

k1ind = sminstlookup('Keithley 1');
k2ind = sminstlookup('Keithley 2');
dmm1ind = sminstlookup('Dmm 1');
dmm2ind = sminstlookup('Dmm 2');
dmm3ind = sminstlookup('Dmm 3');
l1ind = sminstlookup('Lockin 1');
l2ind = sminstlookup('Lockin 2');
dac1ind = sminstlookup('DAC 1');

%set voltages to zero
try
smset('K1dcv',0);
end
try
smset('K2dcv',0);
end
try
smset('L2X',0);
end
try
fprintf(smdata.inst(k1ind).data.inst,':outp off');
end
try
fprintf(smdata.inst(k2ind).data.inst,':outp off');
end
instrreset;

