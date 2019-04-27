clear all
set more off
use "/Users/gracekay/Desktop/final project/CMS Data- FULL Variable.dta" 
keep MIG* A1_* A2_* A2A1_* A3_* A9_* B11_* B11A_* B11B_* B11C_* B13_* B13A_* B13B_* B13C_* B17_1_* B17_1A_* B17_1B_* REM* HHID
reshape long MIG A1_ A2_ A2A1_ A3_ A9_ B11_ B11A_ B11B_ B11C_ B13_ B13A_ B13B_ B13C_ B17_1_ B17_1A_ B17_1B_ REM, i(HHID) j(year)  
foreach x of varlist A* B* MIG REM {
recode `x' (999=.) 
recode `x' (998=.)
}
recode B11_ (2=1)
recode B11_ (3=1)
replace A2_ = A2_/11.97295
replace A2A1_= A2A1_/11.97295
replace A3_ = A3_/11.97295
replace B11A_ = B11A_/11.97295
replace B13A_= B13A_/11.97295
replace B17_1A=B17_1A/11.97295
regress A1_ MIG if A1_==1| A1_==0
generate self_cult= A2_- A3_
generate wheat_prod= B13B_/B13A_
generate rice_prod= B11B_/B11A_
generate buck_prod= B17_1B/B17_1A
*collapse (sum) A2_ A2A1_ A3_ B11_ B11A_ B11B_ B11C_ B13_ B13A_ B13B_ B13C_ B17_1_ B17_1A_ B17_1B_ MIG REM, by(year)
generate total_production= B11B_+ B13B_
generate propotion_prod=B11B_/total_production 
regress MIG rice_prod
