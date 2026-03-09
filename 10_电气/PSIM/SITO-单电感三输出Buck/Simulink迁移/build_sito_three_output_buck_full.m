function modelName = build_sito_three_output_buck_full(runSimulation)
if nargin < 1
    runSimulation = false;
end

modelName = 'sito_three_output_buck_full';
modelDir = fileparts(mfilename('fullpath'));
modelPath = fullfile(modelDir, [modelName '.slx']);

params = localParams();

load_system('simulink');
load_system('powerlib');

if bdIsLoaded(modelName)
    close_system(modelName, 0);
end

if exist(modelPath, 'file')
    delete(modelPath);
end

new_system(modelName);
set_param(modelName, ...
    'Solver', 'ode23tb', ...
    'StopTime', '0.01', ...
    'MaxStep', '1e-6', ...
    'StartTime', '0', ...
    'SaveOutput', 'on', ...
    'SaveTime', 'on', ...
    'SignalLogging', 'on');

assignin('base', 'sito_cfg', params);

blks = struct();
ph = struct();

blks.powergui = add_block('powerlib/powergui', [modelName '/powergui'], ...
    'Position', [40 40 120 80]);
set_param(blks.powergui, 'SimulationMode', 'Continuous');

blks.vin = add_block('powerlib/Electrical Sources/DC Voltage Source', [modelName '/Vin_20V'], ...
    'Position', [70 180 130 240]);
set_param(blks.vin, 'Amplitude', num2str(params.Vin));

blks.gnd_vin = add_block('powerlib/Elements/Ground', [modelName '/GND_Vin'], ...
    'Position', [70 255 100 285]);

blks.q3 = add_block('powerlib/Power Electronics/Ideal Switch', [modelName '/Q3_Main'], ...
    'Position', [190 175 260 245]);
set_param(blks.q3, 'Ron', num2str(params.switchRon), 'Rs', num2str(params.snubberRs), 'Cs', params.snubberCs);

blks.d1 = add_block('powerlib/Power Electronics/Diode', [modelName '/D1_Freewheel'], ...
    'Position', [250 265 320 335], 'Orientation', 'up');
set_param(blks.d1, 'Ron', num2str(params.diodeRon), 'Vf', '0', 'UseSnubber', 'off', 'Rs', num2str(params.snubberRs), 'Cs', params.snubberCs);

blks.gnd_d1 = add_block('powerlib/Elements/Ground', [modelName '/GND_D1'], ...
    'Position', [260 345 290 375]);

blks.il = add_block('powerlib/Measurements/Current Measurement', [modelName '/IL_Meas'], ...
    'Position', [330 185 390 235]);

blks.l1 = add_block('powerlib/Elements/Series RLC Branch', [modelName '/L1_220uH'], ...
    'Position', [430 185 520 235]);
set_param(blks.l1, 'BranchType', 'L', 'Inductance', num2str(params.L), 'Resistance', '0', 'Measurements', 'Branch current');

blks.d2 = add_block('powerlib/Power Electronics/Diode', [modelName '/D2_Out1'], ...
    'Position', [560 65 630 125]);
set_param(blks.d2, 'Ron', num2str(params.diodeRon), 'Vf', '0', 'UseSnubber', 'off', 'Rs', num2str(params.snubberRs), 'Cs', params.snubberCs);

blks.c1 = add_block('powerlib/Elements/Series RLC Branch', [modelName '/C1_330uF'], ...
    'Position', [680 20 740 90], 'Orientation', 'down');
set_param(blks.c1, 'BranchType', 'C', 'Capacitance', num2str(params.C1), 'Setx0', 'off', 'InitialVoltage', '0');

blks.r1 = add_block('powerlib/Elements/Series RLC Branch', [modelName '/R1_12Ohm'], ...
    'Position', [780 20 840 90], 'Orientation', 'down');
set_param(blks.r1, 'BranchType', 'R', 'Resistance', num2str(params.R1));

