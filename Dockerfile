FROM ubuntu


RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.3.14-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

RUN apt-get install -y zlib1g-dev cmake
RUN apt-get install -y tmux htop cmake golang libjpeg-dev libpng12-dev
RUN apt-get install -y libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
RUN apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
RUN apt-get install -y libxvidcore-dev libx264-dev
RUN apt-get install -y libgtk-3-dev
RUN apt-get install -y libatlas-base-dev gfortran
RUN apt-get install -y libgtk2.0-dev

ENV PATH /opt/conda/bin:$PATH

RUN conda create --name universe-starter-agent python=3.5
RUN echo "source activate universe-starter-agent" >> ~/.bashrc
RUN /bin/bash -c "source activate universe-starter-agent"
RUN /opt/conda/envs/universe-starter-agent/bin/pip install numpy
RUN /opt/conda/envs/universe-starter-agent/bin/pip install scipy
RUN /opt/conda/envs/universe-starter-agent/bin/pip install "gym[atari]"
RUN /opt/conda/envs/universe-starter-agent/bin/pip install universe
RUN /opt/conda/envs/universe-starter-agent/bin/pip install six
RUN /opt/conda/envs/universe-starter-agent/bin/pip install tensorflow
RUN /opt/conda/envs/universe-starter-agent/bin/pip install go_vncdriver
RUN /opt/conda/envs/universe-starter-agent/bin/pip install opencv-python
#RUN conda install -n universe-starter-agent -y -c http://conda.binstar.org/menpo opencv3

RUN git clone https://github.com/openai/universe-starter-agent.git

RUN /opt/conda/envs/universe-starter-agent/bin/pip install pygame

RUN git clone https://github.com/ntasfi/PyGame-Learning-Environment.git
RUN cd PyGame-Learning-Environment; /opt/conda/envs/universe-starter-agent/bin/pip install -e .; cd ..

RUN git clone https://github.com/lusob/gym-ple.git
RUN cd gym-ple/; /opt/conda/envs/universe-starter-agent/bin/pip install -e .; cd ..

RUN /bin/bash
# RUN source activate universe-starter-agent
