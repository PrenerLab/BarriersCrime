//==============================================================================
/*
This valid takes the police data with missing x/y coordinates and divides them
into subgroups:

1. Data with an ileads address
2. Data with no ileads address but with a CAD address
3. Intersections instead of an address
4. A possible location name instead of an address
5. Observations with no spatial data.

Each of these groups is exported to a CSV file where they will undergo further
investigation.


*/
//==============================================================================
clear

cd "/Users/`c(username)/Documents/Barriers/BarriersCrime/Working Data"
//==============================================================================

//create yesiLeads.csv
import delimited badData2016.csv, varnames(1)
drop if ileadsaddress == 0 | ileadsaddress == . | ileadsaddress == 999 | ///
	ileadsaddress == 9999 | ileadsstreet == "UNKNOWN" | ///
	ileadsstreet == "UNKNOWN ST LOUIS" | ileadsstreet == "CITY OF ST LOUIS" ///
	| ileadsstreet == ""

//generate merged ileads address for geocoding
tostring ileadsaddress, replace
generate mergedileads = ileadsaddress + " " + ileadsstreet

export delimited using yesiLeads2016.csv, replace
clear
//==============================================================================

//create yesCAD.csv
import delimited badData2016.csv, varnames(1)
keep if ileadsaddress == 0 | ileadsaddress == . | ileadsaddress == 999 | ///
	ileadsaddress == 9999 | ileadsstreet == "UNKNOWN" | ///
	ileadsstreet == "UNKNOWN ST LOUIS" | ileadsstreet == "CITY OF ST LOUIS" ///
	| ileadsstreet == ""
drop if cadaddress == 0 | cadaddress == . | cadaddress == 999 | ///
	cadaddress == 9999 | cadstreet == "UNKNOWN" | ///
	cadstreet == "UNKNOWN ST LOUIS" | cadstreet == "CITY OF ST LOUIS" | ///
	cadstreet == "" 
	
//generate merged cad address for geocoding
tostring cadaddress, replace
generate mergedcad = cadaddress + " " + cadstreet

export delimited using yesCAD2016.csv, replace
clear
//==============================================================================

//create intersection.csv
import delimited badData2016.csv, varnames(1)
keep if strpos(ileadsstreet, "/") | strpos(ileadsstreet, "@") | ///
	strpos(ileadsstreet, "-") 
//parse into two variables
split ileadsstreet, generate(street) parse(/ @)
	
export delimited using intersection2016.csv, replace
clear

//==============================================================================

//create location.csv
import delimited badData2016.csv, varnames(1)
keep if ileadsaddress == 0 | ileadsaddress == . | ileadsaddress == 999 | ///
	ileadsaddress == 9999 | ileadsstreet == "UNKNOWN" | ///
	ileadsstreet == "UNKNOWN ST LOUIS" | ileadsstreet == "CITY OF ST LOUIS" ///
	| ileadsstreet == ""
keep if cadaddress == 0 | cadaddress == . | cadaddress == 999 | ///
	cadaddress == 9999 | cadstreet == "UNKNOWN" | ///
	cadstreet == "UNKNOWN ST LOUIS" | cadstreet == "CITY OF ST LOUIS" | ///
	cadstreet == "" 
drop if strpos(ileadsstreet, "/") | strpos(ileadsstreet, "@") | ///
	strpos(ileadsstreet, "-")
keep if locationname != "" | locationcomment != ""
export delimited using location2016.csv, replace
clear
//==============================================================================

//create nospatial.csv
import delimited badData2016.csv, varnames(1)
keep if ileadsaddress == 0 | ileadsaddress == . | ileadsaddress == 999 | ///
	ileadsaddress == 9999 | ileadsstreet == "UNKNOWN" | ///
	ileadsstreet == "UNKNOWN ST LOUIS" | ileadsstreet == "CITY OF ST LOUIS" ///
	| ileadsstreet == ""
keep if cadaddress == 0 | cadaddress == . | cadaddress == 999 | ///
	cadaddress == 9999 | cadstreet == "UNKNOWN" | ///
	cadstreet == "UNKNOWN ST LOUIS" | cadstreet == "CITY OF ST LOUIS" | ///
	cadstreet == "" 
drop if strpos(ileadsstreet, "/") | strpos(ileadsstreet, "@") | ///
	strpos(ileadsstreet, "-")
drop if locationname != "" | locationcomment != ""
export delimited using noSpatial2016.csv, replace
clear


