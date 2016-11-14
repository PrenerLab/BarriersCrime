// ==========================================================================

/*
This .do file is called by nestedloop.do to clean each individual police data
file.
*/

// ==========================================================================



/* Run code for alternative data structure */

capture confirm variable codedmonth

if _rc != 111 {


//drop variables not included in original data structure
drop flagcleanup
drop complaint

//rename variables to match orginal data structure 

rename codedmonth monthreportedtomshp
rename dateoccur dateoccured
rename flagunfounded unfoundedcrimeindicator
rename flagadministrative administrativeadjustmentindicato
rename flagcrime newcrimeindicator

}

//Original Data Structure

//split month and year into two variables

split monthreportedtomshp, parse(-)

rename monthreportedtomshp1 year
label variable year "year reported to MSHP"
note year: Derived from splitting variable monthreportedtomshp
destring year, replace

rename monthreportedtomshp2 month
destring month, replace
label define month 1 "January" 2 "February" 3 "March" 4 "April" 5 "May" ///
	6 "June" 7 "July" 8 "August" 9 "September" 10 "October" 11 "November" ///
	12 "December"
label values month month
label variable month "month reported to MSHP"
note month: Derived from splitting variable monthreportedtomshp

drop monthreportedtomshp

//split date occured into date and time variables

split dateoccured, parse()
drop dateoccured

rename dateoccured1 dateoccurred
label variable dateoccured "date crime occurred"
note dateoccured: Derived from splitting original variable dateoccured

rename dateoccured2 timeoccurred
label variable timeoccurred "time crime occured"
note timeoccurred: Derived from splitting originaal variable dateoccured

//change newcrimeindicator to binary

rename newcrimeindicator newcrime
replace newcrime = "1" if newcrime == "Y"
replace newcrime = "0" if newcrime != "1"
destring newcrime, replace
label define newcrime 0 "No" 1 "Yes"
label values newcrime newcrime
label variable newcrime "New Crime Occurred"
note newcrime: Binary variable derived from newcrimeindicator

//change UnfoundedCrimeIndicator to binary
rename unfoundedcrimeindicator unfounded
replace unfounded = "1" if unfounded == "Y"
replace unfounded = "0" if unfounded != "1"
destring unfounded, replace
label define unfounded 0 "No" 1 "Yes"
label values unfounded unfounded
label variable unfounded "New info shows no crime occurred"
note unfounded: Binary variable derived from UnfoundedCrimeIndicator

//change AdministrativeAdjustmentIndicator to binary

rename administrativeadjustmentindicato adjustment
replace adjustment = "1" if adjustment == "Y"
replace adjustment = "0" if adjustment != "1"
destring adjustment, replace
label define adjustment 0 "No" 1 "Yes"
label values adjustment adjustment
label variable adjustment "Later changed in crime classification"
note adjustment: Binary variable derived from AdministrativeAdjustmentIndicator

//label address variables with explanations
label variable cadaddress "address given by 911 caller"
label variable cadstreet "street given by 911 caller"
label variable ileadsaddress "official address on police report"
label variable ileadsstreet "official street on police report"



//destring ileadsaddress
//first remove any leading zeroes
destring ileadsaddress, replace
//confirm numeric variable ileadsaddress

/* this code was written to remove leading zeroes. didn't need it
capture confirm numeric variable ileadsaddress 
if _rc == 111 { 
quietly count if substr(ileadsaddress, 1, 1) == "0"
while r(N) {
	replace ileadsaddress = substr(ileadsaddress, 2, .) if substr(ileadsaddress, 1, 1) == "0"
	count if substr(ileadsaddress, 1, 1) == "0"
	}
	replace ileadsaddress = "." if ileadsaddress == ""
} */





