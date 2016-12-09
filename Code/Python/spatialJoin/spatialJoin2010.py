# Name: spatialJoin2010.py
# Description: Join attributes of crime to tracts based on spatial relationships.
# Requirements: os module

# Import system modules
import arcpy
import os

# Set local variables
workspace = r"C:\Users\thbraswell\Desktop\BarriersCrime\Spatial\crime.gdb"
outWorkspace = r"C:\Users\thbraswell\Desktop\BarriersCrime\Spatial\crime.gdb"

# Want to join crime point data to census tracts
targetFeatures = os.path.join(workspace, "stl_tracts")
joinFeatures = os.path.join(workspace, "crime2010")

# Output will be the target features, tracts, with crime counts
outfc = os.path.join(outWorkspace, "tracts_crime2010")


#Run the Spatial Join tool, using the defaults for the join operation and join type
arcpy.SpatialJoin_analysis(targetFeatures, joinFeatures, outfc)