blks.vm1 = add_block('powerlib/Measurements/Voltage Measurement', [modelName '/V1_Meas'], ...
    'Position', [875 20 915 90]);

blks.gnd_c1 = add_block('powerlib/Elements/Ground', [modelName '/GND_C1'], ...
    'Position', [685 105 715 135]);
blks.gnd_r1 = add_block('powerlib/Elements/Ground', [modelName '/GND_R1'], ...
    'Position', [785 105 815 135]);
blks.gnd_vm1 = add_block('powerlib/Elements/Ground', [modelName '/GND_VM1'], ...
    'Position', [885 105 915 135]);

blks.q4 = add_block('powerlib/Power Electronics/Ideal Switch', [modelName '/Q4_Out2'], ...
    'Position', [570 205 640 275]);
set_param(blks.q4, 'Ron', num2str(params.switchRon), 'Rs', num2str(params.snubberRs), 'Cs', params.snubberCs);

blks.d5 = add_block('powerlib/Power Electronics/Diode', [modelName '/D5_Out2'], ...
    'Position', [690 215 760 275]);
set_param(blks.d5, 'Ron', num2str(params.diodeRon), 'Vf', '0', 'UseSnubber', 'off', 'Rs', num2str(params.snubberRs), 'Cs', params.snubberCs);

blks.c2 = add_block('powerlib/Elements/Series RLC Branch', [modelName '/C2_330uF'], ...
    'Position', [820 180 880 250], 'Orientation', 'down');
set_param(blks.c2, 'BranchType', 'C', 'Capacitance', num2str(params.C2), 'Setx0', 'off', 'InitialVoltage', '0');

blks.r2 = add_block('powerlib/Elements/Series RLC Branch', [modelName '/R2_5Ohm'], ...
    'Position', [920 180 980 250], 'Orientation', 'down');
set_param(blks.r2, 'BranchType', 'R', 'Resistance', num2str(params.R2));

blks.vm2 = add_block('powerlib/Measurements/Voltage Measurement', [modelName '/V2_Meas'], ...
    'Position', [1015 180 1055 250]);

blks.gnd_c2 = add_block('powerlib/Elements/Ground', [modelName '/GND_C2'], ...
    'Position', [825 265 855 295]);
blks.gnd_r2 = add_block('powerlib/Elements/Ground', [modelName '/GND_R2'], ...
    'Position', [925 265 955 295]);
blks.gnd_vm2 = add_block('powerlib/Elements/Ground', [modelName '/GND_VM2'], ...
    'Position', [1025 265 1055 295]);

blks.q5 = add_block('powerlib/Power Electronics/Ideal Switch', [modelName '/Q5_Out3'], ...
    'Position', [570 385 640 455]);
set_param(blks.q5, 'Ron', num2str(params.switchRon), 'Rs', num2str(params.snubberRs), 'Cs', params.snubberCs);

blks.d6 = add_block('powerlib/Power Electronics/Diode', [modelName '/D6_Out3'], ...
    'Position', [690 395 760 455]);
set_param(blks.d6, 'Ron', num2str(params.diodeRon), 'Vf', '0', 'UseSnubber', 'off', 'Rs', num2str(params.snubberRs), 'Cs', params.snubberCs);

blks.c3 = add_block('powerlib/Elements/Series RLC Branch', [modelName '/C3_330uF'], ...
    'Position', [820 360 880 430], 'Orientation', 'down');
set_param(blks.c3, 'BranchType', 'C', 'Capacitance', num2str(params.C3), 'Setx0', 'off', 'InitialVoltage', '0');

blks.r3 = add_block('powerlib/Elements/Series RLC Branch', [modelName '/R3_3Ohm'], ...
    'Position', [920 360 980 430], 'Orientation', 'down');
set_param(blks.r3, 'BranchType', 'R', 'Resistance', num2str(params.R3));

blks.vm3 = add_block('powerlib/Measurements/Voltage Measurement', [modelName '/V3_Meas'], ...
    'Position', [1015 360 1055 430]);

