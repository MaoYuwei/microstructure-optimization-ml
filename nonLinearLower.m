%clear all; clc;
function [opt,C11,C12,S11,S22] = nonLinearLower(odf)

  n = 388; %number of independent nodes
  INVALID = 10000;

  load linprog849_compliance_node
  compliance = propmat(1:36,:);

  load linprog_yield_node
  yield = propmat;

  odf = odf';%transpose of odf for multiplying with compliance and yield matrices

  Svector = compliance*odf;
  Smatrix = reshape(Svector,6,6);
  S11 = Smatrix(1,1); % constraint
  S22 = Smatrix(2,2); % constraint

  Cmatrix = inv(Smatrix);
  C11 = Cmatrix(1,1); % constraint
  C12 = Cmatrix(1,2); % constraint

  stress = yield*odf;  % Yield stress averaging
  opt = stress; % In this case the opt is stress

  if C11<0 || C11>125 ||C12<75 || S11<0 || S11>0.15 || S22<0 || S22>0.10
      opt = INVALID;
  end

  println(opt)
  println(S11)
  println(S22)
  println(C11)
  println(C12)

  opt = -opt % negating as we are trying to maximize
