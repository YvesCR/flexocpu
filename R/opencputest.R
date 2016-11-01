#' gethowel
#'
#' Get the details of a patient
#'
#' @export
#'
gethowel <- function(id) {
  # id <- 5
  # howell <- read.table("../Howel1.txt", header = T, sep = ";")
  # save(howell, file= "data/howell.Rdata")

  #  load(file= "D:/websites/YCR/opencputest/data/howell.Rda") # howell
  # howell should in the package opencputest and could be called like that

  data("howell")

  howell$id <- 1:nrow(howell)

  if(id <= nrow(howell)){
    res <- howell[id, ]
    res$height <- round(res$height, digits = 0)
    res$weight <- round(res$weight, digits = 1)
  } else stop("Out of range")

  return(jsonlite::toJSON(res))

}
#' plotind
#'
#' plot the patient over the average
#'
#' @export
#'
plotind <- function(id = 1) {
  # id <- 5
  # howell <- read.table("../Howel1.txt", header = T, sep = ";")
  # save(howell, file= "data/howell.Rdata")

  # http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
  multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
    library(grid)

    # Make a list from the ... arguments and plotlist
    plots <- c(list(...), plotlist)

    numPlots = length(plots)

    # If layout is NULL, then use 'cols' to determine layout
    if (is.null(layout)) {
      # Make the panel
      # ncol: Number of columns of plots
      # nrow: Number of rows needed, calculated from # of cols
      layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                       ncol = cols, nrow = ceiling(numPlots/cols))
    }

    if (numPlots==1) {
      print(plots[[1]])

    } else {
      # Set up the page
      grid.newpage()
      pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

      # Make each plot, in the correct location
      for (i in 1:numPlots) {
        # Get the i,j matrix positions of the regions that contain this subplot
        matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

        print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                        layout.pos.col = matchidx$col))
      }
    }
  }

  data("howell")

  howell$age.band <- cut(howell$age, breaks = c(15, 20, 30, 40))
  howell$id <- 1:nrow(howell)

  if(id <= nrow(howell)){

    plot.gg0 <- ggplot2::ggplot(data = howell, ggplot2::aes(y = height, x = weight)) +
      ggplot2::geom_smooth() +
      ggplot2::geom_point(data = howell[id, ], size = 5)

    plot.gg1 <- ggplot2::ggplot(data = howell, ggplot2::aes(y = weight, x = age)) +
      ggplot2::geom_smooth() +
      ggplot2::geom_point(data = howell[id, ], size = 5)

    plot.gg2 <- ggplot2::ggplot(data = howell, ggplot2::aes(y = height, x = age)) +
      ggplot2::geom_smooth() +
      ggplot2::geom_point(data = howell[id, ], size = 5)

    plot.gg <- multiplot(plot.gg0, plot.gg1, plot.gg2, cols=3)

  } else stop("Out of range")

  return(plot.gg)

}
#' leaflet widget
#'
#'
#' @export
make_map <- function(title = "This is a test"){
  m <- leaflet::leaflet()
  m <- leaflet::addTiles(m)
  m <- leaflet::addMarkers(m, lng = -0.132065, lat = 51.516900, popup = title)
  htmlwidgets::saveWidget(m, "mymap.html", selfcontained = FALSE)
}
