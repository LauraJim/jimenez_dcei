# DESCRIPTION:
# This function produce a visualization of the background points, the occurrence
# data and the tolerance ranges of the species of interest, in both the geographical
# and the environmental spaces (in a 2-dimensional case).

# ARGUMENTS:
# 
# OUTPUT:

# NOTES:

# CODE:
plotdata <- function(back,occ.sp,tol.ran,sp.col,...)
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
