FROM dorowu/ubuntu-desktop-lxde-vnc:bionic

# Install build-essential, wget and nano
RUN apt-get update -y && \
    apt-get install build-essential -y && \
    apt-get install wget nano -y
    
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

# Download Game (to be changed with icaRius Game)
RUN wget http://www.solarus-games.org/downloads/games/zelda-roth-se/zelda-roth-se-1.2.1.solarus 

# Add shorcut to desktop
ADD desktop/solarus-icon.desktop /root/Desktop/solarus-icon.desktop