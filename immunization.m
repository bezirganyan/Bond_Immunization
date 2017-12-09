fflush (stdout);

string_n = "Please input the number of bonds ";
string_YMT = "Please input the Yields to maturities of each bond separated by space in square brackets ";
string_fc =  "Please input the Face Values of each bond separated by space in square brackets ";
string_mat = "Please input the Maturities of each bond separated by space in square brackets ";
string_cr  = "Please input the Coupon Rates of each bond separated by space in square brackets ";
string_fr  = "Please input the frequencies of each bond separated by space in square brackets" ;
string_lb  = "Please input the liability you have to pay ";
string_lbd = "Please input the liability duration ";

n = input(string_n);
YMTs = input(string_YMT);
FaceVals = input(string_fc);
Maturities = input(string_mat);
CouponRates = input(string_cr);
Frequencies = input(string_fr);
Liability = input(string_lb);
LiabilityDuration = input(string_lbd);

%n = 2;
%YMTs = [10, 10];
%FaceVals = [1000, 1000];
%Maturities = [1, 3];
%CouponRates = [7, 8];
%Frequencies = [1, 1];
%Liability = 100000;
%LiabilityDuration = 2;

AnnualCoupons = annualcoupon = Frequencies .* (CouponRates .* FaceVals)./100;
PresentValues = getPresentValues(n, Maturities, AnnualCoupons, FaceVals, YMTs);
Durations = getDurations(n, Maturities, AnnualCoupons, FaceVals, YMTs, PresentValues);

printf("\nAnnual Coupons:");
printf("%7.2f", AnnualCoupons);
printf("\nDurations:");
printf("%7.2f", Durations);
printf("\n")
HighDurations = [];
LowDurations = [];
EqualExists = 0;
EqualIndex = 0;
for i = 1:n
  if (Durations(i) < LiabilityDuration)
    HighDurations = [HighDurations, i];
  elseif (Durations(i) > LiabilityDuration)
    LowDurations = [LowDurations, i];
  else
    EqualExists = 1;
    EqualIndex = i;
  endif
endfor

printf("\nHigh Durations:");
printf("%7.2f", Durations(HighDurations));
printf("\nLow Durations:");
printf("%7.2f", Durations(LowDurations));
printf("\n")

YieldToMaturityRatios = YMTs ./ Maturities;
YieldCouponRatesDiff = YMTs .- Maturities;

[BondPairs, BPIndexes] = getBondPairs(HighDurations, LowDurations, YieldToMaturityRatios, YieldCouponRatesDiff, LiabilityDuration, Durations);
SmallPortResponsibility = Liability/(numel(BondPairs)/2) + 1*EqualExists;

FutureVals = getFutureVals(Maturities, LiabilityDuration, FaceVals, CouponRates, Frequencies, YMTs, AnnualCoupons);

[FinalPortfolio, FinalQuantyty] = buildFinalPortfolio(BondPairs, BPIndexes, SmallPortResponsibility, FutureVals, EqualIndex);

printf("We need to take: \n");
for i = 1:numel(FinalPortfolio)
  printf("Bond %7.0f     with quantity %7.0f\n", FinalPortfolio(i), FinalQuantyty(i));
endfor

fm1 = getFutureVals(Maturities, LiabilityDuration, FaceVals, CouponRates, Frequencies, YMTs-1, AnnualCoupons);
f = getFutureVals(Maturities, LiabilityDuration, FaceVals, CouponRates, Frequencies, YMTs, AnnualCoupons);
fp1 = getFutureVals(Maturities, LiabilityDuration, FaceVals, CouponRates, Frequencies, YMTs+1, AnnualCoupons);

FinalMoneyMin1 = 0;
for i = 1:numel(BPIndexes);
  FinalMoneyMin1 += fm1(BPIndexes(i))*FinalQuantyty(i);
endfor

FinalMoney0 = 0;
for i = 1:numel(BPIndexes);
  FinalMoney0 += f(BPIndexes(i))*FinalQuantyty(i);
endfor

FinalMoneyPlus1 = 0;
for i = 1:numel(BPIndexes);
  FinalMoneyPlus1 += fp1(BPIndexes(i))*FinalQuantyty(i);
endfor
printf("In case the IRR drops by 1%% at the end we will have %7.5f\n", FinalMoneyMin1);
printf("In case the IRR does not change at the end we will have %7.5f\n", FinalMoney0);
printf("In case the IRR increases by 1%% at the end we will have %7.5f\n", FinalMoneyPlus1);