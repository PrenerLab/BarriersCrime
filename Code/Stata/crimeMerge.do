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

local raw "/Users/`c(username)'/Documents/Barriers/BarriersCrime/Raw Data"
local clean "/Users/`c(username)'/Documents/Barriers/BarriersCrime/Clean Data"
local full "/Users/`c(username)'/Documents/Barriers/BarriersCrime/Full Data"

// ==========================================================================

cd "/Users/`c(username)'/Documents/Barriers/BarriersCrime/"
// ==========================================================================

// set local variables

local years "2008 2009 2010 2011 2012 2013 2014 2015"
local months "January February March April May June July August September October November December"

// ==========================================================================

// make clean and full data directories
capture confirm file "`clean'" // check if `name' subdir exists
if _rc { // _rc will be >0 if it doesn't exist
    mkdir "`clean'", public
    }

capture confirm file "`full'" // check if `name' subdir exists
		if _rc { // _rc will be >0 if it doesn't exist
		    mkdir "`full'", public
		    }

// ==========================================================================
// import excel files, confirm numeric data, and save as a .dta file

foreach year in `years' {

	foreach month in `months' {
		insheet using "`raw'/`month'`year'.csv" //firstrow

		do "/Users/`c(username)'/Documents/Barriers/BarriersCrime/Code/Stata/initialClean.do"
		//do "/Users/`c(username)'/Documents/streetBarriers/BarriersCrime/Code/extracleaning.do"

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

//label and notate source variable in the final document
label variable _source "Source document"
note _source: Automatically populated during the append process

// ==========================================================================
//give every row unique ID variable

gen id = _n
order id dateOccurred yearOccurred monthOccurred dayOccurred timeOccurred ///
	month year ucr crime description newCrime unfounded adjustment count ///
	district neighborhood ileadsaddress ileadsstreet ///
	cadaddress cadstreet locationName locationComment ///
	xcoord ycoord insample _source, first


// ==========================================================================




// ==========================================================================

// ==========================================================================


save "`full'/stlcrime.dta", replace

// ==========================================================================

tabulate _source

// ==========================================================================

//log close

// ==========================================================================

exit
