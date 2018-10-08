% random partition the sum of 1
% only generate small number of partitions assuming that

function intelNonLinearTop(randsize)
INVALID = 10000;
num = 2;
odfDim = 388;
count = 0;

counter = [];
odfs = [];
Data = [];

load linprog849_compliance_node;
compliance = propmat(1:36,:);
volumefraction = propmat(end,:);

load linprog_yield_node;
optType = 'intel_NL_Top';
propFunc = @stress_nonLinear;


load populationTop;

tic
% 1 partition - odfDim outcomes 50 for Titanium, 76 for Galfenol
if num == 1
	for i = 1:odfDimq
    		odf_1 = zeros(1,odfDim);
    		odf_1(i) = 1./constraint(i);
    		odf = odf_1(i)
    		[val,C11,C12,S11,S22] = propFunc(odf_1);
    		if val == -INVALID
        		count = count + 1;
    		else
					odfs = [odfs;odf_1];
					Data = [Data;odf_1,C11,C12,S11,S22,-val];

    		end
	end

else

	[odfarray,dataarray,invalid] = intelligentSmallPartitionNonLinear(2,randsize,propFunc,population);
  println(length(odfarray)) ;
	odfs = [odfs;odfarray];
	Data = [Data;dataarray];


end
toc
t = toc;
t_Y_RkI = t;
println('Invalid',invalid);
println(t);
fileName = strcat(optType,'Data/',optType,'_SmallPartition',num2str(num),'_',num2str(randsize),'.mat');
save(fileName,'Data','odfs','randsize','count','t_*');
%findMaxMin(fileName);
% exit;
