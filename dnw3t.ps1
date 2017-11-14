# A script for downloading NOAA nnw3 data 

$date = Get-Date -Uformat "%Y%m%d"
#$dates = New-Object System.Collections.ArrayList
#echo $date[0]
#$date = $date - 1
#echo "after sub" + $date[0]

# Each run downloads weatherdata from 4 times a day (0, 06, 12, 18)
$hour_reading_stamps = New-Object System.Collections.ArrayList
$hour_reading_stamps.AddRange(("00", "06", "12", "18"))

# Construct url-paths for use in extraction
$data_root_path = "ftp://ftpprd.ncep.noaa.gov/pub/data/nccf/com/wave/prod/"
$data_sub_path = "multi_1." + $date + "/multi_1.nww3.t" + $hour_reading_stamps[1] + "z.grib2"
$full_path = $data_root_path + $data_sub_path

$WebClient = New-Object System.Net.WebClient
$a = (Get-Host).PrivateData

echo ""
echo "========== Fetching NWW3 data =========="
echo ""

For ($i = 0; $i -Lt 7; $i++){
    For ($y = 0; $y -Lt $hour_reading_stamps.Count; $y++){
        $time = $hour_reading_stamps[$y]

        $data_root_path = "ftp://ftpprd.ncep.noaa.gov/pub/data/nccf/com/wave/prod/"
        $data_sub_path = "multi_1." + ($date - $i) + "/multi_1.nww3.t" + $hour_reading_stamps[$y] + "z.grib2" ####
        $full_path = $data_root_path + $data_sub_path
        
        $dest_file = "multi." + ($date - $i) + "." + $hour_reading_stamps[$y]
        $w_data_folder_path = "C:\Users\pho\nww3grb\$dest_file.grb2"

        if(Test-Path $w_data_folder_path){
            $a.WarningBackgroundColor = "darkblue"
            $a.WarningForegroundColor = "yellow"
            Write-Warning "File already exists at: $w_data_folder_path"
            #echo "file already exists: $w_data_folder_path"
        }
        else{
            echo "Downloading NWW3 data file from adress: $full_path"
            try{
                $WebClient.DownloadFile($full_path, $w_data_folder_path)
            }
            catch{
                $a.WarningBackgroundColor = "red"
                $a.WarningForegroundColor = "white" 
                Write-Warning "(404) Not Found at: $full_path"
            }
        }
    }
}

echo $date[0]


echo ""
echo "========== Fetching SST data =========="
echo ""

For ($i = 0; $i -Lt 120; $i++){

    $d = (get-date).adddays(- $i) | get-date -UFormat "%Y%m%d"
    
    # 20171112120000-NCEI-L4_GHRSST-SSTblend-AVHRR_OI-GLOB-v02.0-fv02.0.nc

    $data_root_path2 = "https://www.ncei.noaa.gov/data/sea-surface-temperature-optimum-interpolation/access/"
    $data_sub_path2 = "" + ($d) + "120000-NCEI/0-fv02/" + ($d) + "120000-NCEI-L4_GHRSST-SSTblend-AVHRR_OI-GLOB-v02.0-fv02.0.nc" ####
    $full_path2 = $data_root_path2 + $data_sub_path2

    # echo "full path =======> $full_path2"
    
    $dest_file2 = "sstv2." + ($d)
    $w_data_folder_path2 = "C:\Users\pho\sstv2grb\$dest_file2.grib2"

    if(Test-Path $w_data_folder_path2){
        #echo "file already exists: $w_data_folder_path2"
        $a.WarningBackgroundColor = "darkblue"
        $a.WarningForegroundColor = "yellow"
        Write-Warning "File already exists at: $w_data_folder_path"
    }
    else{
        echo "Downloading SST data file from adress: $full_path2"
        try{
            $WebClient.DownloadFile($full_path2, $w_data_folder_path2)
        }
        catch{
            $a.WarningBackgroundColor = "red"
            $a.WarningForegroundColor = "white"
            Write-Warning "(404) Not Found at: $full_path2"
        }
        
    }
}