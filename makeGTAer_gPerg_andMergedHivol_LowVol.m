GTAer_merged = GTAer;
toMerge = {'Al','Cd','Co','Cu','Fe','Mn','Pb','Ti','V'};
% Assuming GTAer_merged is a table and you want to add LowOrHigh as a new variable
% Directly create a categorical array with 'High' for all rows
GTAer_merged.LowOrHigh = repmat(categorical({'High'}, {'Low', 'High'}), height(GTAer_merged), 1);

% Find variables in GTAer_merged that are named in toMerge and have a corresponding _low variable
% Merge any non-NaN data in the _low variable into the GTAer_merged primary variable
% Do the same for any _low_flag variables (merging into the primary variable's _flag variable)
% Clear the _low and _low_flag variables after merging
for i = 1:length(toMerge)
    varName = toMerge{i};
    lowVarName = strcat(varName,'_low');
    flagVarName = strcat(varName,'_flag');
    lowFlagVarName = strcat(varName,'_low_flag');
    if ismember(lowVarName, GTAer_merged.Properties.VariableNames)
        % Merge the low data into the primary variable and save the rows that are NaN in the _low variable
        %get the rows that are NaN in the low variable
        nonNanRows = ~isnan(GTAer_merged.(lowVarName));
        % For those rows, merge the low data into the primary variable
        GTAer_merged.(varName)(nonNanRows) = GTAer_merged.(lowVarName)(nonNanRows);
        % For those rows, merge the low_flag data into the primary variable's flag variable
        GTAer_merged.(flagVarName)(nonNanRows) = GTAer_merged.(lowFlagVarName)(nonNanRows);
        % Tell the user how many rows were merged and which variable was merged
        fprintf('Merged %d rows from %s into %s\n', sum(nonNanRows), lowVarName, varName);
        % Clear the low variable and its flag variable
        GTAer_merged.(lowVarName) = [];
        GTAer_merged.(lowFlagVarName) = [];
        % Set the LowOrHigh variable to 'Low' for these rows
        GTAer_merged.LowOrHigh(nonNanRows) = 'Low';
    end
end

% For all columns in GTAer_merged that are valid element names 
% (have numeric weights returned by getAtomicWeight),,
% convert those data columns from molar to mass units using the atomic weight
for i = 1:width(GTAer_merged)
    varName = GTAer_merged.Properties.VariableNames{i};
    atomicWeight = getAtomicWeight(varName);
    %if getAtomicWeight returns a numeric value, convert that column to mass units
    if isnumeric(atomicWeight)
        GTAer_merged.(varName) = GTAer_merged.(varName) * atomicWeight;
        %tell the user which columns were converted
        fprintf('Converted %s to mass units\n', varName);
    end
    
end

clear toMerge varName lowVarName flagVarName lowFlagVarName nonNanRows i atomicWeight
