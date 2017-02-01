//==============================================================================
/*
Filename: postGeocodeAppend.do
Created by: Taylor Braswell
Purpose: Append cleaned CAD geocoded data to the "betterData.csv" dataset.

subordinates:
postGeocodeClean.do
postGeocodeAppend.do
postCADGeocodeClean.do
postCADGeocodeAppend.do

*/
//==============================================================================
cd "/Users/thbraswell/Documents/Barriers/BarriersCrime/Code/Stata"

do postGeocodeClean.do //cleans geocoded ileads addresses
do postGeocodeAppend.do //appends matched ileads addresses to full dataset
do postCADGeocodeClean.do //cleans geocoded cad addresses
do postCADGeocodeAppend.do //appends matched cad addresses to full dataset
