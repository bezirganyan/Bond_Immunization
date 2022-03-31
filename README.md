# Bond Immunizator

This is a minimal bond immunization code written in GNU Octave. (Theoretically
will work in Matlab too :)).

## Usage

For running this program you need to have GNU Octave or Matlab installed on your
system. Once installed, there are two ways to run the code: from console and
from GUI.

### Running code from console
1. Open console (in Mac and many Linux distros you can achieve this by opening
the terminal)
2. navigate to the directory where the files are. Note that you need all these
files to be in same directory.
3. type `octave immunization.m`

**Note that some of the values need to be inseted in square brackets []. Please
pay attention to instructions after running the application. Inputing data
without square brackets where needed, or with square brackets where is not
needed will give wrong result.**

### Running code from GUI
1. Open Octave GUI client
2. From the left panel navigate to the directory where code files are located.
Note that you need all has files to be in same directory.
3. Press __"Save file and Run"__ button and navigate to Command Window, or
   navigate to Command Window and type immunization.
   
**Note that some of the values need to be inseted in square brackets []. Please
pay attention to instructions after running the application. Inputing data
without square brackets where needed, or with square brackets where is not
needed will give wrong result.**
## The Algorithm

For the Immunization we used the Classic approach. We need to immunize the
portfolio so that the Duration of the portfolio coincides with the liability
duration.

For that we need to find weights of each bond in our portfolio. After some
research, we decided to use our own method of finding the weights.

We separate bonds with durations higher than the liability duration, and bonds
with durations lower than the liability durations.

Then we calculate the Ratio of Yield to Maturity and Maturity (YieldMaturityRatios) for each bond with
lower durations and Difference between Yield to Maturity and Coupon Rate
(YieldCouponRateDifference) for each bond within higher durations.

Then we compose pairs using greedy algorithm, by taking a bond with maximum
YieldMaturityRatios and a bond with maximum YieldCouponRateDifference.

We calculate the wights by solving
```
Weight1 + Weight2 = 1
Weight1*Duration1 + Weight2*Duration2 = LiabilityDuration
```

Then we devide the liability to the number of pairs and assign each pair to
cover its part of liability. If there exists a bond with Duration =
LiabilityDuration, we assign it a separate part.

Then it is easy to calculate how many from each bond we need by using the
weights.

## Example inputs

### Example 1
```
Please input the number of bonds 2
Please input the Yields to maturities of each bond separated by space [10 10]
Please input the Face Values of each bond separated by space [1000 1000]
Please input the Maturities of each bond separated by space [1 3]
Please input the Coupon Rates of each bond separated by space [7 8]
Please input the frequencies of each bond separated by space [1 1]
Please input the liability you have to pay 100000
Please input the liability duration 2
```
### Example 2
```
Please input the number of bonds 3
Please input the Yields to maturities of each bond separated by space [10 9 10]
Please input the Face Values of each bond separated by space [1000 1000 1000]
Please input the Maturities of each bond separated by space [2 1 3]
Please input the Coupon Rates of each bond separated by space [7 8 7]
Please input the frequencies of each bond separated by space [1 1 1]
Please input the liability you have to pay 100000
Please input the liability duration 2
```

