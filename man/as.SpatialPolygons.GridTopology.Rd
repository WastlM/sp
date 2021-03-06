\name{as.SpatialPolygons.GridTopology}
\alias{as.SpatialPolygons.GridTopology}
\alias{coerce,GridTopology,SpatialPolygons-method}
\alias{HexPoints2SpatialPolygons}
\alias{IDvaluesGridTopology}
\alias{as.SpatialPolygons.SpatialPixels}
\alias{coerce,SpatialPixels,SpatialPolygons-method}
\alias{IDvaluesSpatialPixels}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Make SpatialPolygons object from GridTopology object}
\description{
  Converts grids of regular rectangles into a \code{SpatialPolygons} object, which can be transformed to a different projection or datum with \code{spTransform} in package \code{rgdal}. The function is not suitable for high-resolution grids. The ordering of the grid cells is as in \code{coordinates()} of the same object, and is reported by \code{IDvaluesGridTopology}.
}
\usage{
as.SpatialPolygons.GridTopology(grd, proj4string = CRS(as.character(NA)))
IDvaluesGridTopology(obj)
as.SpatialPolygons.SpatialPixels(obj)
IDvaluesSpatialPixels(obj)
HexPoints2SpatialPolygons(hex, dx)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{grd}{\code{GridTopology} object}
  \item{proj4string}{object of class \link{CRS-class}}
  \item{obj}{ \code{SpatialPixels} object }
  \item{hex}{ \code{SpatialPoints} object with points that are generated by hexagonal sampling; 
  see \link{spsample}}
  \item{dx}{ spacing of two horizontally adjacent points; if missing, this will be computed
  from the points }
}

\value{
  \code{as.SpatialPolygons.GridTopology} and \code{as.SpatialPolygons.SpatialPixels} return a \code{SpatialPolygons} object;
\code{IDvaluesGridTopology} and \code{IDvaluesSpatialPixels} return a character vector with the object grid indices.
}

\seealso{\code{\link{GridTopology}}, \code{\link{SpatialPixels}}, \code{\link{SpatialPolygons}}
\code{spTransform} in package \code{rgdal}
}


\examples{
library(lattice)
grd <- GridTopology(cellcentre.offset=c(-175,55), cellsize=c(10,10), cells.dim=c(4,4))
SpP_grd <- as.SpatialPolygons.GridTopology(grd)
plot(SpP_grd)
text(coordinates(SpP_grd), sapply(slot(SpP_grd, "polygons"), function(i) slot(i, "ID")), cex=0.5)
trdata <- data.frame(A=rep(c(1,2,3,4), 4), B=rep(c(1,2,3,4), each=4),
 row.names=sapply(slot(SpP_grd, "polygons"), function(i) slot(i, "ID")))
SpPDF <- SpatialPolygonsDataFrame(SpP_grd, trdata)
spplot(SpPDF)

data(meuse.grid)
gridded(meuse.grid)=~x+y
xx = spsample(meuse.grid,  type="hexagonal", cellsize=200)
xxpl = HexPoints2SpatialPolygons(xx)
image(meuse.grid["dist"])
plot(xxpl, add = TRUE)
points(xx, cex = .5)
\dontrun{
spplot(aggregate(as(meuse.grid[,1:3], "SpatialPolygonsDataFrame"), xxpl,
 areaWeighted=TRUE), main = "aggregated meuse.grid")
}
}
\keyword{spatial}