blks.gnd_c3 = add_block('powerlib/Elements/Ground', [modelName '/GND_C3'], ...
    'Position', [825 445 855 475]);
blks.gnd_r3 = add_block('powerlib/Elements/Ground', [modelName '/GND_R3'], ...
    'Position', [925 445 955 475]);
blks.gnd_vm3 = add_block('powerlib/Elements/Ground', [modelName '/GND_VM3'], ...
    'Position', [1025 445 1055 475]);

blks.vref1 = add_block('simulink/Sources/Constant', [modelName '/Vref1_12V'], ...
    'Position', [90 580 120 600], 'Value', num2str(params.Vref1));
blks.sum1 = add_block('simulink/Math Operations/Sum', [modelName '/SUM1'], ...
    'Position', [190 575 220 605], 'Inputs', '+-');
blks.pi1 = add_block('simulink/Continuous/Transfer Fcn', [modelName '/PI1'], ...
    'Position', [255 570 345 610], ...
    'Numerator', mat2str([params.Kp1 * params.Ti1, params.Kp1]), ...
    'Denominator', mat2str([params.Ti1, 0]));
blks.lim1 = add_block('simulink/Discontinuities/Saturation', [modelName '/LIM1'], ...
    'Position', [390 570 450 610], 'UpperLimit', '1', 'LowerLimit', '0');

blks.vref2 = add_block('simulink/Sources/Constant', [modelName '/Vref2_5V'], ...
    'Position', [90 650 120 670], 'Value', num2str(params.Vref2));
blks.sum2 = add_block('simulink/Math Operations/Sum', [modelName '/SUM2'], ...
    'Position', [190 645 220 675], 'Inputs', '+-');
blks.pi2 = add_block('simulink/Continuous/Transfer Fcn', [modelName '/PI2'], ...
    'Position', [255 640 345 680], ...
    'Numerator', mat2str([params.Kp2 * params.Ti2, params.Kp2]), ...
    'Denominator', mat2str([params.Ti2, 0]));
blks.lim2 = add_block('simulink/Discontinuities/Saturation', [modelName '/LIM2'], ...
    'Position', [390 640 450 680], 'UpperLimit', '1', 'LowerLimit', '0');

blks.vref3 = add_block('simulink/Sources/Constant', [modelName '/Vref3_3V'], ...
    'Position', [90 720 120 740], 'Value', num2str(params.Vref3));
blks.sum3 = add_block('simulink/Math Operations/Sum', [modelName '/SUM3'], ...
    'Position', [190 715 220 745], 'Inputs', '+-');
blks.pi3 = add_block('simulink/Continuous/Transfer Fcn', [modelName '/PI3'], ...
    'Position', [255 710 345 750], ...
    'Numerator', mat2str([params.Kp3 * params.Ti3, params.Kp3]), ...
    'Denominator', mat2str([params.Ti3, 0]));
blks.lim3 = add_block('simulink/Discontinuities/Saturation', [modelName '/LIM3'], ...
    'Position', [390 710 450 750], 'UpperLimit', '1', 'LowerLimit', '0');

blks.ramp = add_block('simulink/Sources/Repeating Sequence', [modelName '/Ramp_50kHz'], ...
    'Position', [520 610 620 670], ...
    'rep_seq_t', mat2str([0, 1 / params.fs]), ...
    'rep_seq_y', '[0 1]');

blks.cmp1 = add_block('simulink/Logic and Bit Operations/Relational Operator', [modelName '/CMP1'], ...
    'Position', [680 570 740 610], 'Operator', '<');
blks.cmp2 = add_block('simulink/Logic and Bit Operations/Relational Operator', [modelName '/CMP2'], ...
    'Position', [680 640 740 680], 'Operator', '<');
blks.cmp3 = add_block('simulink/Logic and Bit Operations/Relational Operator', [modelName '/CMP3'], ...
    'Position', [680 710 740 750], 'Operator', '<');

