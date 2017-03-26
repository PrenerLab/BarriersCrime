## Methods for Barriers

### Data
1. St. Louis City Police Data
	- Cleaned Using Stata
	- Imported into ArcGIS
	
2. Barriers sourced from Waldron Paper
	- Compiled into spreadsheet
	- Confirmed existence through Google Maps
	- Geocoded into ArcGIS
	
3. ACS 2015 5-year estimates
	- Poverty and Race
	
### Methods
1. Project barriers and crimes into NAD 1983 StatePlane Missouri East (Meters)

2. Interpolate census data from census tracts into Wards, Neighborhoods, and 1000-meter grids (Wards and Neighborhood shapefiles pulled from STL City data website).

3. Spatial join to get a count of barriers and crimes per aerial unit for wards, neighborhoods, and 1000-meter grids. 

4. Correlation between barriers, violent crimes (ucr 1-4), part one crimes (ucr 1-8), and all crime. 
	
