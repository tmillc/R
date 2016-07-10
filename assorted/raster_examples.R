library(raster)
x <- raster() # RasterLayer object with default settings
x <- raster(ncol=36, nrow=18, xmn=-1000, xmx=1000, ymn=-100, ymx=900)
res(x)  # [1] 55.55556 55.55556
ncol(x) # 36

res(x) <- 100
res(x)  # [1] 100 100
ncol(x) # 20

ncol(x) <- 18
res(x)  # [1] 111.1111 100.0000

# set the coordinate reference system (CRS) (define the projection)
projection(x) <- "+proj=utm +zone=48 +datum=WGS84"
x

# The objects ’x’ created in the example above only consist of a ’skeleton’,
# that is, we have defined the number of rows and columns, and where the raster
# is located in geographic space, but there are no cell-values associated with it.

r1 <- r2 <- raster(ncol=10, nrow=10)
ncell(r1)  # 100
hasValues(r1)  # false

# set values
values(r1) <- 1:ncell(r1)
set.seed(0)
values(r2) <- runif(ncell(r2))
inMemory(r1)
# inMemory is TRUE if all values are currently in memory (RAM); and FALSE if not
# (in which case they either are on disk, or there are no values).

values(r1)[1:10]
values(r2)[1:10]
plot(r1, main="Raster with 100 cells")
plot(r2)

xmax(r2) <- 0

filename <- system.file("external/test.grd", package="raster")
filename
r3 <- raster(filename)
plot(r3)
hasValues(r3) # TRUE
inMemory(r3)  # FALSE

### Raster stacks

r1 <- r2 <- r3 <- raster(nrow=10, ncol=10)
values(r1) <- runif(ncell(r1))
r1
plot(r1, useRaster = TRUE, interpolate = TRUE, axes = FALSE)  # smoooooth
plot(r1, axes = FALSE, add=TRUE, col = terrain.colors(20,alpha = 0.3))  # smoooooth
density(r1, plot=TRUE)
