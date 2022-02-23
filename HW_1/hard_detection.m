% secription
function b = hard_detection(s,mod)
  L = length(s);
 
if mod == 1,
	b = zeros(1,L);
  % hard detection:
  for l=1:L,
	  if real(s(l)) >=0,
	    	b(l) = 1.0;
	  else
	     	b(l) = -1.0;
	  end
  end
else
	% QPSK (mod 2   in future)
	b = zeros(2*L);
	k = 1;
  for l=1:L,
      if real(s(l)) >= 0 && imag(s(l)) >= 0,
			b(k) = 1.0;
			b(k+1) = 1.0;
	  end;
	  if real(s(l)) >= 0 && imag(s(l)) < 0,
			b(k) = 1.0;
			b(k+1) = -1.0;
	  end;
	  if real(s(l)) < 0 && imag(s(l)) < 0,
			b(k) = -1.0;
			b(k+1) = -1.0;
	  end;
	  if real(s(l)) < 0 && imag(s(l)) >= 0,
			b(k) = -1.0;
			b(k+1) = 1.0;
	  end;
	k = k+2;		
  end
  %nothing here
end


end
