function [] = Print(varargin)
out = '';
for i=1:nargin
	val = varargin{i};
	
	if isnumeric(val)==1
		val = num2str(val);
	end
		
	out = strcat(out,val);
	
end
disp(out)
