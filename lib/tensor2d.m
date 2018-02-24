function t = tensor2d(imq,ang)
%%  tensor2d - calculate 2D tensor of the image
%   
%   REFERENCE:
%       Hans Knutsson, 
%       Representing local structure using tensors, 
%       The 6th Scandinavian Conference on Image Analysis, Oulu, Finland, 
%       244–251, June 1989
%
%   INPUT:
%       imq - responses n oriented quadrature filters in the spatial domain
%       a   - orientations
%
%   OUTPUT:
%       t   - tensor
%
%   HELP:
%       T = SUMi(|qi|(nini' - I) 
%       where: 
%           qi - response of i-th quadrature filter in the spatial domain
%
%   AUTHOR:
%       Boguslaw Obara

%% orientation vectors
ang = ang';
n = [cos(ang) sin(ang)];

%% tensor
t = zeros(size(imq,1),size(imq,2),4);
for i=1:length(ang)
    nnT = kron(n(i,:),n(i,:)');
    nnTI = nnT;
    t(:,:,1) = t(:,:,1) + imq(:,:,i)*nnTI(1,1);
    t(:,:,2) = t(:,:,2) + imq(:,:,i)*nnTI(1,2);
    t(:,:,3) = t(:,:,3) + imq(:,:,i)*nnTI(2,1);
    t(:,:,4) = t(:,:,4) + imq(:,:,i)*nnTI(2,2);
end

end