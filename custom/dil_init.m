% Ayelet Zalic March 2018
%%% Initialization script for He3 system
close all;
clear smdata;

global smdata; 
smdata=createsmdata;

chan  = 0;





%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% Initialize Keithley1
Keithley1Voltage =1; 



k1adr = 24;
k1ind = sminstlookup('Keithley 1');

%create Keithley 1 object
obj = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', k1adr, 'Tag', '');
if isempty(obj)
    obj = gpib('ni', 0, k1adr);
else
    fclose(obj);
    obj = obj(1);
end
smdata.inst(k1ind).data.inst = obj;

%open all instruments
try
fopen(smdata.inst(k1ind).data.inst);
chan = chan + 1;
smaddchannel('Keithley 1','dcv','K1dcv',[],chan);
chan = chan + 1;
smaddchannel('Keithley 1','dcc','K1dcc',[],chan);

catch
    display('Keithley 1 disconnected');
end


%% Keithley 2400 is intialized differently as voltage source or for
% current source
try

if Keithley1Voltage == 1
    %initialize the Keithley 2400 as a voltage source
    fprintf(smdata.inst(k1ind).data.inst,'*RST');
    fprintf(smdata.inst(k1ind).data.inst,':sour:func volt');
    fprintf(smdata.inst(k1ind).data.inst,':sour:volt:mode fix');
    fprintf(smdata.inst(k1ind).data.inst,':sour:volt:rang 50');
    %fprintf(smdata.inst(k1ind).data.inst,':sour:volt:rang 10');
    fprintf(smdata.inst(k1ind).data.inst,':sens:curr:prot 6E-3');
    fprintf(smdata.inst(k1ind).data.inst,':sens:curr:RANG 6e-3');
    fprintf(smdata.inst(k1ind).data.inst,':outp on');
else
    %initialize Keithley 2400 as a current source (for reading T or driving
    %magnet)
    fprintf(smdata.inst(k1ind).data.inst,'*RST');
    fprintf(smdata.inst(k1ind).data.inst,':sour:func curr');
    fprintf(smdata.inst(k1ind).data.inst,':sens:func "volt"');
    fprintf(smdata.inst(k1ind).data.inst,':outp on');
    fprintf(smdata.inst(k1ind).data.inst,':sour:curr 0.0'); % for T
    fprintf(smdata.inst(k1ind).data.inst,':sour:curr:RANG 1');
%     fprintf(smdata.inst(3).data.inst,':sour:curr 0e-8')   % for current biasing
%     fprintf(smdata.inst(k1ind).data.inst,':sour:curr:RANG 1e-8');
    fprintf(smdata.inst(k1ind).data.inst,':sens:volt:RANG 20')
end

catch
      display('Keithley1 disconnected');   
end



%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% Initialize Keithley2
Keithley2Voltage = 1; 


k2adr = 25;
k2ind = sminstlookup('Keithley 2');

%create Keithley 2 object
obj = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', k2adr, 'Tag', '');
if isempty(obj)
    obj = gpib('ni', 0, k2adr);
else
    fclose(obj);
    obj = obj(1);
end
smdata.inst(k2ind).data.inst = obj;

%open all instruments
try
fopen(smdata.inst(k2ind).data.inst);
chan = chan + 1;
smaddchannel('Keithley 2','dcv','K2dcv',[],chan);
chan = chan + 1;
smaddchannel('Keithley 2','dcc','K2dcc',[],chan);

catch
    display('Keithley 2 disconnected');
end


%% Keithley 2400 is intialized differently as voltage source or for
% current source
try

if Keithley2Voltage == 1
    %initialize the Keithley 2400 as a voltage source
    fprintf(smdata.inst(k2ind).data.inst,'*RST');
    fprintf(smdata.inst(k2ind).data.inst,':sour:func volt');
    fprintf(smdata.inst(k2ind).data.inst,':sour:volt:mode fix');
    fprintf(smdata.inst(k2ind).data.inst,':sour:volt:rang 20');
    %fprintf(smdata.inst(k2ind).data.inst,':sour:volt:rang 10');
    fprintf(smdata.inst(k2ind).data.inst,':sens:curr:prot 10E-6');
    fprintf(smdata.inst(k2ind).data.inst,':sens:curr:RANG 10e-6');
    fprintf(smdata.inst(k2ind).data.inst,':outp on');
