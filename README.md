# Multilateral-Moneyball
Capstone Project for the Global Affairs major; visualization of UNGA voting records 1988-2014
Created with Feras Alajmi and Ben Johnson 

Use the R_corrplot_and_json_20141107.R script to generate JSON data
Put the JSON data in the same folder as index.html on your computer
	
Double click index.html to open the page in a web browser
You can read through the code in index.html, and play with some settings

One note -- 
	Changing the power the data matrix is raised to in the
	R script matters, it's currently 7.  This has the effect of 
	compressing the middle of the distribution of co-occurences
	and expanding the tails.  It leads to a better visualization
	because it focuses more of the dynamic range of the colors
	on the part of the distribution where we actually have information.


# To Start the server (allow block, time range and issue subselection)

Navigate to this folder and run the following command in a Terminal window
Rscript un_server.R
