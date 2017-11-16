counter=1

data_root_path="https://www.ncei.noaa.gov/data/sea-surface-temperature-optimum-interpolation/access/"

while [ $counter -le 10 ]
do
    declare dd=$( date --date="-$counter days" +'%Y%m%d')
    # cho $dd'1200'
    data_sub_path=$data_root_path$dd"120000-NCEI/0-fv02/"$dd"120000-NCEI-L4_GHRSST-SSTblend-AVHRR_OI-GLOB-v02.0-fv02.0.nc"
    echo $data_sub_path
    wget $data_sub_path
    ((counter++))
done

# wget https://www.ncei.noaa.gov/data/sea-surface-temperature-optimum-interpolation/access/20170401120000-NCEI/0-fv02/2017041120000-NCEI-L4_GHRSSTblend-AVHRR_OI-GLOB-v02.0-fv02.0.nc
# https://www.ncei.noaa.gov/data/sea-surface-temperature-optimum-interpolation/access/20171106.120000NCEI/0-fv02/20171106120000-NCEI-L4_GHRSST-SSTblend-AVHRR_OI-GLOB-v02.0-fv02.0.nc
echo All done

# 
# https://www.ncei.noaa.gov/data/sea-surface-temperature-optimum-interpolation/access/20171114.120000NCEI/0-fv02/20171114120000-NCEI-L4_GHRSST-SSTblend-AVHRR_OI-GLOB-v02.0-fv02.0.nc

# https://www.ncei.noaa.gov/data/sea-surface-temperature-optimum-interpolation/access/20170401120000-NCEI/0-fv02/20170401120000-NCEI-L4_GHRSST-SSTblend-AVHRR_OI-GLOB-v02.0-fv02.0.nc