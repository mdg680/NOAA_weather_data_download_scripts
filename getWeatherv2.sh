
counterSST=1
counterMulti=1

declare -a timestamps=("00" "06" "12" "18")

cd /home/pho/Source/Repos/NOAA/NOAA_weather_data_download_scripts/data_files

# Get SST data

data_root_path="https://www.ncei.noaa.gov/data/sea-surface-temperature-optimum-interpolation/access/"

while [ $counterSST -le 120 ]
do
    declare dd=$( date --date="-$counterSST days" +'%Y%m%d')
    data_sub_path=$data_root_path$dd"120000-NCEI/0-fv02/"$dd"120000-NCEI-L4_GHRSST-SSTblend-AVHRR_OI-GLOB-v02.0-fv02.0.nc"
    dest_file_name="sst."$dd".grib2"
    wget -nc -O $dest_file_name $data_sub_path
    ((counterSST++))
done

# Get NWW3 Data

data_root_path="ftp://ftpprd.ncep.noaa.gov/pub/data/nccf/com/wave/prod/"

while [ $counterMulti -le 8 ]
do
    declare dd=$( date --date="-$counterMulti days" +'%Y%m%d')
    for i in "${timestamps[@]}"
    do
	data_sub_path=$data_root_path"multi_1."$dd"/multi_1.nww3.t"$i"z.grib2"
	dest_file_name="multi."$dd"."$i".grb2"
	wget -nc -O $dest_file_name $data_sub_path

    done
    ((counterMulti++))
done