blks.pwm1 = add_block('simulink/Signal Attributes/Data Type Conversion', [modelName '/PWM1_Double'], ...
    'Position', [770 570 815 610], 'OutDataTypeStr', 'double');
blks.pwm2 = add_block('simulink/Signal Attributes/Data Type Conversion', [modelName '/PWM2_Double'], ...
    'Position', [770 640 815 680], 'OutDataTypeStr', 'double');
blks.pwm3 = add_block('simulink/Signal Attributes/Data Type Conversion', [modelName '/PWM3_Double'], ...
    'Position', [770 710 815 750], 'OutDataTypeStr', 'double');

blks.mux_v = add_block('simulink/Signal Routing/Mux', [modelName '/MUX_Vout'], ...
    'Position', [1120 190 1125 275], 'Inputs', '3');
blks.scope_v = add_block('simulink/Sinks/Scope', [modelName '/Scope_Vout'], ...
    'Position', [1180 190 1240 275]);

blks.mux_ctrl = add_block('simulink/Signal Routing/Mux', [modelName '/MUX_Control'], ...
    'Position', [820 600 825 735], 'Inputs', '7');
blks.scope_ctrl = add_block('simulink/Sinks/Scope', [modelName '/Scope_Control'], ...
    'Position', [870 600 930 735]);

blks.scope_il = add_block('simulink/Sinks/Scope', [modelName '/Scope_IL'], ...
    'Position', [540 120 600 160]);

fields = fieldnames(blks);
for i = 1:numel(fields)
    ph.(fields{i}) = get_param(blks.(fields{i}), 'PortHandles');
end

add_line(modelName, ph.vin.RConn(1), ph.q3.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.vin.LConn(1), ph.gnd_vin.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.q3.RConn(1), ph.il.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.il.RConn(1), ph.l1.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.q3.RConn(1), ph.d1.RConn(1), 'autorouting', 'on');
add_line(modelName, ph.d1.LConn(1), ph.gnd_d1.LConn(1), 'autorouting', 'on');

add_line(modelName, ph.l1.RConn(1), ph.d2.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.d2.RConn(1), ph.c1.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.c1.LConn(1), ph.r1.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.c1.LConn(1), ph.vm1.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.c1.RConn(1), ph.gnd_c1.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.r1.RConn(1), ph.gnd_r1.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.vm1.LConn(2), ph.gnd_vm1.LConn(1), 'autorouting', 'on');

add_line(modelName, ph.l1.RConn(1), ph.q4.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.q4.RConn(1), ph.d5.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.d5.RConn(1), ph.c2.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.c2.LConn(1), ph.r2.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.c2.LConn(1), ph.vm2.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.c2.RConn(1), ph.gnd_c2.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.r2.RConn(1), ph.gnd_r2.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.vm2.LConn(2), ph.gnd_vm2.LConn(1), 'autorouting', 'on');

add_line(modelName, ph.l1.RConn(1), ph.q5.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.q5.RConn(1), ph.d6.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.d6.RConn(1), ph.c3.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.c3.LConn(1), ph.r3.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.c3.LConn(1), ph.vm3.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.c3.RConn(1), ph.gnd_c3.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.r3.RConn(1), ph.gnd_r3.LConn(1), 'autorouting', 'on');
add_line(modelName, ph.vm3.LConn(2), ph.gnd_vm3.LConn(1), 'autorouting', 'on');

add_line(modelName, ph.vref1.Outport(1), ph.sum1.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.vm1.Outport(1), ph.sum1.Inport(2), 'autorouting', 'on');
add_line(modelName, ph.sum1.Outport(1), ph.pi1.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.pi1.Outport(1), ph.lim1.Inport(1), 'autorouting', 'on');

add_line(modelName, ph.vref2.Outport(1), ph.sum2.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.vm2.Outport(1), ph.sum2.Inport(2), 'autorouting', 'on');
add_line(modelName, ph.sum2.Outport(1), ph.pi2.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.pi2.Outport(1), ph.lim2.Inport(1), 'autorouting', 'on');