else
    %initialize Keithley 2400 as a current source (for reading T or driving
    %magnet)
    fprintf(smdata.inst(k2ind).data.inst,'*RST');
    fprintf(smdata.inst(k2ind).data.inst,':sour:func curr');
    fprintf(smdata.inst(k2ind).data.inst,':sens:func "volt"');
    fprintf(smdata.inst(k2ind).data.inst,':outp on');
    fprintf(smdata.inst(k2ind).data.inst,':sour:curr 1e-5'); % for T
%     fprintf(smdata.inst(3).data.inst,':sour:curr 0e-8')   % for current biasing
%     fprintf(smdata.inst(k1ind).data.inst,':sour:curr:RANG 1e-8');
%     fprintf(smdata.inst(k1ind).data.inst,':sens:volt:RANG 200e-2')
end

catch
      display('Keithley2 disconnected');   
end

%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%


% Initialize Keithley3
Keithley3Voltage = 0; 

k3adr = 27;
k3ind = sminstlookup('Keithley 3');

%create Keithley 2 object
obj = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', k3adr, 'Tag', '');
if isempty(obj)
    obj = gpib('ni', 0, k3adr);
else
    fclose(obj);
    obj = obj(1);
end
smdata.inst(k3ind).data.inst = obj;

%open all instruments
try
fopen(smdata.inst(k3ind).data.inst);

chan = chan + 1;
smaddchannel('Keithley 3','dcv','K3dcv',[],chan);
chan = chan + 1;
smaddchannel('Keithley 3','dcc','K3dcc',[],chan);

catch
    display('Keithley 3 disconnected');
end


%% Keithley 2400 is intialized differently as voltage source or for
% current source
try

if Keithley3Voltage == 1
    %initialize the Keithley 2400 as a voltage source
    fprintf(smdata.inst(k3ind).data.inst,'*RST');
    fprintf(smdata.inst(k3ind).data.inst,':sour:func volt');
    fprintf(smdata.inst(k3ind).data.inst,':sour:volt:mode fix');
    fprintf(smdata.inst(k3ind).data.inst,':sour:volt:rang 210');
    %fprintf(smdata.inst(k2ind).data.inst,':sour:volt:rang 10');
    fprintf(smdata.inst(k3ind).data.inst,':sens:curr:prot 105E-6');
    fprintf(smdata.inst(k3ind).data.inst,':sens:curr:RANG 105e-6');
    fprintf(smdata.inst(k3ind).data.inst,':outp on');
else
    %initialize Keithley 2400 as a current source (for reading T or driving
    %magnet)
    fprintf(smdata.inst(k3ind).data.inst,'*RST');
    fprintf(smdata.inst(k3ind).data.inst,':sour:func curr');
    fprintf(smdata.inst(k3ind).data.inst,':sens:func "volt"');
    fprintf(smdata.inst(k3ind).data.inst,':outp on');
    fprintf(smdata.inst(k3ind).data.inst,':sour:curr 2e-3'); % for T
%     fprintf(smdata.inst(3).data.inst,':sour:curr 0e-8')   % for current biasing
%     fprintf(smdata.inst(k1ind).data.inst,':sour:curr:RANG 1e-8');
%     fprintf(smdata.inst(k1ind).data.inst,':sens:volt:RANG 200e-2')
end

catch
      display('Keithley3 disconnected');   
end

%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% Initialize dmm1

dmm1adr = 26;
dmm1ind = sminstlookup('Dmm 1');

%create dmm1 object
obj = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', dmm1adr, 'Tag', '');
if isempty(obj)
    obj = gpib('ni', 0, dmm1adr);
else
    fclose(obj);
    obj = obj(1);
end
smdata.inst(dmm1ind).data.inst = obj;

%open all instruments

try
fopen(smdata.inst(dmm1ind).data.inst);
chan = chan + 1;
smaddchannel('Dmm 1','dcv','dmm1dcv',[],chan);


catch
      display('Dmm 1 disconnected');
end

%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%


% Initialize dmm12

%create dmm1 object
dmm2adr = 27;
dmm2ind = sminstlookup('Dmm 2');
obj = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', dmm2adr, 'Tag', '');
if isempty(obj)
    obj = gpib('ni', 0, dmm2adr);
else
    fclose(obj);
    obj = obj(1);
end
smdata.inst(dmm2ind).data.inst = obj;

%open all instruments

try
fopen(smdata.inst(dmm2ind).data.inst);



chan = chan + 1;
smaddchannel('Dmm 2','dcv','dmm2dcv',[],chan);


catch
      display('Dmm 2 disconnected');
end

%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% Initialize dmm3


dmm3adr = 17;
dmm3ind = sminstlookup('Dmm 3');

