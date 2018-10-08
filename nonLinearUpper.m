%clear all; clc;
function [opt,C11,C12,S11,S22] = nonLinearUpper(odf)

  n = 388; %number of independent nodes
  INVALID = 10000;
  % max yield
  % subject to: 0<=S11<=0.15
  %                0<=S22<=0.10
  %                0<=C11<=175
  %                0<=C12<=75

  load linprog_yield_node
  yield = propmat;

  load alphatitaniummedium;

  odf = odf';%transpose of odf for multiplying with compliance and yield matrices

  Cvector = stiffness*odf;
  Cmatrix = reshape(Cvector,6,6);
  C11 = Cmatrix(1,1); % constraint
  C12 = Cmatrix(1,2); % constraint

  Smatrix = inv(Cmatrix);
  S11 = Smatrix(1,1); % constraint
  S22 = Smatrix(2,2); % constraint

  stress = yield*odf;  % Yield stress averaging
  opt = stress; % In this case the opt is stress

  if C11<0 || C11>175 ||C12<0||C12>75 || S11<0 || S11>0.15 || S22<0 || S22>0.10
      opt = INVALID;
  end

  println(opt)
  println(S11)
  println(S22)
  println(C11)
  println(C12)

  opt = -opt % negating as we are trying to maximize
