X = log10(IMPelems.Al./IMPelems.Si);
Y = log10(IMPelems.Fe./IMPelems.Si);
Z = log10(IMPelems.Ti./IMPelems.Si);
C = log10(IMPelems.Ca./IMPelems.Si); 

xRange = -1:0.03:.8;
yRange = -1.2:0.03:1;
zRange = -2.2:0.03:-0.2;
cRange = [-1.31,0.96];

axisLabels = ["log10(Al/Si)", "log10(Fe/Si)", "log10(Ti/Si)", "log10(Ca/Si) Ratio"];

visualize3DShape(X,Y,Z,C,xRange,yRange,zRange,cRange,5,axisLabels);

clear X Y Z C xRange yRange zRange cRange axisLabels