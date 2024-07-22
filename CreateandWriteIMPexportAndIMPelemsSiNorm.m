%horizontally merge IMPelems and IMPloc and export as a csv
writetable(horzcat(IMPloc, IMPelems), './CSVoutput/IMPexport.csv');

%  Write a separate table of log10 transformed Si-normalized IMPelems
% (dividing all elements by Si and taking the log10), and name the columns as log10-ElementSi
IMPelemsSiNorm = IMPelems;
IMPelemsSiNorm{:, 1:end} = log10(IMPelems{:, 1:end} ./ IMPelems{:, 'Si'});
IMPelemsSiNorm.Properties.VariableNames(1:end) = strcat('log10-', IMPelems.Properties.VariableNames(1:end), 'Si');

writetable(horzcat(IMPloc,IMPelemsSiNorm), './CSVoutput/IMPelemsSiNorm.csv');

clear IMPelemsSiNorm