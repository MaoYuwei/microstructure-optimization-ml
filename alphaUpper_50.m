%clear all; clc;
function [opt,C11,C12] = alphaUpper_50(odf)

load alphatitaniumsmall;
n = 50; %number of independent nodes
odf = odf';
C = reshape(stiffness*odf,6,6);  % averaged stiffness matrix
C11 = C(1,1);
C12 = C(1,2);
alpha = reshape(thermalexpansion*odf,3,3); % thermal expansion tensor
alphaxx = alpha(1,1);
opt = alphaxx;
if C11<161 || C11>165 ||C12<75 ||C12>78
    opt = 10000;
end
println(opt)
println(C11)
println(C12)
opt = -opt
