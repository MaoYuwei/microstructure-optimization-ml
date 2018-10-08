function [opt,S11,S22] = yieldLower(odf)

    load linprog849_compliance_node;
    compliance = propmat(1:36,:);
    volumefraction = propmat(end,:);
    load linprog_yield_node;
    yield = propmat;
    n = 388; %number of independent nodes
    % odf = zeros(n,1);
    %
    % p = 2;
    % odf(p) = 1./volumefraction(1,p);
    odf =odf';
    S = reshape(compliance*odf,6,6);
    S11 = S(1,1);
    S22 = S(2,2);
    YieldStress = yield*odf;
    opt = YieldStress;

    if S11>0.15 || S11<0 || S22>0.10|| S22<0
      opt = 10000;
    end

    println(opt);
    println(S11);
    println(S22);
    opt = -opt
