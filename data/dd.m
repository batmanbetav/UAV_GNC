% -------------------------------------------------------------------
%  Generated by MATLAB on 20-Jun-2017 14:44:18
%  MATLAB version: 9.2.0.538062 (R2017a)
%  Copyright 2018 The MathWorks, Inc.
% -------------------------------------------------------------------
                             
%% Networking configuration

% IP address of ethernet interface on the desktop computer used for UDP communication with the Raspi
hostIP = '10.10.10.10';

% Get IP address of default raspberry pi if target support package is installed
if exist('codertarget.raspi','file')
    raspiIP = codertarget.raspi.getDeviceAddress;
else
    raspiIP = '255.255.255.255';
end

% Get IP address of default SLRT target if slrealtime is installed
if exist('slrealtime','file')
    % IP address of adapter on the Speedgoat target used for UDP communication with the Raspi
    tg = slrealtime;
    sgIP = tg.TargetSettings.address;
else
    sgIP = '';
end

% Default IP address value
if isempty(sgIP)
    sgIP = '10.10.10.102';
end

%% Parameters and variants
GPSTimeSeed = fix(clock);

Xpoints = [375 375 100 100 550 550 375 375 375];

Ypoints = [850 275 275 0 0 850 850 850 850];

Zpoints = [230 250 220 230 230 210 220 230 230];

MIL = Simulink.Variant('simMode == 0');
SIL = Simulink.Variant('simMode == 1');
PIL = Simulink.Variant('simMode == 2');

simMode = 0;

useQGCvar = Simulink.Variant('useQGC');
useSLvar = Simulink.Variant('~useQGC');

useQGC = false();

useSLguidance = Simulink.Variant('~useGuidanceSF');
useSFguidance = Simulink.Variant('useGuidanceSF');

useGuidanceSF = false();

animNone = Simulink.Variant('animMode == 0');
animSimPace = Simulink.Variant('animMode == 1');
animFlightGear = Simulink.Variant('animMode == 2');

animMode = 0;

ap = struct;
ap.apSampleTime = 0.01;
ap.baro = struct;
ap.baro.lapseRate = -0.00198122;
ap.cf = struct;
ap.cf.zCutoff = 0.2;
ap.cf.xCutoff = 4;
ap.cf.yCutoff = 4;
ap.cf.baroCutoff = 0.060478878374920234;
ap.cf.accBiasRateLimit = 9.89E-7;
ap.cf.vzCutoff = 2;
ap.guidance = struct;
ap.guidance.maxEta = 0.71451813;
ap.guidance.maxAcc = 4.5729;
ap.guidance.maxDwnPthStar = 1;
ap.guidance.tanIntercept = 0.5774;
ap.guidance.IPStar = 0.6;
ap.guidance.tstar = 3.5;
ap.guidance.turnLeadTime = 5.5;
ap.control = struct;
ap.control.derivativesConstant = 5;
ap.control.dtLimit = 0.95;
ap.control.deLimit = 0.401425719;
ap.control.the_cLimit = 0.261799395;
ap.control.daLimit = 30*pi/180;
ap.control.drLimit = 0.17453292;
ap.control.phi_cLimit = 35*pi/180;

%% Bus definitions
apConfigParamsBus = Simulink.Bus;
apConfigParamsBus.Description = ['This bus holds all the configuration ' ...
                                 'parameters for the autopilot '];
