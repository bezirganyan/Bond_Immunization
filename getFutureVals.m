function [FutureVals] = getFutureVals (Maturities, LiabilityDuration, FaceVals, CouponRates, Frequencies, YMTs, AnnualCoupons)
  fv = [];
  for j = 1:numel(Maturities)
    summ = 0;
    for i = 1:LiabilityDuration
      if Maturities(j) == i
        summ += FaceVals(j)*(1+(YMTs(j))/100);
      else
        summ += CouponRates(j)*FaceVals(j)*Frequencies(j)/100;
      endif
      if LiabilityDuration == i && Maturities(j) > LiabilityDuration
        summ += getPresentValues(1, Maturities(j)-i, AnnualCoupons(j), FaceVals(j), YMTs(j));
      endif
    endfor
    fv = [fv, summ];
  endfor
  FutureVals = fv;
endfunction