FROM ubuntu

# Add the application resources URL
RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main universe" >> /etc/apt/sources.list

# Update the sources list
RUN apt-get update

# Install basic applications
RUN apt-get install -y tar git curl nano wget dialog net-tools build-essential

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute python-pip

# Install nodejs
RUN apt-get install -y nodejs
RUN sudo ln -s `which nodejs` /usr/bin/node

# Install npm
RUN apt-get install -y npm

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Bundle app source
COPY . /usr/src/app

#install osrm-frontend
RUN npm install
RUN make

EXPOSE 8000
CMD python -m SimpleHTTPServer
