
clear
import delimited $rdata\stateQuarterly
gen GDP = datavalue * 10^unit_mult
drop v1 code cl_unit unit_mult datavalue
save $wdata\stateQuarterly, replace

clear
import delimited $rdata\stateAnnually
gen GDP = datavalue * 10^unit_mult
drop v1 code cl_unit unit_mult datavalue
save $wdata\stateAnnually, replace

clear
import delimited $rdata\stateAnnually_Nominal
gen GDP = datavalue * 10^unit_mult
drop v1 code cl_unit unit_mult datavalue
save $wdata\stateAnnually_Nominal, replace

clear
import delimited $rdata\countyAnnually
drop if datavalue == "NA"
destring datavalue, replace
gen GDP = datavalue * 10^unit_mult
drop v1 code cl_unit unit_mult datavalue noteref
save $wdata\countyAnnually, replace

clear
import delimited $rdata\MSAAnnually
gen GDP = datavalue * 10^unit_mult
drop v1 code cl_unit unit_mult datavalue noteref
save $wdata\MSAAnnually, replace
