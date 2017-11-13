# A script for downloading NOAA nnw3 data 

$w_data_folder_path = "C:\Users\pho\nww3grb\testgrib.grib2"
$date = Get-Date -Uformat "%Y%m%d"
$dates = New-Object System.Collections.ArrayList
$dates = $date - 1

# Each run downloads weatherdata from 4 times a day (0, 06, 12, 18)
$hour_reading_stamps = New-Object System.Collections.ArrayList
$hour_reading_stamps.AddRange(("00", "06", "12", "18"))

# Construct url-paths for use in extraction
$data_root_path = "ftp://ftpprd.ncep.noaa.gov/pub/data/nccf/com/wave/prod/"
$data_sub_path = "multi_1." + $dates + "/multi_1.nww3.t" + $hour_reading_stamps[1] + "z.grib2"
$full_path = $data_root_path + $data_sub_path
echo "full path example: $full_path"

$run = 1
$WebClient = New-Object System.Net.WebClient

echo "========== Fetching NWW3 data =========="

For ($i = 0; $i -Lt 5; $i++){
    For ($y = 0; $y -Lt $hour_reading_stamps.Count; $y++){
        $time = $hour_reading_stamps[$y]

        $data_root_path = "ftp://ftpprd.ncep.noaa.gov/pub/data/nccf/com/wave/prod/"
        $data_sub_path = "multi_1." + ($dates - $i) + "/multi_1.nww3.t" + $hour_reading_stamps[$y] + "z.grib2" ####
        $full_path = $data_root_path + $data_sub_path
        
        $dest_file = "multi." + ($dates - $i) + "." + $hour_reading_stamps[$y]
        $w_data_folder_path = "C:\Users\pho\nww3grb\$dest_file.grb2"

        if(Test-Path $w_data_folder_path){
            echo "file already exists: $w_data_folder_path"
        }
        else{
            echo "Downloading grib2 file from adress: $full_path"
            $WebClient.DownloadFile($full_path, $w_data_folder_path)
        }
    }
}