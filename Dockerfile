## -*- docker-image-name: "armbuild/scw-app-kolab:latest" -*-
FROM armbuild/scw-distrib-debian:wheezy
MAINTAINER Scaleway <kolja.dummann@logv.ws> (@dumdidum)

# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter

RUN echo "deb http://obs.kolabsys.com/repositories/Kolab:/3.4/Debian_7.0/ ./" > /etc/apt/sources.list.d/kolab.list
RUN echo "deb http://obs.kolabsys.com/repositories/Kolab:/3.4:/Updates/Debian_7.0/ ./" >> /etc/apt/sources.list.d/kolab.list

ADD ./kolab.key /tmp/kolab.key

RUN  apt-key add /tmp/kolab.key

RUN echo "Package: *" > /etc/apt/preferences.d/kolab \
 && echo "Pin: origin obs.kolabsys.com" >> /etc/apt/preferences.d/kolab \
 && echo "Pin-Priority: 501" >> /etc/apt/preferences.d/kolab


# Install packages
RUN apt-get -q update                   \
 && apt-get --force-yes -y -qq upgrade
# RUN  apt-get --force-yes install -y -q   \
# 	apt-utils \
#    kolab



# Clean rootfs from image-builder

RUN /usr/local/sbin/builder-leave
