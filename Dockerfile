FROM rocker/shiny-verse:4.4.0

# common geospatial dependencies
# https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/install_geospatial.sh
RUN /rocker_scripts/install_geospatial.sh

# install geodata from github because it has been removed (temporarily?) from CRAN
# "Archived on 2024-05-27"
# https://cran.r-project.org/web/packages/geodata/index.html
RUN installGithub.r --deps TRUE \
    rspatial/geodata \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# install more dependencies not available on cran
RUN R -q -e "BiocManager::install(c('graph', 'Rgraphviz'))"

# standard INLA installation is timing out so use github installation https://stackoverflow.com/a/66626028
# RUN R -q -e 'install.packages("INLA",repos=c(getOption("repos"),INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)'
RUN R -q -e 'remotes::install_github(repo = "https://github.com/hrue/r-inla", ref = "stable", subdir = "rinla", build = FALSE)'

# RUN installGithub.r --deps TRUE \
#     wu-thomas/SurveyPrevRShiny \
#     && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
RUN mkdir /SurveyPrevRShiny
COPY * /SurveyPrevRShiny
RUN R -q -e 'remotes::install_local("SurveyPrevRShiny")'

# CMD ["bash"]
CMD R -e 'SurveyPrevRShiny::run_app()'
