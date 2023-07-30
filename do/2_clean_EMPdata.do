clear
import delimited $rdata/CAEMP_N.csv
gen employment = datavalue
drop v1 code cl_unit unit_mult datavalue noteref
save $wdata/CAEMP_N, replace

clear
import delimited $rdata/CAEMP_S.csv
gen employment = datavalue
drop v1 code cl_unit unit_mult datavalue noteref
save $wdata/CAEMP_S, replace

clear
use $wdata/CAEMP_N.dta
append using $wdata/CAEMP_S.dta
sort geofips timeperiod
save $wdata/CAEMP.dta
erase $wdata/CAEMP_N.dta
erase $wdata/CAEMP_S.dta


clear
import delimited $rdata/MAEMP_N.csv
gen employment = datavalue
drop v1 code cl_unit unit_mult datavalue noteref
save $wdata/MAEMP_N, replace

clear
import delimited $rdata/MAEMP_S.csv
gen employment = datavalue
drop v1 code cl_unit unit_mult datavalue noteref
save $wdata/MAEMP_S, replace

clear
use $wdata/MAEMP_N.dta
append using $wdata/MAEMP_S.dta
sort geofips timeperiod
save $wdata/MAEMP.dta
erase $wdata/MAEMP_N.dta
erase $wdata/MAEMP_S.dta



clear
import delimited $rdata/SAEMP_N.csv
gen employment = datavalue
drop v1 code cl_unit unit_mult datavalue
save $wdata/SAEMP_N, replace

clear
import delimited $rdata/SAEMP_S.csv
gen employment = datavalue
drop v1 code cl_unit unit_mult datavalue
save $wdata/SAEMP_S, replace

clear
use $wdata/SAEMP_N.dta
append using $wdata/SAEMP_S.dta
sort geofips timeperiod
unab vlist : _all
sort `vlist'
quietly by `vlist':  gen dup = cond(_N==1,0,_n)
drop if dup>1
drop dup
save $wdata/SAEMP.dta, replace
erase $wdata/SAEMP_N.dta
erase $wdata/SAEMP_S.dta
