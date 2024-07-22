function countMissingRowsInColumns(inputTable)
    % Calculate the number of missing values per column
    numMissing = varfun(@(x) sum(isnan(x)), inputTable, 'OutputFormat', 'uniform');
    
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