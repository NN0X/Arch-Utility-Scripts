#!/bin/bash

# load url from weather_source file
url=$(cat /home/nox/Scripts/.weather_source)

last=$(cat /home/nox/Scripts/.weather_last) # this file has only one line with the timestamp
now=$(date +%s)
if [ $((now - last)) -gt 600 ]; then
    data=$(curl -s $url)
    echo $now > /home/nox/Scripts/.weather_last
    echo $data > /home/nox/Scripts/.weather_data
else
    data=$(cat /home/nox/Scripts/.weather_data)
fi

temperature=$(echo $data | jq -r '.current.temperature_2m')
humidity=$(echo $data | jq -r '.current.relative_humidity_2m')
apparent_temperature=$(echo $data | jq -r '.current.apparent_temperature')
is_day=$(echo $data | jq -r '.current.is_day')
precipitation=$(echo $data | jq -r '.current.precipitation')
rain=$(echo $data | jq -r '.current.rain')
showers=$(echo $data | jq -r '.current.showers')
snowfall=$(echo $data | jq -r '.current.snowfall')
weather_code=$(echo $data | jq -r '.current.weather_code')
cloud_cover=$(echo $data | jq -r '.current.cloud_cover')
pressure_msl=$(echo $data | jq -r '.current.pressure_msl')
surface_pressure=$(echo $data | jq -r '.current.surface_pressure')
wind_speed_10m=$(echo $data | jq -r '.current.wind_speed_10m')
wind_direction_10m=$(echo $data | jq -r '.current.wind_direction_10m')
wind_gusts_10m=$(echo $data | jq -r '.current.wind_gusts_10m')

#echo "Temperature: $temperature"
#echo "Humidity: $humidity"
#echo "Apparent temperature: $apparent_temperature"
#echo "Is day: $is_day"
#echo "Precipitation: $precipitation"
#echo "Rain: $rain"
#echo "Showers: $showers"
#echo "Snowfall: $snowfall"
#echo "Weather code: $weather_code"
#echo "Cloud cover: $cloud_cover"
#echo "Pressure msl: $pressure_msl"
#echo "Surface pressure: $surface_pressure"
#echo "Wind speed 10m: $wind_speed_10m"
#echo "Wind direction 10m: $wind_direction_10m"

# weather codes - 
# 0: Clear sky
# 1,2,3: Few clouds
# 45,48: Fog
# 51,53,55: Drizzle
# 56,57: Freezing drizzle
# 61,63,65: Rain
# 66,67: Freezing rain
# 71,73,75: Snow
# 77: Snow grains
# 80,81,82: Showers
# 85,86: Snow showers
# 95,96,99: Thunderstorm
# Other: Clear sky

# 0: Night 1: Day

clear_sky_day="\uf185"
clear_sky_night="\uf186"
few_clouds_day="\ueef0"
few_clouds_night="\ueeef"
fog_day="\ue303"
fog_night="\ue346"
drizzle_day="\uef1e"
drizzle_night="\uef1b"
freezing_drizzle_day="\ue306"
freezing_drizzle_night="\ue323"
rain_day="\ue308"
rain_night="\ue325"
freezing_rain_day="\ue307"
freezing_rain_night="\ue324"
snow_day="\ue30a"
snow_night="\ue327"
snow_grains_day="\ue30a"
snow_grains_night="\ue327"
showers_day="\ue309"
showers_night="\ue326"
snow_showers_day="\ue35f"
snow_showers_night="\ue361"
thunderstorm_day="\ue30f"
thunderstorm_night="\ue32a"

temperature_hot="\uf2c7"
temp_treshold_hot=30
temperature_medium="\uf2c9"
temp_treshold_medium=20
temperature_cold="\uf2ca"
temp_treshold_cold=10
temperature_freezing="\uf2cb"

wind_no="\uf4aa"
wind_slow="\uef16"
wind_treshold_slow=5
wind_medium="\ue34b"
wind_treshold_medium=10
wind_fast="\ue31e"
wind_treshold_fast=15

