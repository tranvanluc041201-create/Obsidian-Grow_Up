modelPath = 'C:\Users\GrowU\OneDrive\文档\MATLAB\sito_ctrl_l1.slx';

if ~isfile(modelPath)
    error('模型文件不存在: %s', modelPath);
end

[~, modelName, ~] = fileparts(modelPath);
load_system(modelPath);
cleanupObj = onCleanup(@() close_system(modelName, 0));

fprintf('=== MODEL ===\n');
fprintf('Path: %s\n', modelPath);
fprintf('Name: %s\n', modelName);

topBlocks = find_system(modelName, 'SearchDepth', 1, 'Type', 'Block');
topBlocks = topBlocks(2:end);

simscapeCount = 0;
spsCount = 0;

fprintf('\n=== TOP BLOCKS ===\n');
for i = 1:numel(topBlocks)
    block = topBlocks{i};
    blockType = '';
    maskType = '';
    ref = '';
    pos = [];

    try, blockType = get_param(block, 'BlockType'); end
    try, maskType = get_param(block, 'MaskType'); end
    try, ref = get_param(block, 'ReferenceBlock'); end
    try, pos = get_param(block, 'Position'); end

    lowerLine = lower(strjoin({block, blockType, maskType, ref}, ' | '));

    if contains(lowerLine, 'fl_lib') || contains(lowerLine, 'ee_lib') || contains(lowerLine, 'nesl_utility')
        simscapeCount = simscapeCount + 1;
    end

    if contains(lowerLine, 'powerlib') || contains(lowerLine, 'specialized power systems') || contains(lowerLine, 'powergui')
        spsCount = spsCount + 1;
    end

    if contains(lowerLine, 'capacitor') || contains(lowerLine, 'resistor') || contains(lowerLine, 'inductor') || ...
       contains(lowerLine, 'diode') || contains(lowerLine, 'mosfet') || contains(lowerLine, 'voltage sensor') || ...
       contains(lowerLine, 'solver') || contains(lowerLine, 'reference') || contains(lowerLine, 'converter') || ...
       contains(lowerLine, 'powergui')
        fprintf('%s | BT=%s | MASK=%s | REF=%s | POS=[%d %d %d %d]\n', ...
            block, blockType, maskType, ref, pos(1), pos(2), pos(3), pos(4));
    end
end

fprintf('\n=== DOMAIN CHECK ===\n');
fprintf('Simscape-related top blocks: %d\n', simscapeCount);
fprintf('SPS-related top blocks: %d\n', spsCount);
if spsCount > 0
    fprintf('Warning: 检测到 powergui / SPS 痕迹，当前模型不应混用 SPS 与 Simscape。\n');
end

fprintf('\n=== UNCONNECTED PORTS ===\n');
for i = 1:numel(topBlocks)
    block = topBlocks{i};
    blockType = '';
    maskType = '';
    ref = '';
    try, blockType = get_param(block, 'BlockType'); end
    try, maskType = get_param(block, 'MaskType'); end
    try, ref = get_param(block, 'ReferenceBlock'); end
    lowerLine = lower(strjoin({block, blockType, maskType, ref}, ' | '));

    if ~(contains(lowerLine, 'fl_lib') || contains(lowerLine, 'ee_lib') || contains(lowerLine, 'nesl_utility'))
        continue;
    end

    portHandles = get_param(block, 'PortHandles');
    fields = fieldnames(portHandles);
    for f = 1:numel(fields)
        fieldName = fields{f};
        handles = portHandles.(fieldName);
        if isempty(handles)
            continue;
        end
        handles = handles(:)';
        for handle = handles
            try
                lineHandle = get_param(handle, 'Line');
            catch
                lineHandle = -1;
            end
            if isequal(lineHandle, -1)
                fprintf('UNCONNECTED | %s | PORTTYPE=%s | HANDLE=%d\n', block, fieldName, handle);
            end
        end
    end
end

fprintf('\n=== MODEL UPDATE ===\n');
try
    set_param(modelName, 'SimulationCommand', 'update');
    fprintf('Update OK\n');
catch ME
    fprintf('Update Error: %s\n', strrep(ME.message, newline, ' '));
end
