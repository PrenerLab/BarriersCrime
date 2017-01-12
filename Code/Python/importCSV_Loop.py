# This file will loop over every crime .csv file, project their coordinates
# and export them as individual shapefiles.

# Import libraries
import glob
import arcpy
import os

# set working environment
arcpy.env.workspace = r"C:\Users\thbraswell\Documents\BarriersCrime\Full Data"

def derive_save_name(filename):
    filename = os.path.splitext(filename)[0] #grab filename without extension
    if (filename.startswith('stl_ucr_')): #ucr files
        ucr = filename.split('_')[-1] #ucr = ucr code number
        try:
            int(ucr) #verify ucr variable is an integer
        except ValueError:
            raise Exception('invalid filename' + filename)
        return 'ucr' + ucr #this will be the save name of each ucr output file from Arc
    elif (filename.startswith('stlcrime_')): #year files
        year = filename.split('_')[-1] #year = four digit year YYYY
        if len(year) != 4: #verify year has four digits
            raise Exception('invalid filename' + filename)
        try:
            int(year) #verify year is an integer
        except ValueError:
            raise Exception('invalid filename' + filename)
        return 'crime' + year #this will be the save name of each year output file from Arc
    else:
        raise Exception('invalid filename' + filename)

# Define pathway for the loop
base_directory = arcpy.env.workspace
glob_pattern = "stl_*.csv"

#Create counter for out layer in the loop
i = 0

for full_path in glob.glob(base_directory + "\\" + glob_pattern):
    try:
        #Counter Up
        i = i + 1

        in_Table = full_path
        x_coords = "xcoord"
        y_coords = "ycoord"
        out_Layer = 'stlCrime' + str(i)
        save_Path = r"C:\Users\thbraswell\Desktop\BarriersCrime\Spatial\crime.gdb"
        save_Name = derive_save_name(os.path.basename(full_path))

        # Set the spatial reference
        spRef = r"Coordinate Systems\Projected Coordinate Systems\State Plane\NAD 1983 (US Feet)\NAD 1983 StatePlane Missouri East FIPS 2401 (US Feet).prj"

        # Make the XY event layer...
        arcpy.MakeXYEventLayer_management(in_Table, x_coords, y_coords, out_Layer, spRef)

        # Print the total rows
        print(arcpy.GetCount_management(out_Layer))

        # Save to a layer file
        arcpy.FeatureClassToFeatureClass_conversion(out_Layer, save_Path, save_Name)

    except Exception as err:
        print(err.args[0])
