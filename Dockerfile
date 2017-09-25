FROM ubuntu

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion apt-utils
RUN apt-get install -y zlib1g-dev cmake tmux htop cmake golang libjpeg-dev libpng12-dev libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libgtk-3-dev libatlas-base-dev gfortran libgtk2.0-dev
RUN apt-get install -y python3=3.5.1*
RUN apt-get install -y python3-pip

#ENV PATH /opt/conda/bin:$PATH

#ENV DEBIAN_FRONTEND noninteractive

RUN pip3 install --upgrade pip
RUN pip3 install numpy scipy
RUN pip3 install gym==0.7.4 "gym[atari]" universe six tensorflow go_vncdriver opencv-python 
RUN pip3 install pygame

# TODO Replace by copy
RUN git clone https://github.com/eloaf/universe-starter-agent.git

RUN apt-get install -y vim
RUN apt-get install -y lsof

RUN git clone https://github.com/eloaf/PyGame-Learning-Environment.git
RUN cd PyGame-Learning-Environment; pip3 install  -e .; cd ..

RUN git clone https://github.com/lusob/gym-ple.git
RUN cd gym-ple/; pip3 install -e .; cd ..

# /docker-entrypoint-startup.d

RUN echo 'python3 train.py --num-workers 2 --env-id WaterWorld-v0 --log-dir /tmp/pong' > /universe-starter-agent/run_water.sh
RUN chmod a+rwx /universe-starter-agent/run_water.sh

WORKDIR /universe-starter-agent
RUN /bin/bash
# RUN source activate universe-starter-agent