weather_icon=""
temperature_icon=""
humidity_icon="\ue373"
pressure_icon="\ue372"
wind_icon=""

# set weather icon
if [ $weather_code -eq 0 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$clear_sky_day
	else
		weather_icon=$clear_sky_night
	fi
elif [ $weather_code -eq 1 ] || [ $weather_code -eq 2 ] || [ $weather_code -eq 3 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$few_clouds_day
	else
		weather_icon=$few_clouds_night
	fi
elif [ $weather_code -eq 45 ] || [ $weather_code -eq 48 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$fog_day
	else
		weather_icon=$fog_night
	fi
elif [ $weather_code -eq 51 ] || [ $weather_code -eq 53 ] || [ $weather_code -eq 55 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$drizzle_day
	else
		weather_icon=$drizzle_night
	fi
elif [ $weather_code -eq 56 ] || [ $weather_code -eq 57 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$freezing_drizzle_day
	else
		weather_icon=$freezing_drizzle_night
	fi
elif [ $weather_code -eq 61 ] || [ $weather_code -eq 63 ] || [ $weather_code -eq 65 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$rain_day
	else
		weather_icon=$rain_night
	fi
elif [ $weather_code -eq 66 ] || [ $weather_code -eq 67 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$freezing_rain_day
	else
		weather_icon=$freezing_rain_night
	fi
elif [ $weather_code -eq 71 ] || [ $weather_code -eq 73 ] || [ $weather_code -eq 75 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$snow_day
	else
		weather_icon=$snow_night
	fi
elif [ $weather_code -eq 77 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$snow_grains_day
	else
		weather_icon=$snow_grains_night
	fi
elif [ $weather_code -eq 80 ] || [ $weather_code -eq 81 ] || [ $weather_code -eq 82 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$showers_day
	else
		weather_icon=$showers_night
	fi
elif [ $weather_code -eq 85 ] || [ $weather_code -eq 86 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$snow_showers_day
	else
		weather_icon=$snow_showers_night
	fi
elif [ $weather_code -eq 95 ] || [ $weather_code -eq 96 ] || [ $weather_code -eq 99 ]; then
	if [ $is_day -eq 1 ]; then
		weather_icon=$thunderstorm_day
	else
		weather_icon=$thunderstorm_night
	fi
else
	if [ $is_day -eq 1 ]; then
		weather_icon=$clear_sky_day
	else
		weather_icon=$clear_sky_night
	fi
fi

# set temperature icon
temperature_integer=${temperature%.*}

if [ $temperature_integer -lt $temp_treshold_cold ]; then
	temperature_icon=$temperature_freezing
elif [ $temperature_integer -lt $temp_treshold_medium ]; then
	temperature_icon=$temperature_cold
elif [ $temperature_integer -lt $temp_treshold_hot ]; then
	temperature_icon=$temperature_medium
else
	temperature_icon=$temperature_hot
fi

# set wind icon
wind_speed_integer=${wind_speed_10m%.*}
if [ $wind_speed_integer -lt $wind_treshold_slow ]; then
	wind_icon=$wind_no
elif [ $wind_speed_integer -lt $wind_treshold_medium ]; then
	wind_icon=$wind_slow
elif [ $wind_speed_integer -lt $wind_treshold_fast ]; then
	wind_icon=$wind_medium
else
	wind_icon=$wind_fast
fi

# colors
back_color="^b#0c0838^" # light black
front_color="^c#f5ec6e^" # light white
if [ $is_day -eq 1 ]; then
	back_color="^b#e3e3e3^" # light white
	front_color="^c#0c0838^" # light black
fi

weather_icon="^c#f2a516^$weather_icon$front_color"

# weather icon temperature icon temperature humidity icon humidity pressure icon pressure wind icon
printf "$back_color $weather_icon  $temperature_icon $temperature  $humidity_icon $humidity %%  $pressure_icon $pressure_msl hPa  $wind_icon "
