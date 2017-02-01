// ==========================================================================

/*
This file will do some final variable edits to the police data.


This .do file is only compatable with OS X.
*/

// ==========================================================================

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

//rename and notate other variables
//rename dateoccurred1 dateoccurred
//label variable dateoccurred "Date Crime Occurred"
//note dateoccurred:Converted to STATA format from original dateoccurred var

//rename timeoccurred3 timeoccurred
//label variable timeoccurred "Time Crime Occured"
//note timeoccurred: Coded from orginal timeoccurred variable

label variable ucr_other_num "Last four digits of crime code"

label variable _source "Source document"
note _source: Automatically populated during the append process


//generate new variables, parsing out date occurred
gen year_occurred = year(dateoccurred)
label variable year_occurred "year crime occurred"
note year_occurred: extracted from dateoccurred variable

gen month_occurred = month(dateoccurred)
label variable month_occurred "month crime occurred"
note month_occurred: extracted from dateoccurred variable

gen day_occurred = day(dateoccurred)
label variable day_occurred "day crime occurred"
note day_occurred: extracted from the dateoccurred variable


//insample out crimes that occurred before 2008 (starting point of data)
generate insample = .
replace insample = 0 if year_occurred < 2008
replace insample = 1 if year_occurred >= 2008
label variable insample "0 if crime occurred before 2008"
note insample: 2008 is the starting point in the data


//final individual variable cleaning

rename dateoccurred date_occurred
rename timeoccurred time_occured
rename newcrime new_crime

label variable count "crime counts toward monthly crime total"
label variable crime "6 digit crime code"
drop crime_str //redundant string version of variable crime

rename locationname location_name
rename locationcomment location_comment
