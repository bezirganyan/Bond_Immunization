function [FinalPortfolio, FinalQuantyty] = buildFinalPortfolio (BondPairs, BondIndexes, SPResp, futureVals, EqIndex)
  FinalPortfolio = [];
  FinalQuantyty = [];
  for i = 1:2:numel(BondPairs);
    Resp1 = SPResp*BondPairs(i);
    Resp2 = SPResp*BondPairs(i+1);
    Count1 = Resp1/futureVals(BondIndexes(i));
    Count2 = Resp2/futureVals(BondIndexes(i+1));
    FinalPortfolio = [FinalPortfolio, BondIndexes(i), BondIndexes(i+1)];
    FinalQuantyty = [FinalQuantyty, ceil(Count1), ceil(Count2)];
  endfor
  if EqIndex ~= 0
    FinalPortfolio = [FinalPortfolio, SPResp];
    count = SPResp/futureVals(EqIndex);
    FinalQuantyty = [FinalQuantyty, ceil(count)];
  endif
endfunction