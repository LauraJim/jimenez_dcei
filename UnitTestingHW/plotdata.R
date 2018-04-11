# DESCRIPTION:
# This function produce a visualization of the background points, the occurrence
# data and the tolerance ranges of the species of interest, in both the geographical
# and the environmental spaces (in a 2-dimensional case).

# ARGUMENTS:
# back --- csv file that contains the climatic background for the species,
#          the first two columns must contain the lon,lat coordinates and
#          the rest of the columns the measurements of the environmental
#          variables to be considered in the analysis
# occ.sp --- csv file with occurrence points, first two columns contain the
#            geographical coordinates and the remaining columns are
#            the environmental combinations
# tolran --- csv file with tolerance limits for each environmental variable,
#            must contain two columns for each variable (first column is the
#            lower limit and second column the upper limit)
# sp.col --- color name to be used for the occurrence points

# OUTPUT:
# A plot with two panels. The panel on the left will show the data in geographical
# space and the panel on the right will show the data in the environmental space.

# NOTES:

# CODE:
plotdata <- function(back,occ.sp,tolran,sp.col)
{
  par(mfrow=c(1,2))
  
  ## Geographical Space:
  # Plot the geographical locations of reported presences of the species, on top of the global environmental variables
  plot(back[,1],back[,2],pch=".",col=1,xlab="Longitude",ylab="Latitude",main="Geographical space")
  points(occ.sp[,1],occ.sp[,2],pch=19,col=sp.col)
  
  ## Environmental Space:
  # Plot environmental variables of species data and the location of reported presences of the species on top
  plot(back[,3],back[,4], pch=".", col=1,xlab="Bio1WHStnd",ylab="Bio12WHStnd",main="Environmental space")
  points(occ.sp[,1],occ.sp[,2], pch=19, col=sp.col)
  rect(xleft=tolran$xleft,xright=tolran$xright,ybottom=tolran$ybottom,ytop=tolran$ytop,border="gold",lwd=2)
  legend("topleft",legend=c("Species presences:",rotule,"Tolerance ranges"),pch=c(19,NA,NA),
         bty="n",lty=c(0,0,1),col=c(sp.col,"white","gold"),lwd=2)
}
