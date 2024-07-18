% Helper function to write the import report to a file
function writeReportToFile(report, filename)
    fid = fopen(filename, 'w');
    if fid == -1
        error('Cannot open file %s for writing.', filename);
    end
    fields = fieldnames(report);
    for i = 1:numel(fields)
        variableReport = report.(fields{i});
        fprintf(fid, 'Variable: %s\n', fields{i});
        % Dynamically read and write each field of the variable report
        reportFields = fieldnames(variableReport);
        for j = 1:numel(reportFields)
            fieldValue = variableReport.(reportFields{j});
            % Check if the field value is numeric or string for formatting
            if isnumeric(fieldValue)
                fprintf(fid, '%s: %d\n', reportFields{j}, fieldValue);
            else
                fprintf(fid, '%s: %s\n', reportFields{j}, fieldValue);
            end
        end
        fprintf(fid, '\n'); % Add a newline for separation between variables
    end
    fclose(fid);
end