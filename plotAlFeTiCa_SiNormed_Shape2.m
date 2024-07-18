X = log10(IMPelems.Al./IMPelems.Si);
Y = log10(IMPelems.Fe./IMPelems.Si);
Z = log10(IMPelems.Ti./IMPelems.Si);
C = log10(IMPelems.Ca./IMPelems.Si); 

xRange = -2:0.1:2;
yRange = -3:0.1:3;
zRange = -3:0.1:1.5;
cRange = [-1.3131,0.9573];

axisLabels = ["log10(Al/Si)", "log10(Fe/Si)", "log10(Ti/Si)", "log10(Ca/Si) Ratio"];

visualize3DShape(X,Y,Z,C,xRange,yRange,zRange,cRange,axisLabels);

clear X Y Z C xRange yRange zRange cRange axisLabels