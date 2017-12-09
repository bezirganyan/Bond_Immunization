function [PresentValues] = getPresentValues(n, Maturities, AnnualCoupon, FaceVals, YMTs)
  for i = 1:n
    summ = 0;
    if Maturities(i) ~= 1
      k = 1:Maturities(i)-1;
      summ += sum(AnnualCoupon(i) ./ ((1 .+ YMTs(i)./100).^(k)));
    endif
    summ += (FaceVals(i) .+ AnnualCoupon(i))./((1 .+YMTs(i)./100).^Maturities(i));
    PresentValues(i) = summ;
  endfor
endfunction