%create dmm1 object
obj = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', dmm3adr, 'Tag', '');
if isempty(obj)
    obj = gpib('ni', 0, dmm3adr);
else
    fclose(obj);
    obj = obj(1);
end
smdata.inst(dmm3ind).data.inst = obj;

%open all instruments

try
fopen(smdata.inst(dmm3ind).data.inst);
chan = chan + 1;
smaddchannel('Dmm 3','dcv','dmm3dcv',[],chan);

catch
      display('Dmm 3 disconnected');
end



%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% Initialize lockin1


l1adr = 8;
l1ind = sminstlookup('Lockin 1');


%create lockin 1 object
obj = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', l1adr, 'Tag', '');
if isempty(obj)
    obj = gpib('ni', 0, l1adr);
else
    fclose(obj);
    obj = obj(1);
end
smdata.inst(l1ind).data.inst = obj;


%open all instruments

try
fopen(smdata.inst(l1ind).data.inst);

chan = chan + 1;
smaddchannel('Lockin 1','X','L1X',[],chan);
chan = chan + 1;
smaddchannel('Lockin 1','R','L1R',[],chan);
chan = chan + 1;
smaddchannel('Lockin 1','IN1','L1IN1',[],chan);

catch
      display('Lockin 1 disconnected');
end



%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%


% Initialize lockin2

l2adr = 9;
l2ind = sminstlookup('Lockin 2');


%create lockin 1 object
obj = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', l2adr, 'Tag', '');
if isempty(obj)
    obj = gpib('ni', 0, l2adr);
else
    fclose(obj);
    obj = obj(1);
end
smdata.inst(l2ind).data.inst = obj;


%open all instruments

try
fopen(smdata.inst(l2ind).data.inst);

chan = chan + 1;
smaddchannel('Lockin 2','X','L2X',[],chan);
chan = chan + 1;
smaddchannel('Lockin 2','R','L2R',[],chan);
chan = chan + 1;
smaddchannel('Lockin 2','IN1','L2IN1',[],chan);


catch
      display('Lockin 2 disconnected');
end



%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%


% Initialize DAC2

DAC2adr = 'COM9'; %COM port for the DAC 
DAC2ind = sminstlookup('DAC 2');


%create DAC 2 object
smdata.inst(DAC2ind).data.inst = serial(DAC2adr,'BaudRate',115200);



try
fopen(smdata.inst(DAC2ind).data.inst);

chan = chan + 1;
smaddchannel('DAC 2','out0','DAC0',[],chan);
chan = chan + 1;
smaddchannel('DAC 2','out1','DAC2',[],chan);
chan = chan + 1;
smaddchannel('DAC 2','out2','DAC2',[],chan);
chan = chan + 1;
smaddchannel('DAC 2','out3','DAC3',[],chan);


catch
      display('DAC 2 disconnected');
end




%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
% Create AMI_Z


ip='192.168.1.4';
port=7180;

AMI_Z_ind = sminstlookup('AMI_Z');


obj = instrfind('Type', 'tcpip', 'RemoteHost', ip, 'RemotePort', port, 'Tag', '');
if isempty(obj)
    obj = tcpip(ip,port);
else
    fclose(obj);
    obj= obj(1);
end

smdata.inst(AMI_Z_ind).data.inst = obj;

try
fopen(obj);
chan = chan + 1;
smaddchannel('AMI_Z','field','field_Z',[],chan);

catch
      display('AMI_Z disconnected');
end
scanstr(obj);
scanstr(obj);

%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%


% Create AMI_Y

ip='192.168.1.3';
port=7180;

AMI_Y_ind = sminstlookup('AMI_Y');


obj = instrfind('Type', 'tcpip', 'RemoteHost', ip, 'RemotePort', port, 'Tag', '');
if isempty(obj)
    obj = tcpip(ip,port);
else
    fclose(obj);
    obj= obj(1);
end

smdata.inst(AMI_Y_ind).data.inst = obj;

try
fopen(obj);
chan = chan + 1;
smaddchannel('AMI_Y','field','field_Y',[],chan);


catch
      display('AMI_Y disconnected');
end
scanstr(obj);
scanstr(obj);


%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% Initialize Zurich

