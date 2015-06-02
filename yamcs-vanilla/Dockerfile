# Container to build deb packages for yamcs

FROM space/java:0.2

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y alien build-essential maven git subversion libtokyocabinet-dev
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

COPY common /
COPY install-yamcs.sh /
RUN /install-yamcs.sh

EXPOSE 5445 8090

COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
