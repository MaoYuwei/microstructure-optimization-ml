%clear all; clc;
function [opt,C12] = C11Upper_50(odf)

load alphatitaniumsmall;
n = 50; %number of independent nodes
odf = odf';
C = reshape(stiffness*odf,6,6);  % averaged stiffness matrix
C11 = C(1,1);
C12 = C(1,2);
opt = C11;
if C12<75 ||C12>78
    opt = 10000;
end
println(opt)
println(C11)
println(C12)
opt = -opt
% maximize