add_line(modelName, ph.vref3.Outport(1), ph.sum3.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.vm3.Outport(1), ph.sum3.Inport(2), 'autorouting', 'on');
add_line(modelName, ph.sum3.Outport(1), ph.pi3.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.pi3.Outport(1), ph.lim3.Inport(1), 'autorouting', 'on');

add_line(modelName, ph.ramp.Outport(1), ph.cmp1.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.ramp.Outport(1), ph.cmp2.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.ramp.Outport(1), ph.cmp3.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.lim1.Outport(1), ph.cmp1.Inport(2), 'autorouting', 'on');
add_line(modelName, ph.lim2.Outport(1), ph.cmp2.Inport(2), 'autorouting', 'on');
add_line(modelName, ph.lim3.Outport(1), ph.cmp3.Inport(2), 'autorouting', 'on');

add_line(modelName, ph.cmp1.Outport(1), ph.pwm1.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.cmp2.Outport(1), ph.pwm2.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.cmp3.Outport(1), ph.pwm3.Inport(1), 'autorouting', 'on');

add_line(modelName, ph.pwm1.Outport(1), ph.q3.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.pwm2.Outport(1), ph.q4.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.pwm3.Outport(1), ph.q5.Inport(1), 'autorouting', 'on');

add_line(modelName, ph.vm1.Outport(1), ph.mux_v.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.vm2.Outport(1), ph.mux_v.Inport(2), 'autorouting', 'on');
add_line(modelName, ph.vm3.Outport(1), ph.mux_v.Inport(3), 'autorouting', 'on');
add_line(modelName, ph.mux_v.Outport(1), ph.scope_v.Inport(1), 'autorouting', 'on');

add_line(modelName, ph.lim1.Outport(1), ph.mux_ctrl.Inport(1), 'autorouting', 'on');
add_line(modelName, ph.lim2.Outport(1), ph.mux_ctrl.Inport(2), 'autorouting', 'on');
add_line(modelName, ph.lim3.Outport(1), ph.mux_ctrl.Inport(3), 'autorouting', 'on');
add_line(modelName, ph.ramp.Outport(1), ph.mux_ctrl.Inport(4), 'autorouting', 'on');
add_line(modelName, ph.pwm1.Outport(1), ph.mux_ctrl.Inport(5), 'autorouting', 'on');
add_line(modelName, ph.pwm2.Outport(1), ph.mux_ctrl.Inport(6), 'autorouting', 'on');
add_line(modelName, ph.pwm3.Outport(1), ph.mux_ctrl.Inport(7), 'autorouting', 'on');
add_line(modelName, ph.mux_ctrl.Outport(1), ph.scope_ctrl.Inport(1), 'autorouting', 'on');

add_line(modelName, ph.il.Outport(1), ph.scope_il.Inport(1), 'autorouting', 'on');

save_system(modelName, modelPath);

if runSimulation
    simOut = sim(modelName);
    save(fullfile(modelDir, [modelName '_simout.mat']), 'simOut');
end

open_system(modelName);
end

function params = localParams()
params = struct();
params.Vin = 20;
params.L = 220e-6;
params.C1 = 330e-6;
params.C2 = 330e-6;
params.C3 = 330e-6;
params.R1 = 12;
params.R2 = 5;
params.R3 = 3;
params.Vref1 = 12;
params.Vref2 = 5;
params.Vref3 = 3;
params.Kp1 = 0.05;
params.Ti1 = 0.001;
params.Kp2 = 1.5;
params.Ti2 = 0.00075;
params.Kp3 = 0.8;
params.Ti3 = 0.001067;
params.fs = 50e3;
params.switchRon = 4.8e-3;
params.diodeRon = 1e-3;
params.snubberRs = 1e6;
params.snubberCs = 'inf';
end
