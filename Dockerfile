FROM jupyter/datascience-notebook

USER root

RUN apt-get install -yq libnetcdf-dev libhdf5-dev libgeos-dev 

RUN ln -s /usr/lib/libgeos-3.4.2.so /usr/lib/libgeos.so

RUN wget -O basemap-1.0.7.tar.gz http://sourceforge.net/projects/matplotlib/files/matplotlib-toolkits/basemap-1.0.7/basemap-1.0.7.tar.gz/download \
        && tar xvf basemap-1.0.7.tar.gz \
        && cd ./basemap-1.0.7 \
        && ./configure \
        && make \
        && make install \
        && /opt/conda/envs/python2/bin/python2 setup.py install

USER jovyan

# Install Python 2 packages
RUN conda install --name python2 \
    'networkx=1.1*' \
    'numpy=1.9*'\
    'pillow=3.0*'\
    'pyproj=1.9*'\
    'pil=1.1*'\
    'netcdf4=1.1*'\
    'graphviz=2.38*'\
    && conda clean -yt

RUN /opt/conda/envs/python2/bin/pip install pyshp

ENV PASSWORD 'spark@surfsara'

USER root