chan = chan + 1;
smaddchannel('MFLI','X','ZX',[],chan);
chan = chan + 1;
smaddchannel('MFLI','R','ZR',[],chan);
chan = chan + 1;
smaddchannel('MFLI','IN1','ZiN1',[],chan);
chan = chan + 1;
smaddchannel('MFLI','IN2','ZiN2',[],chan);
chan = chan + 1;
smaddchannel('MFLI','OUT1','Zout1',[],chan);
chan = chan + 1;
smaddchannel('MFLI','OUT2','Zout2',[],chan);
chan = chan + 1;
smaddchannel('MFLI','OUT3','Zout3',[],chan);
chan = chan + 1;
smaddchannel('MFLI','OUT4','Zout4',[],chan);
chan = chan + 1;
smaddchannel('MFLI','OFFSET','Zoffset',[],chan);


%createZurich object
clear ziDAQ;
ziCreateAPISession('mf-dev3408',6);
ziDAQ('unsubscribe', '*');
ziDAQ('sync');
ziDAQ('subscribe', ['/' 'dev3408' '/demods/' '0' '/sample']);

%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% Initialize cryomagnetics

magind=sminstlookup('Cryo4G');


% %create Cryo4G magnet object
% obj = instrfind('Type', 'tcpip', 'RemoteHost', ip, 'RemotePort', port, 'Tag', '');
% if isempty(obj)
%     obj = tcpip(ip,port);
% else
%     fclose(obj);
%     obj= obj(1);
% end
% smdata.inst(magind).data.inst=obj;
% 
% 
% try
% fopen(smdata.inst(magind).data.inst);
% fprintf(smdata.inst(magind).data.inst,'REMOTE');
% chan = chan + 1;
% smaddchannel('Cryo4G','field','field',[-14,14,1,1],chan);
% chan = chan + 1;
% smaddchannel('Cryo4G','pfield','pfield',[-14,14,1,1],chan);
% chan = chan + 1;
% smaddchannel('Cryo4G','remote','remote',[],chan);
% chan = chan + 1;
% smaddchannel('Cryo4G','pshtr','pshtr',[],chan);
% 
% 
% catch
%       display('Magnet disconnected');
% end



%put magnet in remote mode




%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

lakes336ind=sminstlookup('lakes336');
lakes336adr = 12;
%create lakeshore 336 object
obj = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', lakes336adr, 'Tag', '');
if isempty(obj)
    obj = gpib('ni', 0, lakes336adr);
else
    fclose(obj);
    obj = obj(1);
end
smdata.inst(lakes336ind).data.inst = obj;


try
fopen(smdata.inst(lakes336ind).data.inst);
chan = chan + 1;
smaddchannel('lakes336','setp1','setp1',[0,18,1,1],chan);
chan = chan + 1;
smaddchannel('lakes336','setp2','setp2',[0,18,1,1],chan);
chan = chan + 1;
smaddchannel('lakes336','range1','range1',[],chan);
chan = chan + 1;
smaddchannel('lakes336','range2','range2',[],chan);
chan = chan + 1;
smaddchannel('lakes336','T_1Kpot','T_1Kpot',[0,18,1,1],chan);
chan = chan + 1;
smaddchannel('lakes336','T_he3','T_he3',[0,18,1,1],chan);
chan = chan + 1;
smaddchannel('lakes336','T_sorb','T_sorb',[0,18,1,1],chan);
chan = chan + 1;
smaddchannel('lakes336','T_sample','T_sample',[0,18,1,1],chan);
chan = chan + 1;
smaddchannel('lakes336','R_1Kpot','R_1Kpot',[0,18,1,1],chan);
chan = chan + 1;
smaddchannel('lakes336','R_he3','R_he3',[0,18,1,1],chan);
chan = chan + 1;
smaddchannel('lakes336','R_sorb','R_sorb',[0,18,1,1],chan);
chan = chan + 1;
smaddchannel('lakes336','R_sample','R_sample',[0,18,1,1],chan);

catch
      display('Lakeshore disconnected');
end


%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% Initialize DAC2




%% Serial addresses for serial machines
dacadr = 'COM5'; %COM port for the DAC 
dacind = sminstlookup('DAC 2');

%create DAC 2 object
smdata.inst(dacind).data.inst = serial(dacadr,'BaudRate',115200);

try
fopen(smdata.inst(dacind).data.inst);
chan = chan + 1;
smaddchannel('DAC 2','out0','DAC2_0',[],chan);
chan = chan + 1;
smaddchannel('DAC 2','out1','DAC2_1',[],chan);
chan = chan + 1;
smaddchannel('DAC 2','out2','DAC2_2',[],chan);
chan = chan + 1;
smaddchannel('DAC 2','out3','DAC2_3',[],chan);
catch
      display('DAC 2 disconnected');
end

%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
