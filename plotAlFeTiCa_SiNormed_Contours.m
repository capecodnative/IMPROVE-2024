X = log10(IMPelems.Al./IMPelems.Si);
Y = log10(IMPelems.Fe./IMPelems.Si);
Z = log10(IMPelems.Ti./IMPelems.Si);
C = log10(IMPelems.Ca./IMPelems.Si); 

xRange = -1.7:0.07:1.4;
yRange = -1.7:0.07:1.4;
zRange = -3:0.07:0.2;
cRange = [-1.31,0.96];
densityLevels = [3,10,50,100,200,400];

axisLabels = ["log10(Al/Si)", "log10(Fe/Si)", "log10(Ti/Si)", "log10(Ca/Si) Ratio"];

[hPatches,hScatter] = visualize3DContour(X,Y,Z,C,xRange,yRange,zRange,cRange,densityLevels,axisLabels,...
    0.15, 0.25, [0.2 0.2 0.2]);

clear X Y Z C xRange yRange zRange cRange axisLabels densityLevels

view(51,16);