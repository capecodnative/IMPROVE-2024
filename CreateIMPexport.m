%horizontally merge IMPelems and IMPloc and export as a csv table
writetable(array2table(horzcat(IMPelems, IMPloc)), 'IMPexport.csv');