
clf
clear

% Arctic Center
hemisphere=1;
density=7;
cont=[0:2:10 15 20:10:60];
ref=12.5;

cgrid=true; % plot c-grid coastline
coastname='DECK'; % grid name

% location of grid file
gridloc='/Users/afroberts/data/MODEL/E3SM/DECK/grid';
gridfile='E3SM_LR_V1_grid.nc';

% location of sea ice data
dataloc='/Users/afroberts/data/MODEL/E3SM/DECK/monthly/h1/archive/ice/reduced';
datafile='mpascice.hist.am.timeSeriesStatsMonthly.1980-03-01.nc';
varu='timeMonthly_avg_uVelocityGeo';
varv='timeMonthly_avg_vVelocityGeo';
varc='timeMonthly_avg_iceAreaCell';
datatitle='Sea Ice Drift';

% plot location
plotloc='/Users/afroberts/work';

% %%%%%%%%%%%%%%% CHANGE ABOVE THIS LINE %%%%%%%%%%%%%%%%%% %

% obtain grid information (vertices, cell centers)
cd(gridloc)
ncvert=ridgepack_clone(gridfile,{'latVertex','lonVertex','dcEdge',...
                                 'verticesOnCell','indexToCellID',...
                                 'nEdgesOnCell','edgesOnCell',...
                                 'cellsOnEdge'});

nccell=ridgepack_clone(gridfile,{'latCell','lonCell'});

% obtain data
cd(dataloc)
ncu=ridgepack_clone(datafile,varu);
ncv=ridgepack_clone(datafile,varv);
ncc=ridgepack_clone(datafile,varc);

% plot streamlines
ridgepack_streame3sm(ncu,varu,ncv,varv,ncc,varc,...
                     ncvert,nccell,hemisphere,density,...
                     cont,ref)

% add title
title([datatitle])

cd(plotloc)
ridgepack_fprint('png','Outfile_Sea_Ice_Drift',1,1)


