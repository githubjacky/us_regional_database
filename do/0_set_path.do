
clear all
set more off
cap log close
global sysdate = c(current_date)


if "`c(username)'" == "ttyang" {
	
	global do = "C:\nest\Dropbox\RA_research\US_regional_database\data\do"
    global rdata = "C:\nest\Dropbox\RA_research\US_regional_database\data\rdata"
	global wdata = "C:\nest\Dropbox\RA_research\US_regional_database\data\wdata"
    
}
if "`c(username)'" == "jacky" {
    
	global do = "/Users/jacky/Documents/research/RA/Yang/US_regional_database/employment/do"
    global rdata = "/Users/jacky/Documents/research/RA/Yang/US_regional_database/employment/rdata"
	global wdata = "/Users/jacky/Documents/research/RA/Yang/US_regional_database/employment/wdata"
	
}
if "`c(username)'" == "" {
    
    global do = ""
    global rdata = ""
	global wdata = ""
	
}

if "`c(username)'" == "" {

    global do = ""
    global rdata = ""
	global wdata = ""

	
}

