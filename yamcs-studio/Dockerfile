# Container to build deb packages for yamcs

FROM space/java:0.2

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
#RUN apt-get upgrade -y

RUN apt-get install -y libgtk2.0-0 libswt-gtk-3-jni libswt-gtk-3-java

COPY common /
COPY install-yamcs-studio.sh /
RUN /install-yamcs-studio.sh


COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
