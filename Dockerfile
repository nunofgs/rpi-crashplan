FROM resin/rpi-raspbian
MAINTAINER Nuno Sousa <nunofgs@gmail.com>

# Install dependencies.
RUN apt-get update -q
RUN apt-get install -y --no-install-recommends openjdk-8-jre-headless libjna-java curl

# Increase max file watches.
ADD 60-max-user-watches.conf /etc/sysctl.d/60-max-user-watches.conf

# Download CrashPlan.
ADD http://download.code42.com/installs/linux/install/CrashPlan/CrashPlan_3.7.0_Linux.tgz /tmp/CrashPlan.tgz

# Install CrashPlan and replace bundled jre.
RUN cd /tmp && \
    tar xf CrashPlan.tgz && \
    cd CrashPlan-install && \
    sed -i 's/^more /: /g' install.sh && \
    (echo; echo; echo yes; echo ; echo y; echo; echo /data; echo y; echo; echo; echo y; echo) | ./install.sh && \
    rm -r /usr/local/crashplan/jre && \
    ln -s /usr/lib/jvm/java-8-openjdk-armhf /usr/local/crashplan/jre

# Add ARM-compatible libraries.
ADD libjtux.so /usr/local/crashplan/libjtux.so
ADD libmd5.so /usr/local/crashplan/libmd5.so

# Link conf folder.
ADD ./config /config
RUN rm -rf /usr/local/crashplan/conf && \
    ln -s /config /usr/local/crashplan/conf

# Run CrashPlan once.
RUN /usr/local/crashplan/bin/CrashPlanEngine start && sleep 20 \
    && /usr/local/crashplan/bin/CrashPlanEngine stop; sleep 20

# Clean up.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD start.sh /start.sh

VOLUME ["/config"]
VOLUME ["/data"]

EXPOSE 4242
EXPOSE 4243

CMD ["/start.sh"]

