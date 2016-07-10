# Taken from SO or r-bloggers or somewhere for studying

require(polynom)
require(ggplot2)
library(gridExtra)
ncol=2
for (i in 1:(10*ncol)) {eval(parse(text=paste("p",formatC(i, width=3, flag="0"),"=as.function(polynomial(rchisq(n=sample(2:5,1), df=sample(2:5,1))))",sep="")))}
z=as.vector(outer(seq(-5, 5, by =.02),1i*seq(-5, 5, by =.02),'+'))
opt=theme(legend.position="none",
          panel.background = element_blank(),
          panel.margin = unit(0,"null"),
          panel.grid = element_blank(),
          axis.ticks= element_blank(),
          axis.title= element_blank(),
          axis.text = element_blank(),
          strip.text =element_blank(),
          axis.ticks.length = unit(0,"null"),
          axis.ticks.margin = unit(0,"null"),
          plot.margin = rep(unit(0,"null"),4))
for (i in 1:(ncol^2))
{
  pols=sample(1:(10*ncol), 3, replace=FALSE)
  p1=paste("p", formatC(pols[1], width=3, flag="0"), "(x)*", sep="")
  p2=paste("p", formatC(pols[2], width=3, flag="0"), "(x)/", sep="")
  p3=paste("p", formatC(pols[3], width=3, flag="0"), "(x)",  sep="")
  eval(parse(text=paste("p = function (x) ", p1, p2, p3, sep="")))
  df=data.frame(x=Re(z),
                y=Im(z),
                h=(Arg(p(z))<0)*1+Arg(p(z))/(2*pi),
                s=(1+sin(2*pi*log(1+Mod(p(z)))))/2,
                v=(1+cos(2*pi*log(1+Mod(p(z)))))/2)
  g=ggplot(data=df[is.finite(apply(df,1,sum)),], aes(x=x, y=y)) + geom_tile(fill=hsv(df$h,df$s,df$v))+ opt
  assign(paste("hsv_g", formatC(i, width=3, flag="0"), sep=""), g)
}
jpeg(filename = "Surrealism.jpg", width = 800, height = 800, quality = 100)
grid.arrange(hsv_g001, hsv_g002, hsv_g003, hsv_g004, ncol=ncol)
dev.off()
