function [pairs, indexes] = getBondPairs (High, Low, YtmRatio, YcrDiff, LiabilityDuration, Durations)
  pairs = [];
  indexes= [];
  for k=1:min(numel(High),numel(Low))
    [left, lind] = findMax(YtmRatio, YtmRatio(High));
    [right, rind] = findMax(YcrDiff, YcrDiff(Low)); 
    Wl = (LiabilityDuration - Durations(rind))/(Durations(lind) - Durations(rind));
    Wr = 1 - Wl;
    pairs = [pairs; Wl Wr;]
    indexes = [indexes; lind rind;];
  endfor
endfunction
