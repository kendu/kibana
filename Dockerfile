################################################################################
#                                                                              #
#                                 {o,o}                                        #
#                                 |)__)                                        #
#                                 -"-"-                                        #
#                                                                              #
################################################################################

# The Kibana docker image

FROM debian
MAINTAINER Kendu <devops@kendu.si>
ENV DEBIAN_FRONTEND noninteractive
ENV KIBANA_VERSION 4.0.2

#We need wget to get kibana
RUN apt-get update && \
    apt-get upgrade --yes --force-yes && \
    apt-get install --yes --force-yes wget ca-certificates

#Get kibana
RUN wget "https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz" && \
    tar -xvf "kibana-${KIBANA_VERSION}-linux-x64.tar.gz" && \
    mv "kibana-${KIBANA_VERSION}-linux-x64" /opt/kibana && \
    rm "kibana-${KIBANA_VERSION}-linux-x64.tar.gz"

#Clean up to minimize image
RUN apt-get remove wget ca-certificates --yes --force-yes && \
    apt-get clean

WORKDIR /opt/kibana

USER nobody

EXPOSE 5601

ENTRYPOINT /opt/kibana/bin/kibana
