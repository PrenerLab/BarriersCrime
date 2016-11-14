clear
capture log close
set more off

// ==========================================================================

/*
This file will attempt to destring the ileadsaddress for each indiviual month
in the police data. Doing this will help me isolate which months are causing
problems with destringing ileadsaddress in the final file.
*/

// ==========================================================================

local years "2008 2009 2010 2011 2012 2013 2014 2015"
local months "January February March April May June July August September October November December"

local clean "/Users/`c(username)'/Desktop/Clean Data"

foreach year in `years' {

	foreach month in `months' {
		use "`clean'/`month'`year'.dta"
		
		confirm variable ileadsaddress
		
		destring ileadsaddress, replace
		
		clear
		
	}
}


foreach year in `years' {

	foreach month in `months' {
		use "`clean'/`month'`year'.dta"
		
		confirm numeric variable ileadsaddress
		
		clear
	}
}
