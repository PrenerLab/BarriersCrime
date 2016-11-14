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
updated - 15 Feb 2016

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

cd "/Users/tbraswell/Desktop/Full Data"

use stlcrime.dta

cd "/Users/tbraswell/Desktop/Full Data/excel" //where files will be saved


// ==========================================================================

//Create year files

// ==========================================================================

//2008

drop if year != 2008
export excel using stlcrime_2008.xlsx, sheet("2008") firstrow(variables) ///
	nolabel replace
clear

//2009
use stlcrime.dta
drop if year != 2009
export excel using stlcrime_2009.xlsx, sheet("2009") firstrow(variables) ///
	nolabel replace
clear

//2010
use stlcrime.dta
drop if year != 2010
export excel using stlcrime_2010.xlsx, sheet("2010") firstrow(variables) ///
	nolabel replace
clear

//2011
use stlcrime.dta
drop if year != 2011
export excel using stlcrime_2011.xlsx, sheet("2011") firstrow(variables) ///
	nolabel replace
clear

//2012
use stlcrime.dta
drop if year != 2012
export excel using stlcrime_2012.xlsx, sheet("2012") firstrow(variables) ///
	nolabel replace
clear

//2013
use stlcrime.dta
drop if year != 2013
export excel using stlcrime_2013.xlsx, sheet("2013") firstrow(variables) ///
	nolabel replace
clear

//2014
use stlcrime.dta
drop if year != 2014
export excel using stlcrime_2014.xlsx, sheet("2014") firstrow(variables) ///
	nolabel replace
clear

//2015
use stlcrime.dta
drop if year != 2015
export excel using stlcrime_2015.xlsx, sheet("2015") firstrow(variables) ///
	nolabel replace
clear

// ==========================================================================

//Create crime code files

// ==========================================================================

//Homicide (01)
use stlcrime.dta
drop if ucr != 1
export excel using stlcrime_ucr_01.xlsx, sheet("Homicide") ///
	firstrow(variables) nolabel replace
clear

//Sexual Assault (02)
use stlcrime.dta
drop if ucr != 2
export excel using stlcrime_ucr_02.xlsx, sheet("Sexual Assault") ///
	firstrow(variables) nolabel replace
clear

//Robbery (03)
use stlcrime.dta
drop if ucr != 3
export excel using stlcrime_ucr_03.xlsx, sheet("Robbery") ///
	firstrow(variables) nolabel replace
clear


//Aggravated Assault (04)
use stlcrime.dta
drop if ucr != 4
export excel using stlcrime_ucr_04.xlsx, sheet("Aggravated Assault") ///
	firstrow(variables) nolabel replace
clear

//Burglary (05)
use stlcrime.dta
drop if ucr != 5
export excel using stlcrime_ucr_05.xlsx, sheet("Burglary") ///
	firstrow(variables) nolabel replace
clear

//Larceny (06)
use stlcrime.dta
drop if ucr != 6
export excel using stlcrime_ucr_06.xlsx, sheet("Larceny") ///
	firstrow(variables) nolabel replace
clear

//Motor Vehicle Theft (07)
use stlcrime.dta
drop if ucr != 7
export excel using stlcrime_ucr_07.xlsx, sheet("Motor Vehicle Theft") ///
	firstrow(variables) nolabel replace
clear

//Arson (08)
use stlcrime.dta
drop if ucr != 8
export excel using stlcrime_ucr_08.xlsx, sheet("Arson") ///
	firstrow(variables) nolabel replace
clear

//Other Assaults (09)
use stlcrime.dta
drop if ucr != 9
export excel using stlcrime_ucr_09.xlsx, sheet("Other Assaults") ///
	firstrow(variables) nolabel replace
clear

//Forgery and Counterfeiting (10)
use stlcrime.dta
drop if ucr != 10
export excel using stlcrime_ucr_10.xlsx, sheet("Forgery and Counterfeiting") ///
	firstrow(variables) nolabel replace
clear

//Frauds (11)
use stlcrime.dta
drop if ucr != 11
export excel using stlcrime_ucr_11.xlsx, sheet("Frauds") ///
	firstrow(variables) nolabel replace
clear

//Embezzlement (12)
use stlcrime.dta
drop if ucr != 12
export excel using stlcrime_ucr_12.xlsx, sheet("Embezzlement") ///
	firstrow(variables) nolabel replace
clear

//Stolen Property (13)
use stlcrime.dta
drop if ucr != 13
export excel using stlcrime_ucr_13.xlsx, sheet("Stolen Property") ///
	firstrow(variables) nolabel replace
clear

//Criminal Damage (14)
use stlcrime.dta
drop if ucr != 14
export excel using stlcrime_ucr_14.xlsx, sheet("Criminal Damage") ///
	firstrow(variables) nolabel replace
clear

//Weapons (15)
use stlcrime.dta
drop if ucr != 15
export excel using stlcrime_ucr_15.xlsx, sheet("Weapons") ///
	firstrow(variables) nolabel replace
clear

//Commercialized Sex (16)
use stlcrime.dta
drop if ucr != 16
export excel using stlcrime_ucr_16.xlsx, sheet("Commercialized Sex") ///
	firstrow(variables) nolabel replace
clear

//Sex Offenses (17)
use stlcrime.dta
drop if ucr != 17
export excel using stlcrime_ucr_17.xlsx, sheet("Sex Offenses") ///
	firstrow(variables) nolabel replace
clear

//Narcotics (18)
use stlcrime.dta
drop if ucr != 18
export excel using stlcrime_ucr_18.xlsx, sheet("Narcotics") ///
	firstrow(variables) nolabel replace
clear

//Gambling (19)
use stlcrime.dta
drop if ucr != 19
export excel using stlcrime_ucr_19.xlsx, sheet("Gambling") ///
	firstrow(variables) nolabel replace
clear

//Offenses Against the Family (20)
use stlcrime.dta
drop if ucr != 20
export excel using stlcrime_ucr_20.xlsx, sheet("Offenses Against the Family") ///
	firstrow(variables) nolabel replace
clear

//Driving Under the Influence (21)
use stlcrime.dta
drop if ucr != 21
export excel using stlcrime_ucr_21.xlsx, sheet("DUI") ///
	firstrow(variables) nolabel replace
clear

//Liquor Laws (22)
use stlcrime.dta
drop if ucr != 22
export excel using stlcrime_ucr_22.xlsx, sheet("Liquor Laws") ///
	firstrow(variables) nolabel replace
clear

//Intoxication (23)
use stlcrime.dta
drop if ucr != 23
export excel using stlcrime_ucr_23.xlsx, sheet("Intoxication") ///
	firstrow(variables) nolabel replace
clear

//Disorderly Conduct (24)
use stlcrime.dta
drop if ucr != 24
export excel using stlcrime_ucr_24.xlsx, sheet("Disorderly Conduct") ///
	firstrow(variables) nolabel replace
clear

//Vagrancy (25)
use stlcrime.dta
drop if ucr != 25
export excel using stlcrime_ucr_25.xlsx, sheet("Vagrancy") ///
	firstrow(variables) nolabel replace
clear

//Other Offenses (26)
use stlcrime.dta
drop if ucr != 26
export excel using stlcrime_ucr_26.xlsx, sheet("Other Offenses") ///
	firstrow(variables) nolabel replace
clear
