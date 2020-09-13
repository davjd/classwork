#!/bin/bash

# To enable execution permission: chmod +x q3.sh
# Read api key from file (put your API key in that file first).
value=`cat nasa_api_key.txt`
# Submit get request to InSight Mar API endpoint.
# NASA’s InSight Mars lander takes continuous weather measurements (temperature, wind, pressure) on the surface of Mars at Elysium Planitia, a flat, smooth plain near Mars’ equator. Summaries of these data are available at https://mars.nasa.gov/insight/weather/.
url="https://api.nasa.gov/insight_weather/?api_key=${value}&feedtype=json&ver=1.0"
curl "$url"