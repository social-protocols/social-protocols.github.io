

three_point_relevance_chart = function(filename, maintitle, subtitle, xlabel, x0label, x0, x1label, x1, x2label, x2, ylabel, y0label, y1label, y2label, yMin, yMax, r1label) {


  png(file=filename, width=6, height=6, units="in", res=300)
  par(mar = c(5.1, 4.1, 4.1, 5.5) )


  xlab <- bquote(bold(.(xlabel)))
  ylab <- bquote(bold(.(ylabel)))

  r1lab = bquote(paste(bolditalic(.(r1label))))
  # r2lab = bquote(paste(bolditalic(.(r2label))))
  # yMinlab = expression(bold(yMinLabel))
  # yMaxlab = expression(bold(yMinLabel))


  rd = yMax - yMin
  y0 <- yMin + rd * x0
  y1 <- yMin + rd * x1
  y2 <- yMin + rd * x2
  df <- data.frame(b = c(0,1), a = c(yMin,yMax))


  plot(
    a ~ b, 
    df, 
    type='l', 
    col=9, 
    xaxs='i', 
    yaxs='i',
    xaxt='n',
    yaxt='n',

    ylim=c(0,1),
    xlim=c(0,1), 
    xlab=xlab, 
    ylab=ylab, 
    family="serif", 
    main=maintitle, 
    sub=subtitle)

  # Dotted line with label y0
  segments(x0, y0, 1, y0, lty=3, col=4)
  mtext(bquote(bold(.(y0label))), 4, at=y0, col=4, line=0.3, family="serif")

  # Dotted line with label x0
  segments(x0, y0, x0, 0, lty=3, col=4)
  mtext(bquote(bold(.(x0label))), 1, at=x0, col=4, line=0.3, family="serif")


  # Dotted line with label y1
  segments(x1, y1, 1, y1, lty=3, col=5)
  mtext(bquote(bold(.(y1label))), 4, at=y1, col=5, line=0.3, family="serif")

  # Dotted line with label x1
  segments(x1, y1, x1, 0, lty=3, col=5)
  mtext(bquote(bold(.(x1label))), 1, at=x1, col=5, line=0.3, family="serif")


  # Dotted line with label y2
  segments(x2, y2, 1, y2, lty=3, col=6)
  mtext(bquote(bold(.(y2label))), 4, at=y2, col=6, line=0.3, family="serif")

  # Dotted line with label x2
  segments(x2, y2, x2, 0, lty=3, col=6)
  mtext(bquote(bold(.(x2label))), 1, at=x2, col=6, line=0.3, family="serif")




  # Dotted line with label "P(A|B)"
  # segments(0, yMax, 1, yMax, lty=3, col="darkgreen")
  # mtext(yMaxLabel, 4, at=yMax, col="darkgreen", line=0.3, family="serif")


  # Dotted line with label "P(A|B̅)"
  # segments(0, yMin, 1, yMin, lty=3, col="darkred")

  # mtext(yMinLabel, 4, at=yMin, col="darkred", line=0.3, family="serif")

  # Relevance delta (y1 minus y0)
  segments(1.06, yMax, 1.08, yMax, xpd=TRUE)
  segments(1.06, yMin, 1.08, yMin, xpd=TRUE)
  segments(1.07, yMin, 1.07, yMax, lty=3, xpd=TRUE) # vertical
  mtext(r1lab, 4, at=(yMin + (yMax - yMin)/2), line=2, family="serif", las=1)

  # segments(1.06, yMax, 1.08, yMax, xpd=TRUE)
  # segments(1.06, yMin, 1.08, yMin, xpd=TRUE)
  # segments(1.07, yMin, 1.07, yMax, lty=3, xpd=TRUE)




  # mtext(r2lab, 4, at=(yMin + rd/2), line=2, family="serif", las=1)


  dev.off()
}


three_point_relevance_chart(
  filename="./A-vs-Y.png",
  maintitle = "A vs Y",
  subtitle="Effect of belief Y on upvotes A",

  xlabel = "y",
  ylabel = "A",

  x0label = "y0",
  x0 = 0.1,
  y0label = "a0",


  x1label = "y1",
  x1 = 0.48,
  y1label = "a1",


  x2label = "y2",
  x2 = 0.9,
  y2label = "a2",


  yMax = 0.75,
  yMin = 0,

  r1label = "q"
  # r2label = "A2"
)



three_point_relevance_chart(
  filename="./B-vs-Z.png",
  maintitle = "B vs Z",
  subtitle="Effect of belief Z on upvotes B",

  xlabel = "Z",
  ylabel = "B",

  x0label = "z0",
  x0 = 0.2,
  y0label = "b0",


  x1label = "z1",
  x1 = 0.48,
  y1label = "b1",


  x2label = "z2",
  x2 = 0.85,
  y2label = "b2",


  yMax = 0.8,
  yMin = 0,

  r1label = "r"
  # r2label = "b2"
)



three_point_relevance_chart(
  filename="./Y-vs-Z.png",
  maintitle = "Y vs Z",
  subtitle="Effect of belief Z on belief Y",

  xlabel = "Z",
  ylabel = "Y",

  x0label = "z0",
  x0 = 0.2,
  y0label = "y0",


  x1label = "z1",
  x1 = 0.48,
  y1label = "y1",


  x2label = "z2",
  x2 = 0.85,
  y2label = "y2",


  yMax = 0.8,
  yMin = .4,

  r1label = "λr"
  # r2label = "B2"
)


