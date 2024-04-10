





relevance_chart = function(filename, maintitle, subtitle, xlabel, curXlabel, curX, ylabel, curYlabel, yMinLabel, yMin, yMaxLabel, yMax, rlabel) {


  png(file=filename, width=6, height=6, units="in", res=300)
  par(mar = c(5.1, 4.1, 4.1, 5.5) )


  xlab <- bquote(bold(.(xlabel)))
  ylab <- bquote(bold(.(ylabel)))
  rlab = bquote(paste(bolditalic(.(rlabel))))
  yMinlab = expression(bold(yMinLabel))
  yMaxlab = expression(bold(yMinLabel))


  rd = yMax - yMin
  curY <- yMin + rd * curX
  df <- data.frame(b = c(0,1), a = c(yMin,yMax))


  plot(
    a ~ b, 
    df, 
    type='l', 
    col=9, 
    xaxs='i', 
    yaxs='i', 
    ylim=c(0,1),
    xlim=c(0,1), 
    xlab=xlab, 
    ylab=ylab, 
    family="serif", 
    main=maintitle, 
    sub=subtitle)

  # Dotted line with label "P(A)"
  segments(curX, curY, 1, curY, lty=3, col=4)
  mtext(bquote(bold(.(curYlabel))), 4, at=curY, col=4, line=0.3, family="serif")

  # Dotted line with label "P(B)"
  segments(curX, curY, curX, 0, lty=3, col=4)
  mtext(bquote(bold(.(curXlabel))), 1, at=curX, col=4, line=0.3, family="serif")

  # Dotted line with label "P(A|B)"
  segments(0, yMax, 1, yMax, lty=3, col="darkgreen")
  mtext(yMaxLabel, 4, at=yMax, col="darkgreen", line=0.3, family="serif")


  # Dotted line with label "P(A|B̅)"
  segments(0, yMin, 1, yMin, lty=3, col="darkred")

  mtext(yMinLabel, 4, at=yMin, col="darkred", line=0.3, family="serif")


  segments(1.06, yMax, 1.08, yMax, xpd=TRUE)
  segments(1.06, yMin, 1.08, yMin, xpd=TRUE)
  segments(1.07, yMin, 1.07, yMax, lty=3, xpd=TRUE)

  mtext(rlab, 4, at=(yMin + rd/2), line=2, family="serif", las=1)


  dev.off()
  # save("output.png")

}








relevance_chart(
  filename="./relevance-as-slope.png",
  maintitle = "Chart 1",
  subtitle="Relevance as Slope",

  xlabel = "P'(B)",
  curXlabel = "P(B)",
  curX <- 0.68,

  ylabel = "P'(A)",
  curYlabel = "P(A)",


  yMinLabel = expression(bold(paste("P(A|",bar("B"),")"))),
  yMax = 0.8,

  yMaxLabel = expression(bold("P(A|B)")),
  yMin = 0.4,

  rlabel = "R(A, B)"
)



