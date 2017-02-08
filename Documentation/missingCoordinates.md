# Steps for Handling Missing Crime Data 

Some of the crime data are missing X Y coordinates. The following is a step by step process for dealing with such data. This document is primarily concerned with observations that have geocode-able addresses. For instructions on how to handle location and intersection data, see *locationInstructions.md* and *intersectionInstructions.md*, respectively.

1. The initial data cleaning/merge process creates a CSV file called "badData.csv". Execute "badData.do" to derive five CSV files:
	- yesiLeads.csv - observations with a valid ileads address and street name. 
	- yesCAD.csv - observations without a valid ileads address but a valid CAD address. 
	- intersection.csv - a list of observations for which an intersection is provided instead of an address.
	- location.csv - a list of observations with no valid address or intersection, but some location information is provided.
	- noSpatial.csv - observations with no spatial data. 
	
2. Pull yesiLeads.csv and yesCAD.csv into ArcGIS and geocode the addresses.

3. Using QGIS, export the geocoded addresses into csv files named *ileads_geocode.csv* and *cad_geocode.csv*.

4. Execute postGeocodeMaster.do. This will clean the data, append the properly geocoded addresses back into the dataset (into a file called betterData.csv), and separate out the observations that did not geocode into *ileadsUnmatched.csv* and *cadUnmatched.csv* for manual review.