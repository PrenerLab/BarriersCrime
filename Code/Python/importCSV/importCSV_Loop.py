# This file will loop over every crime .xlsx file, project their coordinates
# and export them as individual shapefiles.

# Import libraries
import glob
import arcpy
import os

# set working environment
arcpy.env.workspace = r"C:\Users\thbraswell\Documents\BarriersCrime\Full Data"

def derive_save_name(filename):
    filename = os.path.splitext(filename)[0]
    if (filename.startswith('stl_ucr_')):
        ucr = filename.split('_')[-1]
        try:
            int(ucr)
        except ValueError:
            raise Exception('invalid filename' + filename)
        return 'ucr' + ucr
    elif (filename.startswith('stlcrime_')):
        year = filename.split('_')[-1]
        if len(year) != 4:
            raise Exception('invalid filename' + filename)
        try:
            int(year)
        except ValueError:
            raise Exception('invalid filename' + filename)
        return 'crime' + year
    else:
        raise Exception('invalid filename' + filename)

base_directory = arcpy.env.workspace
glob_pattern = "stl_*.csv"
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
