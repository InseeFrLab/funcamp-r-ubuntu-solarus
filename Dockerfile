FROM dorowu/ubuntu-desktop-lxde-vnc:bionic

# Install build-essential, wget and nano
RUN apt-get update -y && \
    apt-get install build-essential -y && \
    apt-get install wget nano zip -y
    
# Install related libraries and cmake
RUN apt-get install -y libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev libluajit-5.1-dev libphysfs-dev libopenal-dev libmodplug-dev libvorbis-dev qtbase5-dev qttools5-dev qttools5-dev-tools libglm-dev && \
    apt-get install cmake -y

# Download Solarus Game Engine binaries
Run curl -O https://gitlab.com/solarus-games/solarus/-/archive/release-1.6.3/solarus-release-1.6.3.tar.gz && \
    tar -zxvf /root/solarus-release-1.6.3.tar.gz && \
    mkdir /root/solarus-release-1.6.3/build

# Compile and install Solarus Game Engine 
WORKDIR /root/solarus-release-1.6.3/build 

RUN cmake .. && \
    make && \
    make install

WORKDIR /root/

RUN /sbin/ldconfig -v

# Download icaRius Game source code
RUN wget https://git.lab.sspcloud.fr/funcamp-r/funcamp-r-icarius/-/archive/master/funcamp-r-icarius-master.zip

# Repackage icaRius Game in a solarus archive
RUN unzip /root/funcamp-r-icarius-master.zip && \
    cd /root/funcamp-r-icarius-master/data && \
    zip -r icarius.solarus ./*

# Clean data
RUN mv /root/funcamp-r-icarius-master/data/icarius.solarus /root/icarius.solarus && \
    rm -r /root/funcamp-r-icarius-master/ /root/funcamp-r-icarius-master.zip && \
    rm -r /root/solarus-release-1.6.3/ /root/solarus-release-1.6.3.tar.gz

# Add shorcut to desktop
ADD desktop/retro_game.png /usr/share/icons/LoginIcons/apps/64/retro_game.png
ADD desktop/solarus-icon.desktop /root/Desktop/solarus-icon.desktop