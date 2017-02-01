//==============================================================================
/*
Filename: postGeocodeAppend.do
Created by: Taylor Braswell
Purpose: Append cleaned geocoded data to the "goodData.csv" dataset, saving it
as "betterData.csv".



*/
//==============================================================================
clear
set more off

//import append file and save it as data
import delimited using "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/ileadsMatched.csv"

save "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/ileadsMatched.dta"

clear

//import good data file (foundational file)
import delimited "/Users/`c(username)'/Documents/Barriers/BarriersCrime/Working Data/goodData.csv"

//append matched addresses to good data
append using "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/ileadsMatched.dta"

//save as better data
export delimited "/Users/`c(username)'/Documents/Barriers/BarriersCrime/Working Data/betterData.csv"

//remove dta file
shell rm -R "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/ileadsMatched.dta"
