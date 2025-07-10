
capture log close

sysuse auto

log using "firstlog.log", replace

describe

regress price mpg rep78

twoway (scatter weight length) (lfit weight length), ///
 title("Weight vs. Length") 

graph export weight_vs_length.pdf, replace

capture log close 





