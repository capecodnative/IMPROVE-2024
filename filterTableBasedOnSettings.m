function filteredTable = filterTableBasedOnSettings(importedTable, settingsFilePath, reportFilePath)
    % Read the settings file
    settings = readtable(settingsFilePath);
    
    % Filter out settings for columns without a new name
    settings = settings(~ismissing(settings.VariableNewName), :);
    
    % Initialize a new table for the filtered data
    filteredTable = table();
    
    % Initialize a structure to keep track of filtering
    filterReport = struct();
    
    % Loop through the settings to rename and filter columns
    for i = 1:height(settings)
        originalVarName = settings.VariableName{i};
        newVarName = settings.VariableNewName{i};
        
        % Check if the imported table contains the column
        if ismember(originalVarName, importedTable.Properties.VariableNames)
            % Add the column to the filtered table with the new name
            filteredTable.(newVarName) = importedTable.(originalVarName);
        end
    end
    
    % Initialize filterReport outside the loop
    filterReport = struct();

    for varNameCell = filteredTable.Properties.VariableNames
        varName = string(varNameCell); % Convert varName to string
        mdlColumn = strcat(varName, '_MDL');

        if ismember(mdlColumn, filteredTable.Properties.VariableNames)
            % Identify rows where the condition is met
            belowMDL = filteredTable.(varName) < filteredTable.(mdlColumn);
            belowOrEqualZero = filteredTable.(varName) <= 0;
            % Adjust conditions to be exclusive
            exclusivelyBelowMDL = belowMDL & ~belowOrEqualZero;

            % Update counters
            totalFiltered = sum(belowMDL | belowOrEqualZero);

            % Set values to NaN where condition is true
            filteredTable.(varName)(belowMDL | belowOrEqualZero) = NaN;

            % Store the report for the current variable
            filterReport.(varName) = struct('TotalFiltered', totalFiltered, ...
                                             'FilteredBelowMDLOnly', sum(exclusivelyBelowMDL), ...
                                             'FilteredBelowOrEqualZero', sum(belowOrEqualZero));
        end
    end
    
    % Display the first few rows of the filtered table
    disp(head(filteredTable));
        
    writeReportToFile(filterReport, reportFilePath);
end
