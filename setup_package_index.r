
# install.packages("jsonlite")

# check location:
getwd() # should be your project location

## index build process:
rmarkdown::render(input="index.Rmd", output_file="inst/www/index.html")

## Package build process:
opencpu::opencpu$stop()
devtools::build()
devtools::install()
opencpu::opencpu$start(port = 3000)

# Point browser to individual 1: (shift+click to open)
browseURL("http://localhost:3000/ocpu/library/opencputest/www/index.html")


## alternative version: building the package and not stopping the server:
# one time only: start server:
 # opencpu::opencpu$start(port = 3000)
rmarkdown::render(input="index.Rmd", output_file="inst/www/index.html")
devtools::build()
devtools::install()
browseURL("http://localhost:3000/ocpu/library/opencputest/www/index.html")
