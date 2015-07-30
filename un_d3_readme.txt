Use the R_corrplot_and_json_20141107.R script to generate JSON data
Put the JSON data in the same folder as index.html on your computer
	Use my JSON data at first to make sure you're doing the right thing
Double click index.html to open the page in a web browser
You can read through the code in index.html, and play with some settings
	I set it up so it looks reasonably good, I think, but change whatever you want
Ask me questions if you're having trouble getting this off the ground
	It's not particularly complicated, but you have to have all of the
	pieces in the right folders, and may be a little confusing if you
	haven't dealt with websites before.

One note -- 
	You may notice that I raise the data matrix in the
	R script to a power of 7.  This has the effect of 
	compressing the middle of the distribution of co-occurences
	and expanding the tails.  It leads to a better visualization
	because it focuses more of the dynamic range of the colors
	on the part of the distribution where we actually have information.
	Ideally, we'd do this transformation in the D3 code rather than
	in the actual dataset, but I don't know how to do that off the
	top of my head.

# ——————————
# To Start the server (allow block, time range and issue subselection)

Navigate to this folder and run the following command in a Terminal window
Rscript un_server.R

You may have to install some packages to get this to work.  This command won’t return anything — it’s starting a server that will run until you stop it (with control + c). The server waits for requests from the D3 app and calculates the concurrence matrix in real time.  Note that this is a low slower than using precomputed matrices.  On my computer, for the global dataset, the computation takes maybe 30 seconds.  That’s probably too long to have a user wait on a matrix, so maybe ultimately we’d want to do some kind of mix of precomputing and real-time computing (this is almost always what I end up doing).  It works better on some of the smaller datasets.

