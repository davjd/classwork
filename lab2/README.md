Each file contains the solution for each question.

q1.py: Reads from a CSV file. We read from public data to find out how many projects each borough has. We read from the csv file located in this directoy.

q2.cpp: We convert from farenheit to celsius with 7 static data points.

q3.sh: We do a CURL request to the NASA datapoint. We store the API key inside a txt file. Therefore, create the file and store your API key inside there.


To run each program:

q1.py: python3 q1.py, the output should be lines with each borough and number of projects.

q2.cpp: clang++ -std=c++11 q2.cpp -o q
        
        ./q

The output should be numbers with their conversion.

q3.sh: First change permissions for the file (shown inside the comments). Then run it: ./q3.sh

The output should be a json string with the api data.
