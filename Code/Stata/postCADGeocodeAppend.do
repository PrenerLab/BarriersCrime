//==============================================================================
/*
Filename: postGeocodeAppend.do
Created by: Taylor Braswell
Purpose: Append cleaned CAD geocoded data to the "betterData.csv" dataset.



*/
//==============================================================================
clear
set more off

//import append file and save it as data
import delimited using "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/cadMatched.csv"

save "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/cadMatched.dta"

clear

//import better data file (foundational file)
import delimited "/Users/`c(username)'/Documents/Barriers/BarriersCrime/Working Data/betterData.csv"

//append matched addresses to good data
append using "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/cadMatched.dta"

//save as better data
export delimited "/Users/`c(username)'/Documents/Barriers/BarriersCrime/Working Data/betterData.csv", replace

//remove dta file
shell rm -R "/Users/thbraswell/Documents/Barriers/BarriersCrime/Working Data/cadMatched.dta"
