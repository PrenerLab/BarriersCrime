clear
capture log close
set more off

// ==========================================================================

/*
This .do file demonstrates the use of nested loops to clean and
append time series data. It relies on three folders existing on
your desktop:
	- Raw Data, which should contain the appropriate excel files
	- Clean Data
	- Full Data


subordinates:
 	initialClean.do


This .do file is only compatable with OS X.
*/

// ==========================================================================

local raw "/Users/`c(username)'/Documents/streetBarriers/BarriersCrime/Raw Data"
local clean "/Users/`c(username)'/Documents/streetBarriers/BarriersCrime/Clean Data"
local full "/Users/`c(username)'/Documents/streetBarriers/BarriersCrime/Full Data"

// ==========================================================================

cd "/Users/`c(username)'/Documents/streetBarriers/BarriersCrime/"
// ==========================================================================

// set local variables

local years "2008 2009 2010 2011 2012 2013 2014 2015"
local months "January February March April May June July August September October November December"

// ==========================================================================

// make clean and full data directories
capture confirm file "`clean'" // check if `name' subdir exists
if _rc { // _rc will be >0 if it doesn't exist
    mkdir "`clean'"
    }

capture confirm file "`full'" // check if `name' subdir exists
		if _rc { // _rc will be >0 if it doesn't exist
		    mkdir "`full'"
		    }

// ==========================================================================
// import excel files, confirm numeric data, and save as a .dta file

foreach year in `years' {

	foreach month in `months' {
		insheet using "`raw'/`month'`year'.csv" //firstrow

		do "/Users/`c(username)'/Documents/streetBarriers/BarriersCrime/Code/initialClean.do"
		do "/Users/`c(username)'/Documents/streetBarriers/BarriersCrime/Code/extracleaning.do"

		confirm numeric variable month
		confirm numeric variable year


		save "`clean'/`month'`year'.dta", replace

		clear
	}

}


// ==========================================================================

// create empty dataset

local x : word 1 of `months'
local y : word 1 of `years'

use "`clean'/`x'`y'"
drop _all //drops everything but the data structure
generate str _source = ""
save "`full'/stlcrime.dta", replace

// ==========================================================================

// append csv files together, populating the source variable

foreach year in `years' {

	foreach month in `months' {
		append using "`clean'/`month'`year'.dta", force
		replace _source = "`month'`year'.dta" if _source == ""
	}

}

// ==========================================================================

//give every row unique ID variable

gen id = _n
order id year month dateoccurred timeoccurred3 newcrime unfounded adjustment, first
order dateoccurred timeoccurred _source, last

// ==========================================================================

//Convert dates into STATA dates
gen date2 = date(date, "MDY")
format date2 %td
rename date2 dateoccurred1


// ==========================================================================
//covert time occurred into integers
split timeoccurred, parse(:)
gen timeoccurred3 = timeoccurred1+timeoccurred2
destring timeoccurred3, replace
drop timeoccurred1 timeoccurred2

// ==========================================================================


save "`full'/stlcrime.dta", replace

// ==========================================================================

tabulate _source

// ==========================================================================

log close

// ==========================================================================

exit
