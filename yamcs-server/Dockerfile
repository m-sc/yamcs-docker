# Container to build deb packages for yamcs

FROM space/java:0.2

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get   update
RUN apt-get install -y alien build-essential maven git subversion libtokyocabinet-dev

# to display simulator X window
RUN apt-get -y install x11-apps libxi6 libgconf-2-4


#install tokyo cabinet
ADD http://fallabs.com/tokyocabinet/javapkg/tokyocabinet-java-1.24.tar.gz /root/
RUN cd /root && \
  tar zxf tokyocabinet-java-1.24.tar.gz && \
  cd tokyocabinet-java-1.24 && \
  ./configure && \
  make && \
  make install && \
  cd - && \
  rm -rf /root/*

RUN apt-get install -y nodejs-legacy
RUN apt-get install -y npm
RUN npm install -g bower
RUN npm install -g gulp
COPY common /
COPY install-yamcs.sh /
RUN /install-yamcs.sh b0d602270fcb7f5fe63326dcdff519bc24768eb3 
EXPOSE 5445 8090


COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
