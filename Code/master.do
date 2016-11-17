//=============================================================================
/* This file runs a stack of do files that imports raw STL police data,
merges into into one dataset, and then saves it as multiple excel spreadsheets -
each associated with a different year of crime or UCR code.

subordinates:
crimeMerge.do
initialClean.do
destringcheck.do
extracleaning.do
export_excel.do
Police data CSVs January 2008 - December 2015

Author: Taylor
*/
//=============================================================================

//Change to code directory
cd "/Users/`c(username)'/Documents/streetBarriers/BarriersCrime/Code"

//do file stack
do crimeMerge.do
  //does initialClean.do
 
 
//WARNING: Executing export_excel.do may take multiple minutes 
do "/Users/`c(username)'/Documents/streetBarriers/BarriersCrime/Code/export_excel.do"
