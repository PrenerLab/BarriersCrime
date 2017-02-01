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

rename dateoccured1 dateOccurred
label variable dateOccurred "date crime occurred"
note dateOccurred: Derived from splitting original variable dateoccured

rename dateoccured2 timeOccurred
label variable timeOccurred "time crime occurred"
note timeOccurred: Derived from splitting originaal variable dateoccured

//change newcrimeindicator to binary

rename newcrimeindicator newCrime
replace newCrime = "1" if newCrime == "Y"
replace newCrime = "0" if newCrime != "1"
destring newCrime, replace
label define newCrime 0 "No" 1 "Yes"
label values newCrime newCrime
label variable newCrime "New Crime Occurred"
note newCrime: Binary variable derived from newcrimeindicator

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

//rename location variables
rename locationname locationName
label variable locationName "location name"

rename locationcomment locationComment
label variable locationComment "location comment"


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

//===================================================================
//===================================================================

/*Generate a ucr variable. It has the corresponding UCR code for
each crime */

generate ucr = .
replace ucr = 1 if crime >= 10000 & crime <= 19999
replace ucr = 2 if crime >= 20000 & crime <= 29999
replace ucr = 3 if crime >= 30000 & crime <= 39999
replace ucr = 4 if crime >= 40000 & crime <= 49999
replace ucr = 5 if crime >= 50000 & crime <= 59999
replace ucr = 6 if crime >= 60000 & crime <= 69999
replace ucr = 7 if crime >= 70000 & crime <= 79999
replace ucr = 8 if crime >= 80000 & crime <= 89999
replace ucr = 9 if crime >= 90000 & crime <= 99999
replace ucr = 10 if crime >= 100000 & crime <= 109999
replace ucr = 11 if crime >= 110000 & crime <= 119999
replace ucr = 12 if crime >= 120000 & crime <= 129999
replace ucr = 13 if crime >= 130000 & crime <= 139999
replace ucr = 14 if crime >= 140000 & crime <= 149999
replace ucr = 15 if crime >= 150000 & crime <= 159999
replace ucr = 16 if crime >= 160000 & crime <= 169999
replace ucr = 17 if crime >= 170000 & crime <= 179999
replace ucr = 18 if crime >= 180000 & crime <= 189999
replace ucr = 19 if crime >= 190000 & crime <= 199999
replace ucr = 20 if crime >= 200000 & crime <= 209999
replace ucr = 21 if crime >= 210000 & crime <= 219999
replace ucr = 22 if crime >= 220000 & crime <= 229999
replace ucr = 23 if crime >= 230000 & crime <= 239999
replace ucr = 24 if crime >= 240000 & crime <= 249999
replace ucr = 25 if crime >= 250000 & crime <= 259999
replace ucr = 26 if crime >= 260000 & crime <= 269999

label define ucr 1 "Homicide" 2 "Sexual Assault" 3 "Robbery" ///
	4 "Aggravated Assault" 5 "Burglary" 6 "Larceny" 7 "Motor Vehicle Theft" ///
	8 "Arson" 9 "Other Assaults" 10 "Forgery and Counterfeiting" 11 "Frauds" ///
	12 "Embezzlement" 13 "Stolen Property" 14 "Criminal Damage" 15 "Weapons" ///
	16 "Commercialized Sex" 17 "Sex Offenses" 18 "Narcotics" 19 "Gambling" ///
	20 "Offenses Against The Family" 21 "Driving Under Influence" ///
	22 "Liquor Laws" 23 "Intoxication" 24 "Disorderly Conduct" ///
	25 "Vagrancy" 26 "Other Offense"

	label values ucr ucr
	label variable ucr "UCR crime code"
	note ucr: Extracted from Crime variable


//===================================================================
//===================================================================

//covert time occurred into integers
split timeOccurred, parse(:)
gen timeOccurred3 = timeOccurred1+timeOccurred2
destring timeOccurred3, replace
drop timeOccurred timeOccurred1 timeOccurred2
rename timeOccurred3 timeOccurred
label variable timeOccurred "Time Crime Occured"
note timeOccurred: Coded from orginal timeOccurred variable


//Convert dates into STATA dates
gen date2 = date(date, "MDY")
format date2 %td
rename date2 dateOccurred1

//generate new variables, parsing out date occurred
gen yearOccurred = year(dateOccurred1)
label variable yearOccurred "year crime occurred"
note yearOccurred: extracted from dateOccurred variable

gen monthOccurred = month(dateOccurred1)
label variable monthOccurred "month crime occurred"
note monthOccurred: extracted from dateOccurred variable

gen dayOccurred = day(dateOccurred1)
label variable dayOccurred "day crime occurred"
note dayOccurred: extracted from the dateOccurred variable

drop dateOccurred
rename dateOccurred1 dateOccurred