apConfigParamsBus.DataScope = 'Imported';
apConfigParamsBus.HeaderFile = 'interfaceDefinition.h';
apConfigParamsBus.Alignment = -1;
saveVarsTmp{1} = Simulink.BusElement;
saveVarsTmp{1}.Name = 'T_star';
saveVarsTmp{1}.Complexity = 'real';
saveVarsTmp{1}.Dimensions = 1;
saveVarsTmp{1}.DataType = 'double';
saveVarsTmp{1}.Min = [];
saveVarsTmp{1}.Max = [];
saveVarsTmp{1}.DimensionsMode = 'Fixed';
saveVarsTmp{1}.SamplingMode = 'Sample based';
saveVarsTmp{1}.SampleTime = -1;
saveVarsTmp{1}.DocUnits = '';
saveVarsTmp{1}.Description = '';
saveVarsTmp{1}(2, 1) = Simulink.BusElement;
saveVarsTmp{1}(2, 1).Name = 'turnLead';
saveVarsTmp{1}(2, 1).Complexity = 'real';
saveVarsTmp{1}(2, 1).Dimensions = 1;
saveVarsTmp{1}(2, 1).DataType = 'double';
saveVarsTmp{1}(2, 1).Min = [];
saveVarsTmp{1}(2, 1).Max = [];
saveVarsTmp{1}(2, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(2, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(2, 1).SampleTime = -1;
saveVarsTmp{1}(2, 1).DocUnits = 'sec';
saveVarsTmp{1}(2, 1).Description = '';
saveVarsTmp{1}(3, 1) = Simulink.BusElement;
saveVarsTmp{1}(3, 1).Name = 'airspeedHoldPID';
saveVarsTmp{1}(3, 1).Complexity = 'real';
saveVarsTmp{1}(3, 1).Dimensions = 3;
saveVarsTmp{1}(3, 1).DataType = 'double';
saveVarsTmp{1}(3, 1).Min = [];
saveVarsTmp{1}(3, 1).Max = [];
saveVarsTmp{1}(3, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(3, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(3, 1).SampleTime = -1;
saveVarsTmp{1}(3, 1).DocUnits = '';
saveVarsTmp{1}(3, 1).Description = '';
saveVarsTmp{1}(4, 1) = Simulink.BusElement;
saveVarsTmp{1}(4, 1).Name = 'dEFeedForward';
saveVarsTmp{1}(4, 1).Complexity = 'real';
saveVarsTmp{1}(4, 1).Dimensions = 1;
saveVarsTmp{1}(4, 1).DataType = 'double';
saveVarsTmp{1}(4, 1).Min = [];
saveVarsTmp{1}(4, 1).Max = [];
saveVarsTmp{1}(4, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(4, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(4, 1).SampleTime = -1;
saveVarsTmp{1}(4, 1).DocUnits = '';
saveVarsTmp{1}(4, 1).Description = '';
saveVarsTmp{1}(5, 1) = Simulink.BusElement;
saveVarsTmp{1}(5, 1).Name = 'he2ThPID';
saveVarsTmp{1}(5, 1).Complexity = 'real';
saveVarsTmp{1}(5, 1).Dimensions = 3;
saveVarsTmp{1}(5, 1).DataType = 'double';
saveVarsTmp{1}(5, 1).Min = [];
saveVarsTmp{1}(5, 1).Max = [];
saveVarsTmp{1}(5, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(5, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(5, 1).SampleTime = -1;
saveVarsTmp{1}(5, 1).DocUnits = '';
saveVarsTmp{1}(5, 1).Description = '';
saveVarsTmp{1}(6, 1) = Simulink.BusElement;
saveVarsTmp{1}(6, 1).Name = 'th2dTPID';
saveVarsTmp{1}(6, 1).Complexity = 'real';
saveVarsTmp{1}(6, 1).Dimensions = 3;
saveVarsTmp{1}(6, 1).DataType = 'double';
saveVarsTmp{1}(6, 1).Min = [];
saveVarsTmp{1}(6, 1).Max = [];
saveVarsTmp{1}(6, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(6, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(6, 1).SampleTime = -1;
saveVarsTmp{1}(6, 1).DocUnits = '';
saveVarsTmp{1}(6, 1).Description = '';
saveVarsTmp{1}(7, 1) = Simulink.BusElement;
saveVarsTmp{1}(7, 1).Name = 'dTFeedForward';
saveVarsTmp{1}(7, 1).Complexity = 'real';
saveVarsTmp{1}(7, 1).Dimensions = 1;
saveVarsTmp{1}(7, 1).DataType = 'double';
saveVarsTmp{1}(7, 1).Min = [];
saveVarsTmp{1}(7, 1).Max = [];
saveVarsTmp{1}(7, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(7, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(7, 1).SampleTime = -1;
saveVarsTmp{1}(7, 1).DocUnits = '';
saveVarsTmp{1}(7, 1).Description = '';
saveVarsTmp{1}(8, 1) = Simulink.BusElement;
saveVarsTmp{1}(8, 1).Name = 'rollControlPID';
saveVarsTmp{1}(8, 1).Complexity = 'real';
saveVarsTmp{1}(8, 1).Dimensions = 3;
saveVarsTmp{1}(8, 1).DataType = 'double';
saveVarsTmp{1}(8, 1).Min = [];
saveVarsTmp{1}(8, 1).Max = [];
saveVarsTmp{1}(8, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(8, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(8, 1).SampleTime = -1;
saveVarsTmp{1}(8, 1).DocUnits = '';
saveVarsTmp{1}(8, 1).Description = '';
saveVarsTmp{1}(9, 1) = Simulink.BusElement;
saveVarsTmp{1}(9, 1).Name = 'yawDamperPID';
saveVarsTmp{1}(9, 1).Complexity = 'real';
saveVarsTmp{1}(9, 1).Dimensions = 3;
saveVarsTmp{1}(9, 1).DataType = 'double';
saveVarsTmp{1}(9, 1).Min = [];
saveVarsTmp{1}(9, 1).Max = [];
saveVarsTmp{1}(9, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(9, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(9, 1).SampleTime = -1;
saveVarsTmp{1}(9, 1).DocUnits = '';
saveVarsTmp{1}(9, 1).Description = '';
apConfigParamsBus.Elements = saveVarsTmp{1};
clear saveVarsTmp;

apStatusBus = Simulink.Bus;
apStatusBus.Description = '';
apStatusBus.DataScope = 'Imported';
apStatusBus.HeaderFile = 'interfaceDefinition.h';
apStatusBus.Alignment = -1;
saveVarsTmp{1} = Simulink.BusElement;
saveVarsTmp{1}.Name = 'Ab';
saveVarsTmp{1}.Complexity = 'real';
saveVarsTmp{1}.Dimensions = 3;
saveVarsTmp{1}.DataType = 'double';
saveVarsTmp{1}.Min = [];
saveVarsTmp{1}.Max = [];
saveVarsTmp{1}.DimensionsMode = 'Fixed';
saveVarsTmp{1}.SamplingMode = 'Sample based';
saveVarsTmp{1}.SampleTime = -1;
saveVarsTmp{1}.DocUnits = 'm/s^2';
saveVarsTmp{1}.Description = '';
saveVarsTmp{1}(2, 1) = Simulink.BusElement;
saveVarsTmp{1}(2, 1).Name = 'G';
saveVarsTmp{1}(2, 1).Complexity = 'real';
saveVarsTmp{1}(2, 1).Dimensions = 3;
saveVarsTmp{1}(2, 1).DataType = 'double';
saveVarsTmp{1}(2, 1).Min = [];
saveVarsTmp{1}(2, 1).Max = [];
saveVarsTmp{1}(2, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(2, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(2, 1).SampleTime = -1;
saveVarsTmp{1}(2, 1).DocUnits = 'rad/s';
saveVarsTmp{1}(2, 1).Description = '';
saveVarsTmp{1}(3, 1) = Simulink.BusElement;
saveVarsTmp{1}(3, 1).Name = 'Euler';
saveVarsTmp{1}(3, 1).Complexity = 'real';
saveVarsTmp{1}(3, 1).Dimensions = 3;
saveVarsTmp{1}(3, 1).DataType = 'double';
saveVarsTmp{1}(3, 1).Min = [];
saveVarsTmp{1}(3, 1).Max = [];
saveVarsTmp{1}(3, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(3, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(3, 1).SampleTime = -1;
saveVarsTmp{1}(3, 1).DocUnits = 'rad';
saveVarsTmp{1}(3, 1).Description = '';
saveVarsTmp{1}(4, 1) = Simulink.BusElement;
saveVarsTmp{1}(4, 1).Name = 'ias';
saveVarsTmp{1}(4, 1).Complexity = 'real';
saveVarsTmp{1}(4, 1).Dimensions = 1;
saveVarsTmp{1}(4, 1).DataType = 'double';
saveVarsTmp{1}(4, 1).Min = [];
saveVarsTmp{1}(4, 1).Max = [];
saveVarsTmp{1}(4, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(4, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(4, 1).SampleTime = -1;
saveVarsTmp{1}(4, 1).DocUnits = 'm/s';
saveVarsTmp{1}(4, 1).Description = '';
saveVarsTmp{1}(5, 1) = Simulink.BusElement;
saveVarsTmp{1}(5, 1).Name = 'baro';
saveVarsTmp{1}(5, 1).Complexity = 'real';
saveVarsTmp{1}(5, 1).Dimensions = 1;
saveVarsTmp{1}(5, 1).DataType = 'double';
saveVarsTmp{1}(5, 1).Min = [];
saveVarsTmp{1}(5, 1).Max = [];
saveVarsTmp{1}(5, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(5, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(5, 1).SampleTime = -1;
saveVarsTmp{1}(5, 1).DocUnits = 'Pa';
saveVarsTmp{1}(5, 1).Description = '';
saveVarsTmp{1}(6, 1) = Simulink.BusElement;
saveVarsTmp{1}(6, 1).Name = 'Xe';
saveVarsTmp{1}(6, 1).Complexity = 'real';
saveVarsTmp{1}(6, 1).Dimensions = 3;
saveVarsTmp{1}(6, 1).DataType = 'double';
saveVarsTmp{1}(6, 1).Min = [];
saveVarsTmp{1}(6, 1).Max = [];
saveVarsTmp{1}(6, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(6, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(6, 1).SampleTime = -1;
saveVarsTmp{1}(6, 1).DocUnits = 'm';
saveVarsTmp{1}(6, 1).Description = '';
saveVarsTmp{1}(7, 1) = Simulink.BusElement;
saveVarsTmp{1}(7, 1).Name = 'Ve';
saveVarsTmp{1}(7, 1).Complexity = 'real';
saveVarsTmp{1}(7, 1).Dimensions = 3;
saveVarsTmp{1}(7, 1).DataType = 'double';
saveVarsTmp{1}(7, 1).Min = [];
saveVarsTmp{1}(7, 1).Max = [];
saveVarsTmp{1}(7, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(7, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(7, 1).SampleTime = -1;
saveVarsTmp{1}(7, 1).DocUnits = 'm/s';
saveVarsTmp{1}(7, 1).Description = '';
saveVarsTmp{1}(8, 1) = Simulink.BusElement;
saveVarsTmp{1}(8, 1).Name = 'GPS';
saveVarsTmp{1}(8, 1).Complexity = 'real';
saveVarsTmp{1}(8, 1).Dimensions = 1;
saveVarsTmp{1}(8, 1).DataType = 'Bus: gpsReading';
saveVarsTmp{1}(8, 1).Min = [];
saveVarsTmp{1}(8, 1).Max = [];
saveVarsTmp{1}(8, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(8, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(8, 1).SampleTime = -1;
saveVarsTmp{1}(8, 1).DocUnits = '';
saveVarsTmp{1}(8, 1).Description = '';
saveVarsTmp{1}(9, 1) = Simulink.BusElement;
saveVarsTmp{1}(9, 1).Name = 'guidanceMode';
saveVarsTmp{1}(9, 1).Complexity = 'real';
saveVarsTmp{1}(9, 1).Dimensions = 1;
saveVarsTmp{1}(9, 1).DataType = 'uint8';
saveVarsTmp{1}(9, 1).Min = [];
saveVarsTmp{1}(9, 1).Max = [];
saveVarsTmp{1}(9, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(9, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(9, 1).SampleTime = -1;
saveVarsTmp{1}(9, 1).DocUnits = '';
saveVarsTmp{1}(9, 1).Description = '';
saveVarsTmp{1}(10, 1) = Simulink.BusElement;
saveVarsTmp{1}(10, 1).Name = 'currentWp';
saveVarsTmp{1}(10, 1).Complexity = 'real';
saveVarsTmp{1}(10, 1).Dimensions = 1;
saveVarsTmp{1}(10, 1).DataType = 'uint8';
saveVarsTmp{1}(10, 1).Min = [];
saveVarsTmp{1}(10, 1).Max = [];
saveVarsTmp{1}(10, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(10, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(10, 1).SampleTime = -1;
saveVarsTmp{1}(10, 1).DocUnits = '';
saveVarsTmp{1}(10, 1).Description = '';
apStatusBus.Elements = saveVarsTmp{1};
clear saveVarsTmp;

atmosphericDataBus = Simulink.Bus;
atmosphericDataBus.Description = ['This bus hold the data for the 1976 ' ...
                                  'COESA lower atmosphere model for sim' ...
                                  ''];
atmosphericDataBus.DataScope = 'Auto';
atmosphericDataBus.HeaderFile = '';
atmosphericDataBus.Alignment = -1;
saveVarsTmp{1} = Simulink.BusElement;
saveVarsTmp{1}.Name = 'temperature';
saveVarsTmp{1}.Complexity = 'real';
saveVarsTmp{1}.Dimensions = 1;
saveVarsTmp{1}.DataType = 'double';
saveVarsTmp{1}.Min = [];
saveVarsTmp{1}.Max = [];
saveVarsTmp{1}.DimensionsMode = 'Fixed';
saveVarsTmp{1}.SamplingMode = 'Sample based';
saveVarsTmp{1}.SampleTime = -1;
saveVarsTmp{1}.DocUnits = 'K';
saveVarsTmp{1}.Description = '';
saveVarsTmp{1}(2, 1) = Simulink.BusElement;
saveVarsTmp{1}(2, 1).Name = 'soundSpeed';
saveVarsTmp{1}(2, 1).Complexity = 'real';
saveVarsTmp{1}(2, 1).Dimensions = 1;
saveVarsTmp{1}(2, 1).DataType = 'double';
saveVarsTmp{1}(2, 1).Min = [];
saveVarsTmp{1}(2, 1).Max = [];
saveVarsTmp{1}(2, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(2, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(2, 1).SampleTime = -1;
saveVarsTmp{1}(2, 1).DocUnits = 'm/s';
saveVarsTmp{1}(2, 1).Description = '';
saveVarsTmp{1}(3, 1) = Simulink.BusElement;
saveVarsTmp{1}(3, 1).Name = 'airPressure';
saveVarsTmp{1}(3, 1).Complexity = 'real';
saveVarsTmp{1}(3, 1).Dimensions = 1;
saveVarsTmp{1}(3, 1).DataType = 'double';
saveVarsTmp{1}(3, 1).Min = [];
saveVarsTmp{1}(3, 1).Max = [];
saveVarsTmp{1}(3, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(3, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(3, 1).SampleTime = -1;
saveVarsTmp{1}(3, 1).DocUnits = 'Pa';
saveVarsTmp{1}(3, 1).Description = '';
saveVarsTmp{1}(4, 1) = Simulink.BusElement;
saveVarsTmp{1}(4, 1).Name = 'rho';
saveVarsTmp{1}(4, 1).Complexity = 'real';
saveVarsTmp{1}(4, 1).Dimensions = 1;
saveVarsTmp{1}(4, 1).DataType = 'double';
saveVarsTmp{1}(4, 1).Min = [];
saveVarsTmp{1}(4, 1).Max = [];
saveVarsTmp{1}(4, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(4, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(4, 1).SampleTime = -1;
saveVarsTmp{1}(4, 1).DocUnits = 'kg/m^3';
saveVarsTmp{1}(4, 1).Description = '';
atmosphericDataBus.Elements = saveVarsTmp{1};
clear saveVarsTmp;

ctrlCmdsBus = Simulink.Bus;
ctrlCmdsBus.Description = ['This bus holds the control commnads sent by' ...
                           ' the Autopilo to the actuators. '];
ctrlCmdsBus.DataScope = 'Imported';
ctrlCmdsBus.HeaderFile = 'interfaceDefinition.h';
ctrlCmdsBus.Alignment = -1;
saveVarsTmp{1} = Simulink.BusElement;
saveVarsTmp{1}.Name = 'elevatorCmd';
saveVarsTmp{1}.Complexity = 'real';
saveVarsTmp{1}.Dimensions = 1;
saveVarsTmp{1}.DataType = 'double';
saveVarsTmp{1}.Min = [];
saveVarsTmp{1}.Max = [];
saveVarsTmp{1}.DimensionsMode = 'Fixed';
saveVarsTmp{1}.SamplingMode = 'Sample based';
saveVarsTmp{1}.SampleTime = -1;
saveVarsTmp{1}.DocUnits = 'rad';
saveVarsTmp{1}.Description = 'Elevator command in radians.';
saveVarsTmp{1}(2, 1) = Simulink.BusElement;
saveVarsTmp{1}(2, 1).Name = 'throttleCmd';
saveVarsTmp{1}(2, 1).Complexity = 'real';
saveVarsTmp{1}(2, 1).Dimensions = 1;
saveVarsTmp{1}(2, 1).DataType = 'double';
saveVarsTmp{1}(2, 1).Min = [];
saveVarsTmp{1}(2, 1).Max = [];
saveVarsTmp{1}(2, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(2, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(2, 1).SampleTime = -1;
saveVarsTmp{1}(2, 1).DocUnits = '%';
saveVarsTmp{1}(2, 1).Description = 'Aileron command in percent 0 -100.';
saveVarsTmp{1}(3, 1) = Simulink.BusElement;
saveVarsTmp{1}(3, 1).Name = 'aileronCmd';
saveVarsTmp{1}(3, 1).Complexity = 'real';
saveVarsTmp{1}(3, 1).Dimensions = 1;
saveVarsTmp{1}(3, 1).DataType = 'double';
saveVarsTmp{1}(3, 1).Min = [];
saveVarsTmp{1}(3, 1).Max = [];
saveVarsTmp{1}(3, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(3, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(3, 1).SampleTime = -1;
saveVarsTmp{1}(3, 1).DocUnits = 'rad';
saveVarsTmp{1}(3, 1).Description = 'Aileron command in radians.';
saveVarsTmp{1}(4, 1) = Simulink.BusElement;
saveVarsTmp{1}(4, 1).Name = 'rudderCmd';
saveVarsTmp{1}(4, 1).Complexity = 'real';
saveVarsTmp{1}(4, 1).Dimensions = 1;
saveVarsTmp{1}(4, 1).DataType = 'double';
saveVarsTmp{1}(4, 1).Min = [];
saveVarsTmp{1}(4, 1).Max = [];
saveVarsTmp{1}(4, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(4, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(4, 1).SampleTime = -1;
saveVarsTmp{1}(4, 1).DocUnits = 'rad';
saveVarsTmp{1}(4, 1).Description = 'Rudder command in radians.';
saveVarsTmp{1}(5, 1) = Simulink.BusElement;
saveVarsTmp{1}(5, 1).Name = 'flapCmd';
saveVarsTmp{1}(5, 1).Complexity = 'real';
saveVarsTmp{1}(5, 1).Dimensions = 1;
saveVarsTmp{1}(5, 1).DataType = 'double';
saveVarsTmp{1}(5, 1).Min = [];
saveVarsTmp{1}(5, 1).Max = [];
saveVarsTmp{1}(5, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(5, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(5, 1).SampleTime = -1;
saveVarsTmp{1}(5, 1).DocUnits = 'rad';
saveVarsTmp{1}(5, 1).Description = 'Flap command in radians.';
ctrlCmdsBus.Elements = saveVarsTmp{1};
clear saveVarsTmp;

env = struct;
env.ISA_lapse = 0.0065;
env.ISA_hmax = 2000;
env.ISA_R = 287.0531;
env.ISA_g = 9.80665;
env.ISA_rho0 = 1.225;
env.ISA_P0 = 101325;
env.ISA_T0 = 288.15;
env.windBase = 12;
env.windDirTurb = 180;
env.windDirHor = 90;
env.windOn = 0;

environmentDataBus = Simulink.Bus;
environmentDataBus.Description = ['This bus holds the data fron the Env' ...
                                  'ironment Model for simulation'];
environmentDataBus.DataScope = 'Auto';
environmentDataBus.HeaderFile = '';
environmentDataBus.Alignment = -1;
saveVarsTmp{1} = Simulink.BusElement;
saveVarsTmp{1}.Name = 'windVelocities';
saveVarsTmp{1}.Complexity = 'real';
saveVarsTmp{1}.Dimensions = 3;
saveVarsTmp{1}.DataType = 'double';
saveVarsTmp{1}.Min = [];
saveVarsTmp{1}.Max = [];
saveVarsTmp{1}.DimensionsMode = 'Fixed';
saveVarsTmp{1}.SamplingMode = 'Sample based';
saveVarsTmp{1}.SampleTime = -1;
saveVarsTmp{1}.DocUnits = 'm/s';
saveVarsTmp{1}.Description = '';
saveVarsTmp{1}(2, 1) = Simulink.BusElement;
saveVarsTmp{1}(2, 1).Name = 'windAngularRates';
saveVarsTmp{1}(2, 1).Complexity = 'real';
saveVarsTmp{1}(2, 1).Dimensions = 3;
saveVarsTmp{1}(2, 1).DataType = 'double';
saveVarsTmp{1}(2, 1).Min = [];
saveVarsTmp{1}(2, 1).Max = [];
saveVarsTmp{1}(2, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(2, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(2, 1).SampleTime = -1;
saveVarsTmp{1}(2, 1).DocUnits = 'rad/s';
saveVarsTmp{1}(2, 1).Description = '';
saveVarsTmp{1}(3, 1) = Simulink.BusElement;
saveVarsTmp{1}(3, 1).Name = 'localGravity';
saveVarsTmp{1}(3, 1).Complexity = 'real';
saveVarsTmp{1}(3, 1).Dimensions = 3;
saveVarsTmp{1}(3, 1).DataType = 'double';
saveVarsTmp{1}(3, 1).Min = [];
saveVarsTmp{1}(3, 1).Max = [];
saveVarsTmp{1}(3, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(3, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(3, 1).SampleTime = -1;
saveVarsTmp{1}(3, 1).DocUnits = 'm/s^2';
saveVarsTmp{1}(3, 1).Description = '';
saveVarsTmp{1}(4, 1) = Simulink.BusElement;
saveVarsTmp{1}(4, 1).Name = 'atmosphere';
saveVarsTmp{1}(4, 1).Complexity = 'real';
saveVarsTmp{1}(4, 1).Dimensions = 1;
saveVarsTmp{1}(4, 1).DataType = 'Bus: atmosphericDataBus';
saveVarsTmp{1}(4, 1).Min = [];
saveVarsTmp{1}(4, 1).Max = [];
saveVarsTmp{1}(4, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(4, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(4, 1).SampleTime = -1;
saveVarsTmp{1}(4, 1).DocUnits = '';
saveVarsTmp{1}(4, 1).Description = '';
environmentDataBus.Elements = saveVarsTmp{1};
clear saveVarsTmp;

gpsReading = Simulink.Bus;
gpsReading.Description = 'Generic structure to hold a GPS reading';
gpsReading.DataScope = 'Imported';
gpsReading.HeaderFile = 'interfaceDefinition.h';
gpsReading.Alignment = -1;
saveVarsTmp{1} = Simulink.BusElement;
saveVarsTmp{1}.Name = 'gps_latLon';
saveVarsTmp{1}.Complexity = 'real';
saveVarsTmp{1}.Dimensions = 2;
saveVarsTmp{1}.DataType = 'double';
saveVarsTmp{1}.Min = [];
saveVarsTmp{1}.Max = [];
saveVarsTmp{1}.DimensionsMode = 'Fixed';
saveVarsTmp{1}.SamplingMode = 'Sample based';
saveVarsTmp{1}.SampleTime = -1;
saveVarsTmp{1}.DocUnits = 'deg';
saveVarsTmp{1}.Description = '';
saveVarsTmp{1}(2, 1) = Simulink.BusElement;
saveVarsTmp{1}(2, 1).Name = 'gps_h';
saveVarsTmp{1}(2, 1).Complexity = 'real';
saveVarsTmp{1}(2, 1).Dimensions = 1;
saveVarsTmp{1}(2, 1).DataType = 'double';
saveVarsTmp{1}(2, 1).Min = [];
saveVarsTmp{1}(2, 1).Max = [];
saveVarsTmp{1}(2, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(2, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(2, 1).SampleTime = -1;
saveVarsTmp{1}(2, 1).DocUnits = 'm';
saveVarsTmp{1}(2, 1).Description = '';
saveVarsTmp{1}(3, 1) = Simulink.BusElement;
saveVarsTmp{1}(3, 1).Name = 'gps_cog';
saveVarsTmp{1}(3, 1).Complexity = 'real';
saveVarsTmp{1}(3, 1).Dimensions = 1;
saveVarsTmp{1}(3, 1).DataType = 'double';
saveVarsTmp{1}(3, 1).Min = [];
saveVarsTmp{1}(3, 1).Max = [];
saveVarsTmp{1}(3, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(3, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(3, 1).SampleTime = -1;
saveVarsTmp{1}(3, 1).DocUnits = 'deg';
saveVarsTmp{1}(3, 1).Description = '';
saveVarsTmp{1}(4, 1) = Simulink.BusElement;
saveVarsTmp{1}(4, 1).Name = 'gps_sog';
saveVarsTmp{1}(4, 1).Complexity = 'real';
saveVarsTmp{1}(4, 1).Dimensions = 1;
saveVarsTmp{1}(4, 1).DataType = 'double';
saveVarsTmp{1}(4, 1).Min = [];
saveVarsTmp{1}(4, 1).Max = [];
saveVarsTmp{1}(4, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(4, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(4, 1).SampleTime = -1;
saveVarsTmp{1}(4, 1).DocUnits = 'm/s';
saveVarsTmp{1}(4, 1).Description = '';
saveVarsTmp{1}(5, 1) = Simulink.BusElement;
saveVarsTmp{1}(5, 1).Name = 'gps_fix';
saveVarsTmp{1}(5, 1).Complexity = 'real';
saveVarsTmp{1}(5, 1).Dimensions = 1;
saveVarsTmp{1}(5, 1).DataType = 'uint8';
saveVarsTmp{1}(5, 1).Min = [];
saveVarsTmp{1}(5, 1).Max = [];
saveVarsTmp{1}(5, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(5, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(5, 1).SampleTime = -1;
saveVarsTmp{1}(5, 1).DocUnits = '';
saveVarsTmp{1}(5, 1).Description = '';
gpsReading.Elements = saveVarsTmp{1};
clear saveVarsTmp;

gsCommandsBus = Simulink.Bus;
gsCommandsBus.Description = ['Holds the Commands to be sent from the Gr' ...
                             'ound Station to the UAV'];
gsCommandsBus.DataScope = 'Imported';
gsCommandsBus.HeaderFile = 'interfaceDefinition.h';
gsCommandsBus.Alignment = -1;
saveVarsTmp{1} = Simulink.BusElement;
saveVarsTmp{1}.Name = 'U_c';
saveVarsTmp{1}.Complexity = 'real';
saveVarsTmp{1}.Dimensions = 1;
saveVarsTmp{1}.DataType = 'double';
saveVarsTmp{1}.Min = [];
saveVarsTmp{1}.Max = [];
saveVarsTmp{1}.DimensionsMode = 'Fixed';
saveVarsTmp{1}.SamplingMode = 'Sample based';
saveVarsTmp{1}.SampleTime = -1;
saveVarsTmp{1}.DocUnits = 'm/s';
saveVarsTmp{1}.Description = 'Airspeed Commanded by the GS';
saveVarsTmp{1}(2, 1) = Simulink.BusElement;
saveVarsTmp{1}(2, 1).Name = 'h_c_midLevel';
saveVarsTmp{1}(2, 1).Complexity = 'real';
saveVarsTmp{1}(2, 1).Dimensions = 1;
saveVarsTmp{1}(2, 1).DataType = 'double';
saveVarsTmp{1}(2, 1).Min = [];
saveVarsTmp{1}(2, 1).Max = [];
saveVarsTmp{1}(2, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(2, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(2, 1).SampleTime = -1;
saveVarsTmp{1}(2, 1).DocUnits = 'm';
saveVarsTmp{1}(2, 1).Description = ['Commanded altitude when in Mid Lev' ...
                                    'el Commands Mode. Also used as the' ...
                                    ' altitude for RTB'];
saveVarsTmp{1}(3, 1) = Simulink.BusElement;
saveVarsTmp{1}(3, 1).Name = 'psiDot_c_midLevel';
saveVarsTmp{1}(3, 1).Complexity = 'real';
saveVarsTmp{1}(3, 1).Dimensions = 1;
saveVarsTmp{1}(3, 1).DataType = 'double';
saveVarsTmp{1}(3, 1).Min = [];
saveVarsTmp{1}(3, 1).Max = [];
saveVarsTmp{1}(3, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(3, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(3, 1).SampleTime = -1;
saveVarsTmp{1}(3, 1).DocUnits = 'rad/sec';
saveVarsTmp{1}(3, 1).Description = ['Turnrate command when in mid Level' ...
                                    ' Commands guidance mode'];
saveVarsTmp{1}(4, 1) = Simulink.BusElement;
saveVarsTmp{1}(4, 1).Name = 'RTB';
saveVarsTmp{1}(4, 1).Complexity = 'real';
saveVarsTmp{1}(4, 1).Dimensions = 1;
saveVarsTmp{1}(4, 1).DataType = 'uint8';
saveVarsTmp{1}(4, 1).Min = [];
saveVarsTmp{1}(4, 1).Max = [];
saveVarsTmp{1}(4, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(4, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(4, 1).SampleTime = -1;
saveVarsTmp{1}(4, 1).DocUnits = '';
saveVarsTmp{1}(4, 1).Description = '';
saveVarsTmp{1}(5, 1) = Simulink.BusElement;
saveVarsTmp{1}(5, 1).Name = 'followMobile';
saveVarsTmp{1}(5, 1).Complexity = 'real';
saveVarsTmp{1}(5, 1).Dimensions = 1;
saveVarsTmp{1}(5, 1).DataType = 'uint8';
saveVarsTmp{1}(5, 1).Min = [];
saveVarsTmp{1}(5, 1).Max = [];
saveVarsTmp{1}(5, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(5, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(5, 1).SampleTime = -1;
saveVarsTmp{1}(5, 1).DocUnits = '';
saveVarsTmp{1}(5, 1).Description = '';
saveVarsTmp{1}(6, 1) = Simulink.BusElement;
saveVarsTmp{1}(6, 1).Name = 'isManualModeOn';
saveVarsTmp{1}(6, 1).Complexity = 'real';
saveVarsTmp{1}(6, 1).Dimensions = 1;
saveVarsTmp{1}(6, 1).DataType = 'uint8';
saveVarsTmp{1}(6, 1).Min = [];
saveVarsTmp{1}(6, 1).Max = [];
saveVarsTmp{1}(6, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(6, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(6, 1).SampleTime = -1;
saveVarsTmp{1}(6, 1).DocUnits = '';
saveVarsTmp{1}(6, 1).Description = '';
saveVarsTmp{1}(7, 1) = Simulink.BusElement;
saveVarsTmp{1}(7, 1).Name = 'guidanceMode';
saveVarsTmp{1}(7, 1).Complexity = 'real';
saveVarsTmp{1}(7, 1).Dimensions = 1;
saveVarsTmp{1}(7, 1).DataType = 'uint8';
saveVarsTmp{1}(7, 1).Min = [];
saveVarsTmp{1}(7, 1).Max = [];
saveVarsTmp{1}(7, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(7, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(7, 1).SampleTime = -1;
saveVarsTmp{1}(7, 1).DocUnits = '';
saveVarsTmp{1}(7, 1).Description = ['Determines if the UAV is following' ...
                                    ' a racetrack or orbiting around th' ...
                                    'e current WP'];
saveVarsTmp{1}(8, 1) = Simulink.BusElement;
saveVarsTmp{1}(8, 1).Name = 'viewPointIdx';
saveVarsTmp{1}(8, 1).Complexity = 'real';
saveVarsTmp{1}(8, 1).Dimensions = 1;
saveVarsTmp{1}(8, 1).DataType = 'uint8';
saveVarsTmp{1}(8, 1).Min = [];
saveVarsTmp{1}(8, 1).Max = [];
saveVarsTmp{1}(8, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(8, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(8, 1).SampleTime = -1;
saveVarsTmp{1}(8, 1).DocUnits = '';
saveVarsTmp{1}(8, 1).Description = '';
saveVarsTmp{1}(9, 1) = Simulink.BusElement;
saveVarsTmp{1}(9, 1).Name = 'MobileLocation';
saveVarsTmp{1}(9, 1).Complexity = 'real';
saveVarsTmp{1}(9, 1).Dimensions = 3;
saveVarsTmp{1}(9, 1).DataType = 'double';
saveVarsTmp{1}(9, 1).Min = [];
saveVarsTmp{1}(9, 1).Max = [];
saveVarsTmp{1}(9, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(9, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(9, 1).SampleTime = -1;
saveVarsTmp{1}(9, 1).DocUnits = '';
saveVarsTmp{1}(9, 1).Description = '';
saveVarsTmp{1}(10, 1) = Simulink.BusElement;
saveVarsTmp{1}(10, 1).Name = 'heartbeat';
saveVarsTmp{1}(10, 1).Complexity = 'real';
saveVarsTmp{1}(10, 1).Dimensions = 1;
saveVarsTmp{1}(10, 1).DataType = 'uint8';
saveVarsTmp{1}(10, 1).Min = [];
saveVarsTmp{1}(10, 1).Max = [];
saveVarsTmp{1}(10, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(10, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(10, 1).SampleTime = -1;
saveVarsTmp{1}(10, 1).DocUnits = '';
saveVarsTmp{1}(10, 1).Description = '';
gsCommandsBus.Elements = saveVarsTmp{1};
clear saveVarsTmp;

rawSensorDataBus = Simulink.Bus;
rawSensorDataBus.Description = '';
rawSensorDataBus.DataScope = 'Imported';
rawSensorDataBus.HeaderFile = 'interfaceDefinition.h';
rawSensorDataBus.Alignment = -1;
saveVarsTmp{1} = Simulink.BusElement;
saveVarsTmp{1}.Name = 'Euler_raw';
saveVarsTmp{1}.Complexity = 'real';
saveVarsTmp{1}.Dimensions = 3;
saveVarsTmp{1}.DataType = 'int16';
saveVarsTmp{1}.Min = [];
saveVarsTmp{1}.Max = [];
saveVarsTmp{1}.DimensionsMode = 'Fixed';
saveVarsTmp{1}.SamplingMode = 'Sample based';
saveVarsTmp{1}.SampleTime = -1;
saveVarsTmp{1}.DocUnits = '';
saveVarsTmp{1}.Description = '';
saveVarsTmp{1}(2, 1) = Simulink.BusElement;
saveVarsTmp{1}(2, 1).Name = 'Ab_raw';
saveVarsTmp{1}(2, 1).Complexity = 'real';
saveVarsTmp{1}(2, 1).Dimensions = 3;
saveVarsTmp{1}(2, 1).DataType = 'int16';
saveVarsTmp{1}(2, 1).Min = [];
saveVarsTmp{1}(2, 1).Max = [];
saveVarsTmp{1}(2, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(2, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(2, 1).SampleTime = -1;
saveVarsTmp{1}(2, 1).DocUnits = '';
saveVarsTmp{1}(2, 1).Description = '';
saveVarsTmp{1}(3, 1) = Simulink.BusElement;
saveVarsTmp{1}(3, 1).Name = 'G_raw';
saveVarsTmp{1}(3, 1).Complexity = 'real';
saveVarsTmp{1}(3, 1).Dimensions = 3;
saveVarsTmp{1}(3, 1).DataType = 'int16';
saveVarsTmp{1}(3, 1).Min = [];
saveVarsTmp{1}(3, 1).Max = [];
saveVarsTmp{1}(3, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(3, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(3, 1).SampleTime = -1;
saveVarsTmp{1}(3, 1).DocUnits = '';
saveVarsTmp{1}(3, 1).Description = '';
saveVarsTmp{1}(4, 1) = Simulink.BusElement;
saveVarsTmp{1}(4, 1).Name = 'q_raw';
saveVarsTmp{1}(4, 1).Complexity = 'real';
saveVarsTmp{1}(4, 1).Dimensions = 1;
saveVarsTmp{1}(4, 1).DataType = 'uint16';
saveVarsTmp{1}(4, 1).Min = [];
saveVarsTmp{1}(4, 1).Max = [];
saveVarsTmp{1}(4, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(4, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(4, 1).SampleTime = -1;
saveVarsTmp{1}(4, 1).DocUnits = '';
saveVarsTmp{1}(4, 1).Description = '';
saveVarsTmp{1}(5, 1) = Simulink.BusElement;
saveVarsTmp{1}(5, 1).Name = 'static_raw';
saveVarsTmp{1}(5, 1).Complexity = 'real';
saveVarsTmp{1}(5, 1).Dimensions = 1;
saveVarsTmp{1}(5, 1).DataType = 'uint16';
saveVarsTmp{1}(5, 1).Min = [];
saveVarsTmp{1}(5, 1).Max = [];
saveVarsTmp{1}(5, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(5, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(5, 1).SampleTime = -1;
saveVarsTmp{1}(5, 1).DocUnits = '';
saveVarsTmp{1}(5, 1).Description = '';
saveVarsTmp{1}(6, 1) = Simulink.BusElement;
saveVarsTmp{1}(6, 1).Name = 'T_raw';
saveVarsTmp{1}(6, 1).Complexity = 'real';
saveVarsTmp{1}(6, 1).Dimensions = 1;
saveVarsTmp{1}(6, 1).DataType = 'int16';
saveVarsTmp{1}(6, 1).Min = [];
saveVarsTmp{1}(6, 1).Max = [];
saveVarsTmp{1}(6, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(6, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(6, 1).SampleTime = -1;
saveVarsTmp{1}(6, 1).DocUnits = '';
saveVarsTmp{1}(6, 1).Description = '';
saveVarsTmp{1}(7, 1) = Simulink.BusElement;
saveVarsTmp{1}(7, 1).Name = 'ctrlSurface_PWM';
saveVarsTmp{1}(7, 1).Complexity = 'real';
saveVarsTmp{1}(7, 1).Dimensions = 5;
saveVarsTmp{1}(7, 1).DataType = 'int16';
saveVarsTmp{1}(7, 1).Min = [];
saveVarsTmp{1}(7, 1).Max = [];
saveVarsTmp{1}(7, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(7, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(7, 1).SampleTime = -1;
saveVarsTmp{1}(7, 1).DocUnits = '';
saveVarsTmp{1}(7, 1).Description = '';
rawSensorDataBus.Elements = saveVarsTmp{1};
clear saveVarsTmp;

sensors = struct;
sensors.noiseOn = 0;
sensors.max_euler = 6.2831853071795862;
sensors.max_accel = 4;
sensors.bit_scale = 32768;
sensors.max_gyro = 4;
sensors.max_temp = 150;
sensors.max_dyn = 1800;
sensors.gpsRefreshRate = 0.2;
sensors.max_ctrlSrfc = 1.5707963267948966;
sensors.antialiasBW = 40;

uavData = struct;
uavData.geometry = struct;
uavData.geometry.span = 2.795;
uavData.geometry.chord = 0.35134168157423973;
uavData.geometry.S = 0.982;
uavData.geometry.elarm = 1.21;
uavData.geometry.mass = 8.1646626600000012;
uavData.inertia = struct;
uavData.inertia.Ixx = 4.12;
uavData.inertia.Iyy = 9.58;
uavData.inertia.Izz = 9.85;
uavData.aero = struct;
uavData.aero.CL0 = 0.38;
uavData.aero.CLa = 18.5;
uavData.aero.CLa_dot = 2.64;
uavData.aero.CLq = 7.4;
uavData.aero.CLDe = 0.24;
uavData.aero.CLDf = 0.4;
uavData.aero.CD0 = 0.022;
uavData.aero.A1 = 0.007;
uavData.aero.Apolar = 0.057;
uavData.aero.CYb = -1.098;
uavData.aero.CYDr = 0.143;
uavData.aero.Clb = -0.296;
uavData.aero.Clp = -1.96;
uavData.aero.Clr = 0.103;
uavData.aero.ClDa = 0.1695;
uavData.aero.ClDr = 0.106;
uavData.aero.Cm0 = 0.3;
uavData.aero.Cma = -1.239;
uavData.aero.Cma_dot = -7;
uavData.aero.Cmq = -2.4;
uavData.aero.CmDe = -3.2;
uavData.aero.CmDf = -0.021;
uavData.aero.Cnb = 0.277;
uavData.aero.Cnp = -0.0889;
uavData.aero.Cnr = -0.19997;
uavData.aero.CnDa = -0.023;
uavData.aero.CnDr = -0.1997;
uavData.engine = struct;
uavData.engine.MinThK = 0.077;
uavData.engine.ThK = 2.17;
uavData.engine.TFact = 0.2;
uavData.ic = struct;
uavData.ic.Pos_0 = [0; 0; 50];
uavData.ic.Euler_0 = [0; 0; 1.5707963267948966];
uavData.ic.Omega_0 = [0; 0; 0];
uavData.ic.PQR_0 = [0; 0; 0];
uavData.ic.Vb_0 = [18; 0; 0];
uavData.ic.gsLL = [42.2996388 -71.3517757];
uavData.ic.gsH = 150;
uavData.sampleTime = 0.0005;

% Bus object: uavStateBus 
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'Euler';
elems(1).Dimensions = 3;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = sprintf('rad');
elems(1).Description = sprintf('Euler rotation angles [roll, pitch, yaw], in radians.');

elems(2) = Simulink.BusElement;
elems(2).Name = 'pqr';
elems(2).Dimensions = 3;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = sprintf('rad/s');
elems(2).Description = sprintf('angular rates in body-fixed axes, in radians per second.');

elems(3) = Simulink.BusElement;
elems(3).Name = 'X_e';
elems(3).Dimensions = 3;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = sprintf('m');
elems(3).Description = sprintf('position in the flat Earth reference frame.');

elems(4) = Simulink.BusElement;
elems(4).Name = 'V_e';
elems(4).Dimensions = 3;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = sprintf('m/s');
elems(4).Description = sprintf('velocity in the flat Earth reference frame.');

elems(5) = Simulink.BusElement;
elems(5).Name = 'A_b';
elems(5).Dimensions = 3;
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).Complexity = 'real';
elems(5).Min = [];
elems(5).Max = [];
elems(5).DocUnits = sprintf('m/s^2');
elems(5).Description = sprintf('accelerations in body-fixed axes.');

elems(6) = Simulink.BusElement;
elems(6).Name = 'baro';
elems(6).Dimensions = 1;
elems(6).DimensionsMode = 'Fixed';
elems(6).DataType = 'double';
elems(6).Complexity = 'real';
elems(6).Min = [];
elems(6).Max = [];
elems(6).DocUnits = sprintf('Pa');
elems(6).Description = '';

elems(7) = Simulink.BusElement;
elems(7).Name = 'q';
elems(7).Dimensions = 1;
elems(7).DimensionsMode = 'Fixed';
elems(7).DataType = 'double';
elems(7).Complexity = 'real';
elems(7).Min = [];
elems(7).Max = [];
elems(7).DocUnits = sprintf('Pa');
elems(7).Description = '';

elems(8) = Simulink.BusElement;
elems(8).Name = 'OAT';
elems(8).Dimensions = 1;
elems(8).DimensionsMode = 'Fixed';
elems(8).DataType = 'double';
elems(8).Complexity = 'real';
elems(8).Min = [];
elems(8).Max = [];
elems(8).DocUnits = sprintf('degree_Celsius');
elems(8).Description = '';

elems(9) = Simulink.BusElement;
elems(9).Name = 'airspeed';
elems(9).Dimensions = 1;
elems(9).DimensionsMode = 'Fixed';
elems(9).DataType = 'double';
elems(9).Complexity = 'real';
elems(9).Min = [];
elems(9).Max = [];
elems(9).DocUnits = sprintf('m/s');
elems(9).Description = '';

elems(10) = Simulink.BusElement;
elems(10).Name = 'gpsState';
elems(10).Dimensions = 1;
elems(10).DimensionsMode = 'Fixed';
elems(10).DataType = 'gpsReading';
elems(10).Complexity = 'real';
elems(10).Min = [];
elems(10).Max = [];
elems(10).DocUnits = '';
elems(10).Description = '';

elems(11) = Simulink.BusElement;
elems(11).Name = 'ctrlSurfacePos';
elems(11).Dimensions = 5;
elems(11).DimensionsMode = 'Fixed';
elems(11).DataType = 'double';
elems(11).Complexity = 'real';
elems(11).Min = [];
elems(11).Max = [];
elems(11).DocUnits = '';
elems(11).Description = '';

uavStateBus = Simulink.Bus;
uavStateBus.HeaderFile = '';
uavStateBus.Description = '';
uavStateBus.DataScope = 'Auto';
uavStateBus.Alignment = -1;
uavStateBus.PreserveElementDimensions = 0;
uavStateBus.Elements = elems;
clear elems;

waypoint = Simulink.Bus;
waypoint.Description = '';
waypoint.DataScope = 'Imported';
waypoint.HeaderFile = 'interfaceDefinition.h';
waypoint.Alignment = -1;
saveVarsTmp{1} = Simulink.BusElement;
saveVarsTmp{1}.Name = 'wpPos';
saveVarsTmp{1}.Complexity = 'real';
saveVarsTmp{1}.Dimensions = 3;
saveVarsTmp{1}.DataType = 'double';
saveVarsTmp{1}.Min = [];
saveVarsTmp{1}.Max = [];
saveVarsTmp{1}.DimensionsMode = 'Fixed';
saveVarsTmp{1}.SamplingMode = 'Sample based';
saveVarsTmp{1}.SampleTime = -1;
saveVarsTmp{1}.DocUnits = '';
saveVarsTmp{1}.Description = '';
saveVarsTmp{1}(2, 1) = Simulink.BusElement;
saveVarsTmp{1}(2, 1).Name = 'wpType';
saveVarsTmp{1}(2, 1).Complexity = 'real';
saveVarsTmp{1}(2, 1).Dimensions = 1;
saveVarsTmp{1}(2, 1).DataType = 'uint8';
saveVarsTmp{1}(2, 1).Min = [];
saveVarsTmp{1}(2, 1).Max = [];
saveVarsTmp{1}(2, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(2, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(2, 1).SampleTime = -1;
saveVarsTmp{1}(2, 1).DocUnits = '';
saveVarsTmp{1}(2, 1).Description = '';
saveVarsTmp{1}(3, 1) = Simulink.BusElement;
saveVarsTmp{1}(3, 1).Name = 'wpMetaData';
saveVarsTmp{1}(3, 1).Complexity = 'real';
saveVarsTmp{1}(3, 1).Dimensions = 1;
saveVarsTmp{1}(3, 1).DataType = 'double';
saveVarsTmp{1}(3, 1).Min = [];
saveVarsTmp{1}(3, 1).Max = [];
saveVarsTmp{1}(3, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(3, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(3, 1).SampleTime = -1;
saveVarsTmp{1}(3, 1).DocUnits = '';
saveVarsTmp{1}(3, 1).Description = '';
waypoint.Elements = saveVarsTmp{1};
clear saveVarsTmp;

PosVel_hat = Simulink.Bus;
PosVel_hat.Description = '';
PosVel_hat.DataScope = 'Auto';
PosVel_hat.HeaderFile = '';
PosVel_hat.Alignment = -1;
saveVarsTmp{1} = Simulink.BusElement;
saveVarsTmp{1}.Name = 'Ve_hat';
saveVarsTmp{1}.Complexity = 'real';
saveVarsTmp{1}.Dimensions = 3;
saveVarsTmp{1}.DataType = 'double';
saveVarsTmp{1}.Min = [];
saveVarsTmp{1}.Max = [];
saveVarsTmp{1}.DimensionsMode = 'Fixed';
saveVarsTmp{1}.SamplingMode = 'Sample based';
saveVarsTmp{1}.SampleTime = -1;
saveVarsTmp{1}.DocUnits = '';
saveVarsTmp{1}.Description = '';
saveVarsTmp{1}(2, 1) = Simulink.BusElement;
saveVarsTmp{1}(2, 1).Name = 'Xe_hat';
saveVarsTmp{1}(2, 1).Complexity = 'real';
saveVarsTmp{1}(2, 1).Dimensions = 3;
saveVarsTmp{1}(2, 1).DataType = 'double';
saveVarsTmp{1}(2, 1).Min = [];
saveVarsTmp{1}(2, 1).Max = [];
saveVarsTmp{1}(2, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(2, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(2, 1).SampleTime = -1;
saveVarsTmp{1}(2, 1).DocUnits = '';
saveVarsTmp{1}(2, 1).Description = '';
saveVarsTmp{1}(3, 1) = Simulink.BusElement;
saveVarsTmp{1}(3, 1).Name = 'Ab_bias_hat';
saveVarsTmp{1}(3, 1).Complexity = 'real';
saveVarsTmp{1}(3, 1).Dimensions = 3;
saveVarsTmp{1}(3, 1).DataType = 'double';
saveVarsTmp{1}(3, 1).Min = [];
saveVarsTmp{1}(3, 1).Max = [];
saveVarsTmp{1}(3, 1).DimensionsMode = 'Fixed';
saveVarsTmp{1}(3, 1).SamplingMode = 'Sample based';
saveVarsTmp{1}(3, 1).SampleTime = -1;
saveVarsTmp{1}(3, 1).DocUnits = '';
saveVarsTmp{1}(3, 1).Description = '';
PosVel_hat.Elements = saveVarsTmp{1};
clear saveVarsTmp;
