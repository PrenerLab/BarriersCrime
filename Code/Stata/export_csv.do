// ==========================================================================

/*

This .do file generates excel files for every year of the police data and
for each ucr code.
*/

// ==========================================================================


// standard opening options

version 13
log close _all
graph drop _all
clear all
set more off
set linesize 80


// ==========================================================================

/*
file name - export_excel.do
project name -	Street Barriers - STL Crime Data

purpose - Export components of STL crime data into individual XLS files

created - 15 Feb 2016
updated - 17 Nov 2016

author - Taylor Braswell
*/

// ==========================================================================

/*
full description -
Generates a total of 33 xls files
	a. One for each of the seven years in the dataset (2008-2015)
	b. One for each of the 26 crime codes
*/

/*
updates -
none
*/

// ==========================================================================
// ==========================================================================

/*
superordinates  -
stlcrime.dta
*/

/*
subordinates -
none
*/

// ==========================================================================
// ==========================================================================

cd "/Users/thbraswell/Documents/Barriers/BarriersCrime/Full Data"

use stlcrime.dta


//Create good and bad data files
//Good Data
use stlcrime.dta
keep if xcoord != 0 & ycoord != 0
export delimited using goodData.csv, replace nolabel
clear

//Bad Data
use stlcrime.dta
keep if xcoord == 0 & ycoord == 0
export delimited using badData.csv, replace nolabel
clear

/* Commenting out this part until worked through geocoding issues.
It may become its own separate stata process.
// ==========================================================================

//Create year files

// ==========================================================================

//2008

drop if year != 2008
export delimited using stlcrime_2008.csv, replace
clear

//2009
use stlcrime.dta
drop if year != 2009
export delimited using stlcrime_2009.csv, replace
clear

//2010
use stlcrime.dta
drop if year != 2010
export delimited using stlcrime_2010.csv, replace
clear

//2011
use stlcrime.dta
drop if year != 2011
export delimited using stlcrime_2011.csv, replace
clear

//2012
use stlcrime.dta
drop if year != 2012
export delimited using stlcrime_2012.csv, replace
clear

//2013
use stlcrime.dta
drop if year != 2013
export delimited using stlcrime_2013.csv, replace
clear

//2014
use stlcrime.dta
drop if year != 2014
export delimited using stlcrime_2014.csv, replace

clear

//2015
use stlcrime.dta
drop if year != 2015
export delimited using stlcrime_2015.csv, replace

clear

// ==========================================================================

//Create crime code files

// ==========================================================================

//Homicide (01)
use stlcrime.dta
drop if ucr != 1
export delimited using stl_ucr_01.csv, replace
clear

//Sexual Assault (02)
use stlcrime.dta
drop if ucr != 2
export delimited using stl_ucr_02.csv, replace
clear

//Robbery (03)
use stlcrime.dta
drop if ucr != 3
export delimited using stl_ucr_03.csv, replace
clear


//Aggravated Assault (04)
use stlcrime.dta
drop if ucr != 4
export delimited using stl_ucr_04.csv, replace
clear

//Burglary (05)
use stlcrime.dta
drop if ucr != 5
export delimited using stl_ucr_05.csv, replace
clear

//Larceny (06)
use stlcrime.dta
drop if ucr != 6
export delimited using stl_ucr_06.csv, replace
clear

//Motor Vehicle Theft (07)
use stlcrime.dta
drop if ucr != 7
export delimited using stl_ucr_07.csv, replace
clear

//Arson (08)
use stlcrime.dta
drop if ucr != 8
export delimited using stl_ucr_08.csv, replace
clear

//Other Assaults (09)
use stlcrime.dta
drop if ucr != 9
export delimited using stl_ucr_09.csv, replace
clear

//Forgery and Counterfeiting (10)
use stlcrime.dta
drop if ucr != 10
export delimited using stl_ucr_10.csv, replace
clear

//Frauds (11)
use stlcrime.dta
drop if ucr != 11
export delimited using stl_ucr_11.csv, replace
clear

//Embezzlement (12)
use stlcrime.dta
drop if ucr != 12
export delimited using stl_ucr_12.csv, replace
clear

//Stolen Property (13)
use stlcrime.dta
drop if ucr != 13
export delimited using stl_ucr_13.csv, replace
clear

//Criminal Damage (14)
use stlcrime.dta
drop if ucr != 14
export delimited using stl_ucr_14.csv, replace
clear

//Weapons (15)
use stlcrime.dta
drop if ucr != 15
export delimited using stl_ucr_15.csv, replace
clear

//Commercialized Sex (16)
use stlcrime.dta
drop if ucr != 16
export delimited using stl_ucr_16.csv, replace
clear

//Sex Offenses (17)
use stlcrime.dta
drop if ucr != 17
export delimited using stl_ucr_17.csv, replace
clear

//Narcotics (18)
use stlcrime.dta
drop if ucr != 18
export delimited using stl_ucr_18.csv, replace
clear

//Gambling (19)
use stlcrime.dta
drop if ucr != 19
export delimited using stl_ucr_19.csv, replace
clear

//Offenses Against the Family (20)
use stlcrime.dta
drop if ucr != 20
export delimited using stl_ucr_20.csv, replace
clear

//Driving Under the Influence (21)
use stlcrime.dta
drop if ucr != 21
export delimited using stl_ucr_21.csv, replace
clear

//Liquor Laws (22)
use stlcrime.dta
drop if ucr != 22
export delimited using stl_ucr_22.csv, replace
clear

//Intoxication (23)
use stlcrime.dta
drop if ucr != 23
export delimited using stl_ucr_23.csv, replace
clear

//Disorderly Conduct (24)
use stlcrime.dta
drop if ucr != 24
export delimited using stl_ucr_24.csv, replace
clear

//Vagrancy (25)
use stlcrime.dta
drop if ucr != 25
export delimited using stl_ucr_25.csv, replace
clear

//Other Offenses (26)
use stlcrime.dta
drop if ucr != 26
export delimited using stl_ucr_26.csv, replace
clear


*/
//=============================================================================
//remove unneeded directory

shell rm -R "/Users/thbraswell/Documents/Barriers/BarriersCrime/Clean Data"
