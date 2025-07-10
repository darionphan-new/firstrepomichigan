********************************************
local tag problem_set //creating a local that will be used to name the log, data set, etc. this is a good habit and will be helpful when your code gets more complicated
*Mandate-Based Health Reform and the Labor Market: Evidence from the Massachusetts Reform (NBER Working Paper 17333) 
*Jonathan T. Kolstad and Amanda E. Kowalski, problem set developed by Toby Chaiken 
*Name 
*Date
********************************************

clear all //this clears any data currently loaded 
capture log close //this closes any logs you have already been started 
set more off //this stops the "more" messages from appearing at the bottom of your code when the display runs out

// cd "problem_set directory"
 //change directory to reflect the place where you saved the data


use `tag'.dta // this refers to the local macro above, designated as problem_set
log using `tag'.log, replace //starting a log so you refer to the results of your code at a later time


****************************************************
*****************Notes on Variables*****************
****************************************************

* a1	MA*ESHI*After
* a8	MA*ESHI
* a11	MA*After
* a12	ESHI*After
* a19	ESHI
* a22	After
* a23	MA
* a24	state (tfipsst)
* a25	Large
* c1	MA*ESHI*During
* c6	MA*During
* c7	ESHI*During
* c12	During

*vars d`i' = c`i'*a25
*vars b`i' = a`i'*a25

****************************************************
*********************Regression*********************
****************************************************

// Creating a global macro with the necessary variables for regressions  
global explvar_nopov	"b1 d1 b8 b11 d6 b12 d7 b19 b22 d12 a25 b23 a1 c1 a8 a11 c6 a12 c7 a19 a22 c12 a23 i.a24 i.b24"

//Regressions and Exporting to Excel
///For these regressions, we use areg because we want to include fixed effects by id, but we do not care to see the results of each id coefficient

//TABLE 7: RESULTS FROM PREFERRED SPECIFICATION (as in paper, ages 18-64)

drop if tage<18
drop if tage>64

areg w2 $explvar_nopov [pw=wpfinwgt], absorb(id) cluster(a24)
outreg2 using "pset_table.xls", replace excel bracket ci

areg h2 $explvar_nopov [pw=wpfinwgt], absorb(id) cluster(a24)
outreg2 using "pset_table.xls", append excel bracket ci

***Add additional regressions here. Be sure to specify in the outreg2 command a new file name OR "append excel" after "outreg2 using pset_table"



log close

