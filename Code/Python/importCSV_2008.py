# This file will loop over every crime .xlsx file, project their coordinates
# and export them as individual shapefiles.

# Import arcpy
import arcpy
import os

# set working environment
arcpy.env.workspace = r"C:\Users\thbraswell\Desktop\BarriersCrime\Full Data"

try:
    # Set the local objects
    in_Table = r"stlcrime_2008.csv"
    x_coords = "xcoord"
    y_coords = "ycoord"
    out_Layer = "stlCrime2008_layer"
    save_Path = r"C:\Users\thbraswell\Desktop\BarriersCrime\Spatial\crime.gdb"
    save_Name = "crime2008"

    # Set the spatial reference
    spRef = r"Coordinate Systems\Projected Coordinate Systems\State Plane\NAD 1983 (Meters)\NAD 1983 StatePlane Missouri East FIPS 2401 (Meters).prj"

    # Make the XY event layer...
    arcpy.MakeXYEventLayer_management(in_Table, x_coords, y_coords, out_Layer, spRef)

    # Print the total rows
    print(arcpy.GetCount_management(out_Layer))

    # Save to a layer file
    arcpy.FeatureClassToFeatureClass_conversion(out_Layer, save_Path, save_Name)

except Exception as err:
    print(err.args[0])
