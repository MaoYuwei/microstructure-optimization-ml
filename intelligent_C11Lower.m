function [odfs,data,count] = intelligent_C11Lower(num,randsize,func,population)

  load alphatitaniumsmall;
  odfDim = 50;
  constraint =  volumefraction;

  count = 0;
  total = 0;
  data = [];
  odfs = [];
  for j = 1:randsize
      cutsize = num - 1;
      randSep = sort(rand(1,cutsize));
      randIntvl = diff([0,randSep,1]);

      randInd = randsample(population,num);

      odf = zeros(1,odfDim);
      odf(1,randInd) = randIntvl./constraint(randInd);

      [val,C12] = func(odf);
      total = total + 1;
      if val == -10000;
          count = count + 1;
      else
        	odfs = [odfs;odf];
        	data = [data;odf,C12,-val];
        	disp(strcat('Row',num2str(total-count),' processed.........'));
      end
      if count == total;
          println('all invalid');
      end


  end
