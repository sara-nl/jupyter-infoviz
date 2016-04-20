FROM jupyter/datascience-notebook

USER root

RUN apt-get update && \
    apt-get install -yq libnetcdf-dev libhdf5-dev libgeos-dev libgdal-dev

RUN ln -s /usr/lib/libgeos-3.4.2.so /usr/lib/libgeos.so

USER jovyan

# Install Python 2 packages
RUN conda install --name python2 \
    'networkx=1.1*'\
    'pandas-datareader=0.2*'\
    'pillow=3.0*'\
    'pyproj=1.9*'\
    'pil=1.1*'\
    'netcdf4=1.1*'\
    'graphviz=2.38*'\
    'basemap=1.0*'\
    && conda clean -yt

RUN /opt/conda/envs/python2/bin/pip install pyshp fiona xlrd folium shapely cesiumpy

ENV PASSWORD 'infovis@surf'

USER root

