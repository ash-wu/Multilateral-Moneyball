# Background
# 	Open ports 80 and 9110 on EC2 management console
#		80 allows us to see the websites, 9110 allows us to hit the R server
#	Install R and all of the necessary packages
#		sudo apt-get install r-base r-base-dev
#		sudo apt-get install libcurl4-openssl-dev
#		sudo apt-get install libxml2-dev
#		install.packages(c(...))
#	Install apache2 web server
#		sudo apt-get install apache2
#	Start web server
# 		/etc/init.d/apache2 start
#		sudo mkdir /var/www/html

# Upload un.Rdata to server
scp -i ~/Downloads/moneyball.pem un.Rdata ubuntu@54.69.111.237:
#actually entered
scp -i ~/Downloads/moneyball.pem ~/Desktop/un.Rdata ubuntu@54.69.111.237:~/un_d3

# Upload .tar.gz file to server
scp -i ~/Downloads/moneyball.pem un_d3.tar.gz ubuntu@54.69.111.237:
#actually entered
scp -i ~/Downloads/moneyball.pem ~/Desktop/un_d3.tar.gz ubuntu@54.69.111.237:~/un_d3

# Login to server
ssh -i ~/Downloads/moneyball.pem ubuntu@54.69.111.237

# Untar and enter directory
tar -xzvf un_d3.tar.gz
cd un_d3/

# Opens editor for un_server
nano un_server.R
	# Change the path to the un.Rdata file to the appropriate thing
	# If you just did the scp on line 2, it should be ~/un.Rdata
	# so changed it to ~/Downloads/un.Rdata
	# Hit control+x to save and exist

# Starts a "screen" -- a terminal window that you can "detach"
# from and leave running
screen -S r-server
Rscript un_server.R
# Hit control+a+d to detach from screen
# If you need to re-attach later, type screen -r r-server

# Copy website into /var/www/html folder
# This may cause issues if there are other files in there, make sure
# that you end up having un_d3 folder inside /var/www/html
sudo cp -r ~/un_d3 /var/www/html/
sudo chmod -R 755 /var/www/html/un_d3

# so the url is actually
http://ec2-54-69-111-237.us-west-2.compute.amazonaws.com/un_d3/


