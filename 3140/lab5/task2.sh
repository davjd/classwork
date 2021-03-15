#!/bin/bash
# To enable execution permission: chmod +x task2.sh

# Create the file we'll use to save the dataset which we'll read in the python program.
if [ ! -f dataset.csv ]; then
    touch dataset.csv
    curl -s https://pkgstore.datahub.io/JohnSnowLabs/nycha-development-data-book/nycha-development-data-book-csv_csv/data/e2929502f21372719867baf979744b53/nycha-development-data-book-csv_csv.csv -o dataset.csv
fi


# Pass the --borough parameter to the python program and run it.
# Pass the parameter inside quotes, e.g. ./task2.sh "brooklyn"
# We use ask to replace the program output so that the Boroughs are correctly upper-cased.
if [ -z "$1" ]
   then
    python3 task1.py get-count dataset.csv | awk '{ gsub("STATEN ISLAND", "Staten Island") ; system( "echo "  $0) }' | awk '{ gsub("BROOKLYN", "Brooklyn") ; system( "echo "  $0) }' | awk '{ gsub("MANHATTAN", "Manhattan") ; system( "echo "  $0) }' | awk '{ gsub("QUEENS", "Queens") ; system( "echo "  $0) }' | awk '{ gsub("BRONX", "Bronx") ; system( "echo "  $0) }'
else
    python3 task1.py get-count dataset.csv --borough="$@" | awk '{ gsub("STATEN ISLAND", "Staten Island") ; system( "echo "  $0) }' | awk '{ gsub("BROOKLYN", "Brooklyn") ; system( "echo "  $0) }' | awk '{ gsub("MANHATTAN", "Manhattan") ; system( "echo "  $0) }' | awk '{ gsub("QUEENS", "Queens") ; system( "echo "  $0) }' | awk '{ gsub("BRONX", "Bronx") ; system( "echo "  $0) }'
fi