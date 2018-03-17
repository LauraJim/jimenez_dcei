 
acis2dfpcpn <- function(sdate, edate, states, elem){
  annualmean <- data.frame(NA)
  if(elem==1) element <- "avgt"
  if(elem==2) element <- "pcpn"
for(i in seq_along(states)){  
  base.url <- "http://data.rcc-acis.org/MultiStnData?"
  # Temperature: params=%7B%22state%22%3A%22ks%22%2C%22sdate%22%3A%2219500101%22%2C%22edate%22%3A%2220161231%22%2C%22elems%22%3A%22avgt%22%2C%22meta%22%3A%22ll%2Cname%2Cstate%22%7D
  # Precipitation: params=%7B%22state%22%3A%22ks%22%2C%22sdate%22%3A%2219500101%22%2C%22edate%22%3A%2220161231%22%2C%22elems%22%3A%22pcpn%22%2C%22meta%22%3A%22ll%2Cname%2Cstate%22%7D  params1.url <- "params=%7B%22state%22%3A%22"
  params2.url <- "%22%2C%22sdate%22%3A%22"
  params3.url <- "%22%2C%22edate%22%3A%22"
  params4.url <- "%22%2C%22elems%22%3A%22"
  params5.url <- "%22%2C%22meta%22%3A%22ll%2Cname%2Cstate%22%7D"
  acis.url <- paste0(base.url,params1.url,states[i],params2.url, sdate, params3.url, edate, params4.url,element,params5.url)
  test <- httr::GET(url=acis.url)
  dat <- httr::content(test, "text","application/json", encoding="UTF-8")
  json_data <- jsonlite::fromJSON(dat) # transforms from json to R list
  ifelse(dir.exists("rds"), "dir all ready exists", dir.create("rds"))
  ifelse(dir.exists("data"), "dir all ready exists", dir.create("data"))
  newFN <- paste0("rds/",states[i],"_",sdate,".rds")
  saveRDS(json_data, file=newFN)
  ff <- sapply(json_data$data$data, cbind) #
  ff[ff=="M"] <- NA
  trace <- runif(1000,0.0001,.0099)
  ff[ff=="T"] <- sample(trace,replace = T,size = 1)
  class(ff) <- "numeric"
  dates <- seq.Date(from=lubridate::ymd(sdate), to=lubridate::ymd(edate), by = "1 days")
  year <- as.factor(lubridate::year(dates))
  
  ff <- data.frame(date=dates,ff)
  names(ff) <- c("date",paste(json_data$data$meta$state[],json_data$data$meta$name[], json_data$data$meta$ll[][], sep="_"))
  ff$year <- as.factor(lubridate::year(ff$date))
  # summarize by year
  fc <- aggregate(by=list(ff$year), x=ff[,2:(ncol(ff)-1)], mean)
  names(fc)[1] <- "year"
  fc$year <- as.numeric(as.character(fc$year))
  annualmean <- cbind(annualmean, fc)
  print(states[i])
  print(Sys.time())
  Sys.sleep(2)
  }
  return(annualmean)
}

# Apply function for temperature
res1 <- acis2dfpcpn(sdate="19500101", edate="20161231", states=state.abb, elem=1)
fname1 <- paste0("data/USAannualTemp",sdate,"_", edate,".rds")
saveRDS(res1, file=fname1)

# Apply function for temperature
res2 <- acis2dfpcpn(sdate="19500101", edate="20161231", states=state.abb, elem=2)
fname2 <- paste0("data/USAannualPcpn",sdate,"_", edate,".rds")
saveRDS(res2, file=fname2)

####
lf <- list.files(pattern="20161231$", path="data/", full.names = T)
temp <- data.frame()
for(i in lf[2]){
  tmp <- readRDS(i)
  tmp2 <- reshape2::melt(tmp, id.vars="year")
  temp <- rbind(temp, tmp2)
}
temp <- temp[!temp$variable=="NA.",]
grid <- strsplit(as.character(temp$variable), ",")
latff <- sapply(grid,"[",2)
temp$lat <- as.numeric(gsub(x=latff, replacement = "",pattern=" |)"))
lonff <- sapply(grid,"[",1)
temp$lon <- as.numeric(sub("\\D+","",lonff))*-1
temp$state <- substr(temp$variable,1,2)
library(qdapRegex)
temp$name <- unlist(rm_between(text.var =lonff, left = "_", right="_", extract=TRUE))
                  
saveRDS(temp, "../ModularityHW/USAannualTemp1950_2016.rds")