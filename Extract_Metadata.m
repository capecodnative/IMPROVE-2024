% Define the subdirectory path for reading
subdirectoryPath = './SourceData/';

% Define the output subdirectory path
outputSubdirectoryPath = './ExtractedData/';

% Define the sections
sections = {'Sites', 'Parameters', 'Status Flags'};

% Ensure the output directory exists, create if it doesn't
if ~exist(outputSubdirectoryPath, 'dir')
    mkdir(outputSubdirectoryPath);
end

% Open the text file for reading
fileID = fopen([subdirectoryPath, 'RevisedMetaData.txt'], 'r');

% Initialize a structure for file handles
fileHandles = struct();

% Dynamically create file handles for each section, replacing spaces with underscores for file names
for i = 1:length(sections)
    section = sections{i};
    fileName = [outputSubdirectoryPath, strrep(section, ' ', '_'), '.csv']; % Use the outputSubdirectoryPath variable
    fileHandles.(strrep(section, ' ', '_')) = fopen(fileName, 'w'); % Use underscores in field names
end

% Initialize the current section being processed
currentSection = '';

% Read the file line by line
line = fgetl(fileID);
while ischar(line)
    % Check if the line matches any section
    for i = 1:length(sections)
        section = sections{i};
        if matches(line, section)
            currentSection = strrep(section, ' ', '_'); % Use the modified section name for currentSection
            % Skip the blank line after the section header
            line = fgetl(fileID);
            line = fgetl(fileID);
            continue;
        end
    end
    
    % Write to the appropriate file based on the current section
    if ~isempty(currentSection) && ~isempty(strtrim(line))
        fprintf(fileHandles.(currentSection), '%s\n', line);
    elseif isempty(strtrim(line))
        % If the line is blank, reset the current section
        currentSection = '';
    end
    
    % Read the next line
    line = fgetl(fileID);
end

% Close all file handles
fclose(fileID);
fields = fieldnames(fileHandles);
for i = 1:numel(fields)
    fclose(fileHandles.(fields{i}));
end

clearvars ans currentSection fields fileHandles fileID fileName i line outputSubdirectoryPath section sections subdirectoryPath
