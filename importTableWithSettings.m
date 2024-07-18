% Import a table from a data file using saved column types
% If a settings file exists, apply the saved column types to the import options
% If a settings file does not exist, create it and save the column types
function dataTable = importTableWithSettings(dataFilePath, settingsFilePath, varargin)
    % Check if the settings file exists
    if exist(settingsFilePath, 'file')
        % Load the column types from the settings CSV file
        settingsTable = readtable(settingsFilePath);
        columnTypesMap = containers.Map(settingsTable.VariableName, settingsTable.VariableType);
    else
        % Detect default import options
        opts = detectImportOptions(dataFilePath);
        
        % Create a mapping of column names to their types
        columnTypesMap = containers.Map(opts.VariableNames, opts.VariableTypes);
        
        % Convert the map to a table and save it as a CSV file
        settingsTable = table(opts.VariableNames', opts.VariableTypes', 'VariableNames', {'VariableName', 'VariableType'});
        writetable(settingsTable, settingsFilePath);
    end
    
    % If settings were loaded or created, apply them
    if ~isempty(columnTypesMap)
        opts = detectImportOptions(dataFilePath);
        for i = 1:length(opts.VariableNames)
            varName = opts.VariableNames{i};
            if isKey(columnTypesMap, varName)
                opts = setvartype(opts, varName, columnTypesMap(varName));
            end
        end
    else
        opts = detectImportOptions(dataFilePath);
    end
    
    % Apply additional options provided by varargin
    if ~isempty(varargin)
        opts = setvaropts(opts, varargin{:});
    end
    
    % Read the data file into a table using the options
    dataTable = readtable(dataFilePath, opts);
    
    % Display the first few rows of the table
    disp(head(dataTable));
    
    % Return the imported table
    return;
end