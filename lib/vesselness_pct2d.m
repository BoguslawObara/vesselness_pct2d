function [imv,vx,vy,l1,l2] = vesselness_pct2d(varargin)
%%  vesselness2d - multiscale vessel enhancement filtering
%   
%   REFERENCE:
%       A.F. Frangi, et al. 
%       Multiscale Vessel Enhancement Filtering
%       Lecture Notes in Computer Science, 1496, 130-137, 1998
%
%   INPUT:
%       im      - 2D gray image
%       sigma   - Gaussian kernel sigma [1 2 3 ...]
%       gamma   - vesselness threshold parameter
%       beta    - vesselness threshold parameter
%       c       - vesselness threshold parameter
%       wb      - detect black or white regions
%
%   OUTPUT:
%       imv     - vesselness
%       v       - all vesselness images for each sigma
%
%   AUTHOR:
%       Boguslaw Obara
%

%% vesselness parameters
im = varargin{1};
beta = varargin{length(varargin)-1};
c = varargin{length(varargin)};

%% phase
[M,m,or,featType,PC,EO,t,pcSum] = phasecong3(varargin{:});

%% oriented quadrature filters
no = length(PC);
a = ((1:no)-1)*pi/no; % angles
imqf = zeros(size(im,1),size(im,2),no); 
for o=1:no
    imqf(:,:,o) = PC{o};
end

%% tensor
t = tensor2d(imqf,a);

%% eigen values and vectors
[l1,l2,v1,v2,v3,v4] = eigen2d_m(t(:,:,1),t(:,:,2),t(:,:,3),t(:,:,4));

%% sort
index = abs(l1)>abs(l2); %<
l1s = l1; 
l2s = l2;
l1s(index) = l2(index);
l2s(index) = l1(index);
l1 = l1s;
l2 = l2s;
l2(l2==0) = eps;

v3s = v3;
v4s = v4;
v3s(index) = v1(index);
v4s(index) = v2(index);
vy = v4s; 
vx = v3s;

%% vesselness 
rbeta = l1./l2;
s = sqrt(l1.^2 + l2.^2);     
vo = exp(-(rbeta.^2)/(2*beta^2)).*(ones(size(im))-exp(-(s.^2)/(2*c^2)));    

%% normalize
imv = (im + vo);
imv = double(imv); imv = (imv - min(imv(:))) / (max(imv(:)) - min(imv(:)));

end