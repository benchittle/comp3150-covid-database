#!/bin/bash

# DESCRIPTION: Generates a plot using user specified data from an SQL*PLUS 
#   database. The database must be populated before using this script. Table
#   and column names must also be the same as given by the scripts in this
#   repository.
# REQUIRES: bash, SQL*PLUS, gnuplot

out_query=".query.sql"
out_data=".queryout.data"

tables=(
    "CasesByProvince"
    "IcuByHealthRegion"
    "VaccinationByUnitAndAge"
    "CasesByAge"
)
declare -A cols=(
    ["casesbyprovince"]=" reportedDate confirmedPositive resolved deaths totalCases hospitalizedPatients icuPatients icuPatientsPositive icuPatientsNegative icuOnVentilator "
    ["icubyhealthregion"]=" reportedDate icuCurrent icuCurrentVented hospitalizations "
    ["vaccinationbyunitandage"]=" reportedDate firstDose secondDose thirdDose "
    ["casesbyage"]=" reportedDate percentPositive "
)

# Prompt the user for the table to use.
echo -en "\ec"
echo "This script will create custom plots of data from the database using generated queries. The output of the generated query is stored in a temporary file that is read by gnuplot to create a plot. Each plot is stored as a .jpg image created in the current directory."
echo -e "\nPress <Enter> to continue..."
read 
echo -en "\ec"
echo "TABLES:"
printf "\t%s\n" "${tables[@]}"
echo -en "\nEnter a table name from above to select data from > "
read table
# Verify input.
while [ -z "${table// }" ] || [[ -z ${cols[${table,,}]} ]]; do
    echo -en "\ec"
    echo -e "INVALID TABLE NAME: '$table'\n" 
    echo "TABLES:"
    printf "\t%s\n" "${tables[@]}"
    echo -en "\nEnter a table name from above to select data from > "
    read table
done


# Prompt user for the x data column.
echo -en "\ec"
echo "SELECTED TABLE: '$table'"
echo -n "AVAILABLE COLUMNS: "
echo -en "${cols[${table,,}]// /\\n\\t}"
echo -en "\nEnter a column name from above to use as the x variable > "
read xCol
xCol=${xCol// }
# Verify input.
while [ -z $xCol ] || ! grep -iq " ${xCol,,} " <<< "${cols[${table,,}]}"; do
    echo -en "\ec"
    echo -e "INVALID COLUMN NAME: '$xCol'\n"
    echo "SELECTED TABLE: '$table'"
    echo -n "AVAILABLE COLUMNS: "
    echo -en "${cols[${table,,}]// /\\n\\t}"
    echo -en "\nEnter a column name from above to use as the x variable > "
    read xCol
    xCol=${xCol// }
done


# Prompt user for the y data column.
echo -en "\ec"
echo "SELECTED TABLE: '$table'"
echo "SELECTED X COLUMN: '$xCol'"
echo -n "AVAILABLE COLUMNS: "
echo -en "${cols[${table,,}]// /\\n\\t}"
echo -en "\nEnter a column name from above to use as the y variable > "
read yCol
yCol=${yCol// }
# Verify input.
while [ -z $yCol ] || ! grep -iq " ${yCol,,} " <<< "${cols[${table,,}]}"; do
    echo -en "\ec"
    echo -e "INVALID COLUMN NAME: '$yCol'\n"
    echo "SELECTED X COLUMN: '$xCol'"
    echo "SELECTED TABLE: '$table'"
    echo -n "AVAILABLE COLUMNS: "
    echo -en "${cols[${table,,}]// /\\n\\t}"
    echo -en "\nEnter a column name from above to use as the echo -en "\ec"y variable > "
    read yCol
    yCol=${yCol// }
done


# Generate an SQL query.
printf "set linesize 200;\nset pagesize 50000;\nset echo off;\nset heading off;\nset feedback off;\nspool $out_data\nSELECT $xCol, $yCol FROM $table;\nspool off\nexit;" \
       > $out_query


# Run the SQL query on the user's database and store the output in a file.
echo -en "\ec"
sqlplus $USER @$out_query


# Generate any necessary config values to pass to gnuplot.
echo -en "\ec"
echo "SELECTED TABLE: '$table'"
echo "SELECTED X COLUMN: '$xCol'"
echo "SELECTED Y COLUMN: '$yCol'"
echo -e "\nConfiguring..."

# Set x configuration settings if x is a date column.
export xConfigs
if [ "$xCol" == "reporteddate" ]; then
    echo "NOTE: x axis is a date axis"
    xConfigs='set xdata time
set format x "%b %Y"'
fi

# Set y configuration settings if y is a date column.
export yConfigs
if [ "$yCol" == "reporteddate" ]; then
    echo "NOTE: y axis is a date axis"
    yConfigs='set ydata time
set format y "%b %Y"'
fi


# Determine the number to put in the file name for the next plot (i.e. on 
# subsequent plots the files plot0.jpg, plot1.jpg, ... are generated).
max=-1
files="plot*"
regex="^plot([0-9]+).jpg$"
for f in $files; do
    if [[ $f =~ $regex ]]; then
        num=${BASH_REMATCH[1]}
        if [ $num -gt $max ]; then
            max=$num
        fi
    fi
done
((max += 1))
out_plot="plot$max.jpg"


# Use the output of the query to generate a plot uisng gnuplot.
echo -e "\nPlotting..."
gnuplot << EOF
set terminal jpeg
set output "$out_plot"
set timefmt "%d-%b-%y"
set title "$table: $xCol vs $yCol"
$xConfigs
set xtics rotate by 90 right
set xlabel "$xCol"
$yConfigs
set ylabel "$yCol"
plot "$out_data" using 1:2
EOF

# Output the name of the created plot.
echo -e "\nCreated plot: $PWD/$out_plot"

# Delete the temporary files created during the script
echo -e "\nCleaning up..."
rm $out_data $out_query

echo -e "\nDone!"