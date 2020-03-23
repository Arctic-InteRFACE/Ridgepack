
clf
clear

% Arctic Center
centlat=80; % degrees north
centlon=-150; % degrees east
horizon=30; % degrees of satellite horizon (0-90)
altitude=1; % Mean Earth radius multiple
cgrid=true; % plot c-grid coastline
coastname='DECK'; % grid name
plotmesh=true;

% location of grid file
gridloc='/Users/afroberts/data/MODEL/E3SM/DECK/grid';
gridfile='E3SM_LR_V1_grid.nc';

% location of sea ice data
dataloc='/Users/afroberts/data/MODEL/E3SM/DECK/monthly/h1/archive/ice/reduced';
datafile='mpascice.hist.am.timeSeriesStatsMonthly.1980-03-01.nc';

field='timeMonthly_avg_iceVolumeCell';
cont=[0:0.25:5.25];
ref=0;

% plot location
plotloc='/Users/afroberts/work';

% %%%%%%%%%%%%%%% CHANGE ABOVE THIS LINE %%%%%%%%%%%%%%%%%% %

% obtain grid information
cd(gridloc)
ncvert=ridgepack_clone(gridfile,{'latVertex','lonVertex','dcEdge',...
                                 'verticesOnCell','indexToCellID',...
                                 'nEdgesOnCell','edgesOnCell',...
                                 'cellsOnEdge'});

% obtain field data
cd(dataloc)
ncdata=ridgepack_clone(datafile,field);

% set up satellite view
ridgepack_satview(centlat,centlon,horizon,1,2);

% plot cell resolution
ridgepack_psatcole3sm(ncdata,field,ncvert,cont,ref,...
                      centlat,centlon,horizon,altitude);

% plot coastal outline
ridgepack_psatcoaste3sm(ncvert,cgrid,coastname,...
                             centlat,centlon,horizon);

% add colorbar
ridgepack_colorbar(cont,'km');

title('Grid Outline')

cd(plotloc)
ridgepack_fprint('png','Outfile',1,1)


