%Elements to subset are specified in the settings text file here:
ElemsSubsetPath = './Settings/ElemsSubset.txt';

IMPelems = subsetElemsTable(IMP,ElemsSubsetPath);
IMPelems = IMPelems(:, sort(IMPelems.Properties.VariableNames));

clear ElemsSubsetPath