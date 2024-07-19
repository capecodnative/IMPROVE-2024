excelFilePath = './SourceData/CrustalRefs.xlsx';
opts = detectImportOptions(excelFilePath);
%Set all variables to doubles
opts.VariableTypes(:) = {'double'};
%Set the excel workbook to be 'Sheet1'
opts.Sheet = 'Sheet1';

%Read the data
CrustalRefs=readtable(excelFilePath, opts,'ReadRowNames',true);
