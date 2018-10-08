function [opt,S11,S22] = yieldUpper(odf)

    data1 = load('alphatitaniummedium.mat');
    stiffness = data1.stiffness;

    data2 = load('linprog_yield_node.mat');
    yield = data2.propmat;
    
    n = 388; %number of independent nodes
    odf =odf';
    C = reshape(stiffness*odf,6,6);

    S = inv(C);
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
