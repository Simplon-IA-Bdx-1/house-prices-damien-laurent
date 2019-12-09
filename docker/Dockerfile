FROM jupyter/scipy-notebook
FROM jupyter/r-notebook

USER root
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt
RUN jupyter contrib nbextensions install

RUN jupyter nbextension enable splitcell/splitcell
RUN jupyter nbextension enable hinterland/hinterland
RUN jupyter nbextension enable code_prettify/autopep8
RUN jupyter nbextension enable snippets_menu/main
RUN jupyter nbextension enable toc2/main
RUN jupyter nbextension enable collapsible_headings/main

RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter nbextension enable --py --sys-prefix qgrid
RUN jupyter nbextension enable --py widgetsnbextension

RUN conda install --yes --freeze-installed\
    nomkl \
    'r-lattice=0.20*' \
    'r-cluster=2.0*' \
    'r-dplyr=0.8*' \
    'r-ggplot2=3.1*' \
    'r-tidyr=0.8*' \
    'r-corrplot=0.84*' \
    'r-visreg=2.5*' \
    'r-car=3.0*' \
    'r-factominer=1.42*' \
    'r-factoextra=1.0*' \
    'r-PerformanceAnalytics=1.5*' \
    'r-summarytools=0.9*' \
    'r-randomForest=4.6*' \
    && \
    conda clean -afy
    