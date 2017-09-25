FROM ubuntu

# Basics, needed for all the packages to be installed
RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion apt-utils
RUN apt-get install -y zlib1g-dev cmake tmux htop cmake golang libjpeg-dev libpng12-dev libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libgtk-3-dev libatlas-base-dev gfortran libgtk2.0-dev
RUN apt-get install -y python3=3.5.1*
RUN apt-get install -y python3-pip

ENV DEBIAN_FRONTEND noninteractive

# Utils
RUN apt-get install -y vim
RUN apt-get install -y lsof

# TODO requirements.txt
RUN pip3 install --upgrade pip

# Versioned packages
RUN pip3 install numpy==1.13.1
RUN pip3 install scipy==0.19.1
RUN pip3 install gym==0.7.4
RUN pip3 install six==1.11.0
RUN pip3 install tensorflow==1.3.0
RUN pip3 install opencv-python==3.3.0.10
RUN pip3 install pygame==1.9.3
# Unversioned packages -> imports dont have __version__
RUN pip3 install "gym[atari]"
RUN pip3 install universe
RUN pip3 install go_vncdriver



# TODO Replace by copy
RUN git clone https://github.com/eloaf/universe-starter-agent.git
#RUN mkdir /universe-starter-agent

# PLE : Dont forget to update branch version if you update the PLE fork!
RUN git clone https://github.com/eloaf/PyGame-Learning-Environment.git --branch v1.1
RUN cd PyGame-Learning-Environment; pip3 install  -e .; cd ..

# gym-ple adapter # This typically wont change
RUN git clone https://github.com/lusob/gym-ple.git
RUN cd gym-ple/; pip3 install -e .; cd ..

# /docker-entrypoint-startup.d

RUN echo 'python3 train.py --num-workers 2 --env-id WaterWorld-v0 --log-dir /tmp/pong' > /universe-starter-agent/run_water.sh
RUN chmod a+rwx /universe-starter-agent/run_water.sh

WORKDIR /universe-starter-agent
# RUN /bin/bash
# RUN source activate universe-starter-agent
