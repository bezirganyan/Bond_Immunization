function [Durations] = getDurations(n, Maturities, AnnualCoupon, FaceVals, YMTs, PresentValues)
  for i = 1:n
    summ = 0;
    if Maturities(i) ~= 1
      k = 1:Maturities(i)-1;
      summ += sum(k * AnnualCoupon(i) ./ (PresentValues(i)*(1 .+ YMTs(i)./100).^(k)));
    endif
    summ += Maturities(i)*(FaceVals(i) .+ AnnualCoupon(i))./(PresentValues(i)*(1 .+YMTs(i)./100).^Maturities(i));
    Durations(i) = summ;
  endfor
endfunction