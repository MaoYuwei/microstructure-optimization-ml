%clear all; clc;
function [opt,C11,C12] = C11Lower(odf)

load alphatitaniumsmall;
load compliance50;
n = 50; %number of independent nodes
compliance = compliance50;
% max C11
% subject to: 90 GPa <= C12 <= 95 GPa
%
% GA Solution:
%
% max C11 = 144.2199 GPa
% C12 = 95.0000 GPa
odf = odf';


S = compliance*odf;
Smatrix = reshape(S,6,6);  % averaged compliance matrix

C = inv(Smatrix);
C11 = C(1,1);
C12 = C(1,2);

opt = C11;
if C12<90 ||C12>95
    opt = 10000;
end
println(opt)
println(C12)
opt = -opt
% maximize
