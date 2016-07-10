library(jpeg)
img <- "example.jpg"
#img <- "example.png"
img <- readJPEG(img)
#sub_img <- img[1:10, 1:12]

# computes the ij moment of an image
m <- function(i,j,im) {
  x <- t(apply(im, 1, function(x) x^i))
  y <- apply(im, 2, function(x) x^j)

  return(sum(x*y*im))
}

m2 <- function(p,q,im) {
  im2 <- im

  for (i in 1:nrow(im)) {
    im_x <- im[i, ]^p
    for (j in 1:ncol(im)) {

    }
  }
  return(sum)
}

# sum of grey level (area): M00
# centroid (x, y) = (M10/M00, M01/M00)

centroid <- function(im) {

}
