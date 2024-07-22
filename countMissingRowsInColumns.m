function countMissingRowsInColumns(inputTable)
    % Initialize the number of missing values per column
    numMissing = zeros(1, width(inputTable));
    
    % Iterate over each column to handle different data types
    for i = 1:width(inputTable)
        columnData = inputTable.(i);
        if isnumeric(columnData) || islogical(columnData)
            % Use isnan for numeric and logical arrays
            numMissing(i) = sum(isnan(columnData));
        elseif iscell(columnData)
            % Check for empty cells as 'missing' for cell arrays
            numMissing(i) = sum(cellfun(@isempty, columnData));
        else
            % For strings and char arrays, check for empty strings
            numMissing(i) = sum(columnData == "" | columnData == '');
        end
    end
    
    % Sort the results to get indices of columns from least to most missing values
    [sortedNumMissing, sortedIndices] = sort(numMissing);
    
    % Get the column names in sorted order of missing values
    sortedColumnNames = inputTable.Properties.VariableNames(sortedIndices);
    
    % Display the sorted column names and their counts of missing values
    fprintf('Column\t\tMissing Values\n');
    fprintf('---------------------------\n');
    for i = 1:length(sortedColumnNames)
        fprintf('%s\t\t%d\n', sortedColumnNames{i}, sortedNumMissing(i));
    end
end