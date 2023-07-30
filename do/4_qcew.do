clear
cd $rdata/QCEW

local filenames: dir . files "*.csv"
tempfile building
quietly save `building', emptyok

foreach f of local filenames {
    import delim using `"`f'"', clear

    drop if industry_code != "10"
    drop if own_code != 0
    gen source_file = `"`f'"'
    gen geofips = substr(source_file, 1,5)
    drop source_file v1 area_fips own_code industry_code agglvl_code size_code disclosure_code

    append using `building', force
    save `"`building'"', replace
}

replace geofips = "1000" if geofips == "01000"
replace geofips = "2000" if geofips == "02000"
replace geofips = "4000" if geofips == "04000"
replace geofips = "5000" if geofips == "05000"
replace geofips = "6000" if geofips == "06000"
replace geofips = "8000" if geofips == "08000"
replace geofips = "9000" if geofips == "09000"
replace geofips = "0" if geofips == "US000"

destring geofips, replace
rename year timeperiod
sort geofips timeperiod qtr
order geofips

gen geoname=.
order geoname, before(timeperiod)
tostring geoname, replace
replace geoname="United States" if geofips == 0
replace geoname="Alabama" if geofips == 1000
replace geoname="Alaska" if geofips == 2000
replace geoname="Arizona" if geofips == 4000
replace geoname="Arkansas" if geofips == 5000
replace geoname="California" if geofips == 6000
replace geoname="Colorado" if geofips == 8000
replace geoname="Connecticut" if geofips == 9000
replace geoname="Delaware" if geofips == 10000
replace geoname="District of Columbia" if geofips == 11000
replace geoname="Florida" if geofips == 12000
replace geoname="Georgia" if geofips == 13000
replace geoname="Hawaii" if geofips == 15000
replace geoname="Idaho" if geofips == 16000
replace geoname="Illinois" if geofips == 17000
replace geoname="Indiana" if geofips == 18000
replace geoname="Iowa" if geofips == 19000
replace geoname="Kansas" if geofips == 20000
replace geoname="Kentucky" if geofips == 21000
replace geoname="Louisiana" if geofips == 22000
replace geoname="Maine" if geofips == 23000
replace geoname="Maryland" if geofips == 24000
replace geoname="Massachusetts" if geofips == 25000
replace geoname="Michigan" if geofips == 26000
replace geoname="Minnesota" if geofips == 27000
replace geoname="Mississippi" if geofips == 28000
replace geoname="Missouri" if geofips == 29000
replace geoname="Montana" if geofips == 30000
replace geoname="Nebraska" if geofips == 31000
replace geoname="Nevada" if geofips == 32000
replace geoname="New Hampshire" if geofips == 33000
replace geoname="New Jersey" if geofips == 34000
replace geoname="New Mexico" if geofips == 35000
replace geoname="New York" if geofips == 36000
replace geoname="North Carolina" if geofips == 37000
replace geoname="North Dakota" if geofips == 38000
replace geoname="Ohio" if geofips == 39000
replace geoname="Oklahoma" if geofips == 40000
replace geoname="Oregon" if geofips == 41000
replace geoname="Pennsylvania" if geofips == 42000
replace geoname="Rhode Island" if geofips == 44000
replace geoname="South Carolina" if geofips == 45000
replace geoname="South Dakota" if geofips == 46000
replace geoname="Tennessee" if geofips == 47000
replace geoname="Texas" if geofips == 48000
replace geoname="Utah" if geofips == 49000
replace geoname="Vermont" if geofips == 50000
replace geoname="Virginia" if geofips == 51000
replace geoname="Washington" if geofips == 53000
replace geoname="West Virginia" if geofips == 54000
replace geoname="Wisconsin" if geofips == 55000
replace geoname="Wyoming" if geofips == 56000

save $wdata/QCEW.dta, replace
