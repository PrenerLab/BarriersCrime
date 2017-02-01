//==============================================================================
/*
Filename: postCADGeocodeClean.do
Created by: Taylor Braswell
Purpose: Clean CAD address data that's been geocoded so that it can be appended
back to the primary dataset.



*/
//==============================================================================
clear
set more off

import delimited "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/cad_geocode.csv"

//handle coordinates
drop xcoord ycoord
rename x xcoord
rename y ycoord

//drop variables Arc created
drop objectid score match_type match_addr side ref_id user_fld addr_type ///
	arc_single mergedcad
	
//rename variables that were cut off

rename dateoccurr dateOccurred
rename yearoccur yearOccurred
rename monthoccur monthOccurred
rename dayoccurre dayOccurred
rename timeoccurr timeOccurred
rename descriptio description
rename newcrime newCrime
rename neighborho neighborhood
rename ileadsaddr ileadsaddress
rename ileadsstre ileadsstreet
rename locationna locationName
rename locationco locationComment

save "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/cad_geocode.dta", replace

//create csv for matched addresses
keep if status == "M"

drop status

export delimited "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/cadMatched.csv", replace

clear
/* No unmatched cad addresses as of yet, so commenting out.
//create csv for unmatched addresses
use "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/ileads_geocode.dta"

drop if status == "M"

export delimited "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/ileadsUnmatched.csv", replace
*/
//remove unneeded dta file
shell rm -R "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/cad_geocode.dta"
