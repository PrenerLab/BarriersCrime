# Name: spatialJoin01.py
# Description: Join attributes of crime to tracts based on spatial relationships.
# Requirements: os module

# Import system modules
import glob
import arcpy
import os

# Set local variables
workspace = r"C:\Users\thbraswell\Desktop\BarriersCrime\Spatial\crime.gdb"
outWorkspace = r"C:\Users\thbraswell\Desktop\BarriersCrime\Spatial\crime.gdb"

def derive_save_name(filename):
    filename = os.path.splitext(filename)[0] #grab filename without extension
    if (filename.startswith('ucr')): #ucr files
        return filename
    elif (filename.startswith('crime')): #year files
        return filename
    else:
        raise Exception('invalid filename' + filename)

# Define pathway for the loops
base_directory = arcpy.env.workspace
glob_ucr_pattern = "ucr*"
glob_year_pattern = "crime*"

# Loop for UCR feature classes
for full_path in glob.glob(base_directory + "\\" + glob_ucr_pattern):
    try:
    # Store derive_save_name output into a variable
    save_Name = derive_save_name(os.path.basename(full_path))

    # Want to join crime point data to census tracts
    targetFeatures = os.path.join(workspace, "stl_tracts")
    joinFeatures = os.path.join(workspace, save_Name)

    # Output will be the target features, tracts, with crime counts
    outfc = os.path.join(outWorkspace, 'tracts_' + save_Name)

    #Run the Spatial Join tool, using the defaults for the join operation and join type
    arcpy.SpatialJoin_analysis(targetFeatures, joinFeatures, outfc)

    except Exception as err:
        print(err.args[0])


# Loop for year feature classes
for full_path in glob.glob(base_directory + "\\" + glob_year_pattern):
    try:
    # Store derive_save_name output into a variable
    save_Name = derive_save_name(os.path.basename(full_path))

    # Want to join crime point data to census tracts
    targetFeatures = os.path.join(workspace, "stl_tracts")
    joinFeatures = os.path.join(workspace, save_Name)

    # Output will be the target features, tracts, with crime counts
    outfc = os.path.join(outWorkspace, 'tracts_' + save_Name)

    #Run the Spatial Join tool, using the defaults for the join operation and join type
    arcpy.SpatialJoin_analysis(targetFeatures, joinFeatures, outfc)

    except Exception as err:
        print(err.args[0])
