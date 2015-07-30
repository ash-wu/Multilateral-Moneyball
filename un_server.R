options(stringsAsFactors = F)
require(RCurl)
require(RJSONIO)
require(plyr)

require(httpuv)
require(RJSONIO)

# ----------------------------
# Correlation plots -- 2014-10-28

require(jsonlite)
require(reshape)
require(corrplot)
require(plyr); require(foreach)
require(doMC); registerDoMC(cores = detectCores() - 1)


blocList <- list(

  G77 = c("Afghanistan", "Algeria", "Angola", "Antigua and Barbuda", "Argentina", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia", "Botswana", "Brazil", "Brunei", "Burkina Faso", "Burma", "Burundi", "Cambodia", "Cameroon", "Cabo Verde", "Central African Republic", "Chad", "Chile", "China", "Columbia", "Comoros", "Congo (Brazzaville)", "Congo (Kinshasa)", "Costa Rica", "Cote d'Ivoire", "Cuba", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt ", "El Salvador", "Equatorial Guinea", "Eritrea", "Ethiopia", "Fiji", "Gabon", "Gambia", "Ghana", "Grenada", "Guatemala", "Guinea", "Guniea Bissau", "Guyana", "Haiti", "Honduras", "India", "Indonesia", "Iran", "Iraq", "Jamaica", "Jordan", "Kenya", "Kiribati", "Kuwait", "Laos", "Lebanon", "Lesotho", "Liberia", "Libya", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia, Federated States of", "Mongolia", "Morocco", "Mozambique", "Namibia", "Nauru", "Nepal", "Nicaragua", "Niger", "Nigeria", "Oman", "Pakistan", "Panama ", "Papua New Guniea", "Paraguay", "Peru", "Philippines", "Qatar", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Sri Lanka", "Sudan", "Suriname", "Swaziland", "Syria", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkmenistan", "Uganda", "United Arab Emirates", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"),

  LatAmer = c("Antigua and Barbuda", "Argentina", "Bahamas", "Barbados", "Belize", "Bolivia", "Brazil", "Chile", "Columbia", "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "Ecuador", "El Salvador", "Grenada", "Guatemala", "Guyana", "Haiti", "Honduras", "Jamaica", "Mexico", "Nicaragua", "Panama ", "Paraguay", "Peru", "St. Christopher", "St. Lucia", "St. Vincent and the Grenadines", "Suriname", "Trinidad and Tobago", "Uruguay", "Venezuela"),

  EastEuro = c("Albania", "Armenia", "Azerbaijan", "Belarus", "Bosnia", "Bulgaria", "Croatia", "Czech Republic", "Georgia", "Hungary", "Kazakhstan", "Kyrgystan", "Macedonia", "Moldova", "Poland", "Romania", "Russia", "Slovakia", "Slovenia", "Tajikistan", "Turkmenistan", "Ukraine", "Uzbekistan"),

  NonAligned = c("Afghanistan", "Algeria", "Angola", "Argentina", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia", "Botswana", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Cape Verde", "Central African Republic", "Chad", "Columbia", "Comoros", "Congo", "Cote d'Ivoire", "Croatia", "Cuba", "Cyprus", "Djibouti", "Ecuador", "Egypt ", "Equatorial Guinea", "Ethiopia", "Gabon", "Gambia", "Ghana", "Grenada", "Guinea", "Guniea Bissau", "Guyana", "India", "Indonesia", "Iran", "Iraq", "Jamaica", "Jordan", "Kenya", "Kuwait", "Laos", "Lebanon", "Lesotho", "Liberia", "Libya", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Mauritania", "Mauritius", "Morocco", "Mozambique", "Nepal", "Nicaragua", "Nigeria", "Nigeria", "Oman", "Pakistan", "Panama ", "Peru", "Qatar", "Rwanda", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovenia", "Somalia", "South Africa", "Sri Lanka", "St. Christopher", "St. Lucia", "Sudan", "Suriname", "Swaziland", "Syria", "Tanzania", "Togo", "Trinidad and Tobago", "Tunisia", "Uganda", "United Arab Emirates", "Vanuatu", "Vietnam", "Yemen", "Zaire", "Zambia", "Zimbabwe"),

  AU = c("Algeria", "Angola", "Benin", "Botswana", "Burkina Faso", "Burundi", "Cape Verde", "Central African Republic", "Chad", "Congo (Kinshasa)", "Congo (Brazzaville)", "Djibouti", "Egypt", "Equatorial Guinea", "Eritrea", "Ethiopia", "Gabon", "Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Cote d'Ivoire", "Kenya", "Lesotho", "Liberia", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", "Sao Tome and Principe", "Senegal", "Seychelles", "Sierra Leone", "Somalia", "South Africa", "South Sudan", "Sudan", "Swaziland", "Tanzania", "Togo", "Tunisia", "Uganda", "Zambia", "Zimbabwe"),

  Islamic = c("Algeria", "Bahrain", "Bangladesh", "Brunei", "Burkina Faso", "Cameroon", "Chad", "Comoros", "Djibouti", "Egypt ", "Gabon", "Gambia", "Guinea", "Guniea Bissau", "Indonesia", "Iran", "Iraq", "Jordan", "Kuwait", "Lebanon", "Libya", "Malaysia", "Maldives", "Mali", "Mauritania", "Morocco", "Nigeria", "Oman", "Pakistan", "Qatar", "Saudi Arabia", "Senegal", "Sierra Leone", "Somalia", "Sudan", "Syria", "Tunisia", "Turkey", "Uganda", "United Arab Emirates", "Yemen"),

  Arab = c("Algeria", "Bahrain", "Djibouti", "Egypt ", "Iraq", "Jordan", "Kuwait", "Lebanon", "Libya", "Mauritania", "Morocco", "Oman", "Qatar", "Saudi Arabia", "Somalia", "Sudan", "Syria", "Tunisia", "United Arab Emirates", "Yemen"),

  Asian = c("Afghanistan", "Bahrain", "Bangladesh", "Bhutan", "Brunei", "Burma", "Cambodia", "China", "Cyprus", "Fiji", "India", "Indonesia", "Iran", "Iraq", "Japan", "Jordan", "Kuwait", "Laos", "Lebanon", "Malaysia", "Maldives", "Mongolia", "Nepal", "Oman", "Pakistan", "Palau", "Papua New Guniea", "Philippines", "Qatar", "Samoa", "Saudi Arabia", "Singapore", "Solomon Islands", "Sri Lanka", "Syria", "Thailand", "Turkey", "United Arab Emirates", "Vanuatu", "Vietnam", "Yemen"),
  
  ASEAN = c("Brunei", "Burma", "Cambodia", "Indonesia", "Laos", "Malaysia", "Philippines", "Singapore", "Thailand", "Vietnam"),

  Western = c("United States", "Australia", "Austria", "Belgium", "Canada", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Iceland", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands", "New Zealand", "Norway", "Portugal", "Spain", "Sweden", "Turkey", "United Kingdom","United States"),
  
  EU = c("Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Netherlands", "Poland", "Portugal", "Romania", "Slovakia", "Slovenia", "Spain", "Sweden", "United Kingdom"),

  Nordic = c("Denmark", "Estonia", "Finland", "Iceland", "Latvia", "Lithuania", "Norway", "Sweden"),
  
  BRICS = c('Russia','China','India','Brazil','South Africa'),
  
  PowerPlayers = c("Egypt", "Pakistan", "Russia", "China", "Brazil", "Indonesia","Cuba","India","South Africa","United States"),
  
  AUPlus = c("Algeria", "Angola", "Benin", "Botswana", "Burkina Faso", "Burundi", "Cape Verde", "Central African Republic", "Chad", "Congo (Kinshasa)", "Congo (Brazzaville)", "Djibouti", "Egypt", "Equatorial Guinea", "Eritrea", "Ethiopia", "Gabon", "Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Cote d'Ivoire", "Kenya", "Lesotho", "Liberia", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", "Sao Tome and Principe", "Senegal", "Seychelles", "Sierra Leone", "Somalia", "South Africa", "South Sudan", "Sudan", "Swaziland", "Tanzania", "Togo", "Tunisia", "Uganda", "Zambia", "Zimbabwe","China","Brazil","Russia","India","United States")


)



agree_resolution <- function(rid, data, count_abstentions = F) {
	sub <- data[data$resolutionID == rid,]
	if(!count_abstentions) {
		sel <- sub$vote %in% c('yes', 'no')
	}
	tab <- table(sub$country[sel], sub$vote[sel])
	tab[rowSums(tab) == 0,] <- NA
	tab %*% t(tab)
}


make_matrix <- function(ids, data) {

	agg        <- llply(ids, function(id) agree_resolution(id, data), .parallel = T)
	names(agg) <- unlist(ids)
	agree_agg  <- Reduce(function(x, y) {return(x + y)}, lapply(agg, function(x) {x[is.na(x)] <- 0; x}))
	voted_agg  <- Reduce(function(x, y) {return(x + y)}, lapply(agg, function(x) {x <- !is.na(x); x}))
	final      <- agree_agg / voted_agg

	# Say that countries that never have voted together get .5 agreement
	final[is.nan(final)] <- 0.5
	final
}

final_to_json <- function(x) {
	links        <- melt(x)
	print(dim(links))
	names(links) <- c('source', 'target', 'value')
	 links$value  <- links$value
	# ben had this raised to 7
	

	links$source <- factor(links$source, levels = rownames(x))
	links$target <- factor(links$target, levels = rownames(x))

	links$source <- as.numeric(links$source) - 1
	links$target <- as.numeric(links$target) - 1
	json_format <- jsonlite::toJSON( list(data = c(
			list(nodes = data.frame(name = rownames(x), 
									group = 1 + as.numeric(rownames(x) %in% blocList$G77))),
			list(links = links)
		))
	)
	return(json_format)
}

load("~/Desktop/un.Rdata")

sapply(levels(un$issue), function(issue) {
	cat('.')
	tmp <- unique(un$resolutionID[un$issue == issue])
	un[,paste('issue', issue, sep = '_')] <<- un$resolutionID %in% tmp
	return()
});
newUN <- unique(un[,names(un) != 'issue'])

make_json_matrix <- function(params) {
	
	start_date  <- params$start_date
	end_date    <- params$end_date
	time_index  <- newUN$voteDate > start_date & newUN$voteDate < end_date
	
	if(params$issue != 'All') {
		issue_index <- newUN[,params$issue	]
	} else {
		issue_index <- TRUE
	}
	if(params$block_name != 'All') {
		block_index <- newUN$country %in% blocList[[params$block_name]]
	} else {
		block_index <- TRUE
	}

	print('making index')
	index <- issue_index & time_index & block_index
	print(sum(index))
	if(sum(index) > 0) {
		print('getting ids')
		ids   <- as.list(unique(newUN$resolutionID[index]))
		sub         <- newUN[index,]
		sub$country <- as.factor(as.character(sub$country))
		
		print(length(ids))
		print('making matrix...')
		final <- make_matrix(ids, sub)

		# Corrplot
		print('making corrplot...')
		crp <- corrplot(final - 0.5, method = 'square', order = 'hclust', tl.cex = .25,
						hclust.method = 'ward', addgrid.col = rgb(0, 0, 0, 0), 
						outline = F)

		print('returning...')
		final_to_json(crp)
	} else {
		jsonlite::toJSON(
			list(
				"data" = FALSE
			),
			auto_unbox = T
		)
	}
}


restServer <- function(fun_env) {
  function(env){
    method <- env[['REQUEST_METHOD']]
    resp   <- '{"null_response" : undefined}'	
    if(method == 'POST') {	
	  postfields <- rawToChar(env[['rook.input']]$read())
	  postfields <- jsonlite::fromJSON(postfields)
	  print('postfields')
	  print(postfields)
	  if(length(postfields) == 2){
	    fun <- fun_env[[postfields[['fun']]]]
	    if(!is.null(fun)){
	      params <- postfields[['params']]
		  # Convert to JSON iff not JSON
		  print('calling function')
	      resp <- fun(params)
	    } else {
	      print('unsupported function!')
	    }
	  }
	} else {
	  print('unsupported request!')
	}
		
	list(
	  status  = 200L,
        headers = list(
	    'Access-Control-Allow-Origin'='*',
		'Access-Control-Allow-Headers'='accept, accept-charset, accept-encoding, accept-language, authorization, content-length, content-type, host, origin, proxy-connection, referer, user-agent, x-requested-with'
        ),
	  body    = resp
	)
  }  
}


my_env <- new.env()
assign("make_json_matrix", make_json_matrix, env=my_env)
runServer(host='127.0.0.1', port=9110, 
          app = list(call=restServer(my_env)))
