function [max, ind] = findMax (arr, arr1)
  max = -10000000000;
  ind = 0;
  for i = 1:numel(arr)
    if arr(i) > max && any(arr1 == arr(i))
      max = arr(i);
      ind = i;
    endif
  endfor
endfunction
