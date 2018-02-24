%% clear
clc; clear all; close all;

%% path
addpath('../vesselness2d/lib')
addpath('./lib')

%% load image
im = imread ('./im/fungal_network.png');

%% normalize
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:)));

%% pct vesselness
nscale = 6; 
norient = 6; 
minWaveLength = 2; 
mult = 1.5; 
sigmaOnf = 0.6;
beta = 5.5; 
c = .5;

[imv,vx,vy] = vesselness_pct2d(im,nscale,norient,minWaveLength,mult,sigmaOnf,beta,c);

%% plot
figure; imagesc(im); colormap gray; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;

figure; imagesc(imv); colormap gray; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;