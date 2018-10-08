%clear all; clc;
function [opt,C11,C12] = alphaLower(odf)


load alphatitaniumsmall;
load compliance50;
compliance = compliance50;
n = 50; %number of independent nodes

% max alpha
% subject to: 120 GPa <= C11 <= 130 GPa
%                   90 GPa <= C12 <= 95 GPa
%
% GA Solution:
%
% max alpha = 9.3682x10^-6 (1/K)
% C11 = 126.6925 GPa
% C12 = 90.0000 GPa

odf = odf';

S = compliance*odf;
Smatrix = reshape(S,6,6);  % averaged compliance matrix

C = inv(Smatrix);
C11 = C(1,1);
C12 = C(1,2);
alpha = reshape(thermalexpansion*odf,3,3); % thermal expansion tensor
alphaxx = alpha(1,1);
opt = alphaxx;
if C11<120 || C11>130 ||C12<90 ||C12>95
    opt = 10000;
end
println(opt)
println(C11)
println(C12)
opt = -opt
