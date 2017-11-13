import numpy as np
import netCDF4

mydate = '20171110'
url='http://nomads.ncep.noaa.gov:9090/dods/wave/nww3/nww3'+ \
    mydate+'/nww3'+mydate+'_00z'

file = netCDF4.Dataset(url)
lat  = file.variables['lat'][:]
lon  = file.variables['lon'][:]
data = file.variables['dirpwsfc'][1,:,:]
file.close()
print(lat)
print(lon)
#print(data)

for x in data:
    print(x)