FROM nimbix/centos-base:7
MAINTAINER Nimbix, Inc.

ADD https://github.com/nimbix/image-common/archive/master.zip /tmp/nimbix.zip
WORKDIR /tmp
RUN unzip nimbix.zip && rm -f nimbix.zip

# Nimbix desktop (does a yum clean all)
RUN mkdir -p /usr/local/lib/nimbix_desktop && for i in help-real.html help-tiger.html install-centos-real.sh install-centos-tiger.sh nimbix_desktop postinstall-tiger.sh url.txt xfce4-session-logout share skel.config; do cp -a /tmp/image-common-master/nimbix_desktop/$i /usr/local/lib/nimbix_desktop; done && cp /tmp/image-common-master/nimbix_desktop/nimbix_desktop.service /etc/systemd/system/nimbix_desktop.service && rm -rf /tmp/image-common-master
RUN yum -y install which && /usr/local/lib/nimbix_desktop/install-centos-tiger.sh && yum clean all && ln -s /usr/local/lib/nimbix_desktop /usr/lib/JARVICE/tools/nimbix_desktop && systemctl enable nimbix_desktop && dbus-uuidgen >/etc/machine-id

# recreate nimbix user home to get the right skeleton files
RUN /bin/rm -rf /home/nimbix && /sbin/mkhomedir_helper nimbix

# for standalone use
EXPOSE 5901
EXPOSE 443
