
FROM java:8-alpine

RUN apk add --update curl tar && \
    rm -rf /var/cache/apk/*

ENV HOME_DIR /opt
ENV VERSION 6.2.2

WORKDIR ${HOME_DIR}

RUN curl -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}.tar.gz && \
    tar -xvf elasticsearch-${VERSION}.tar.gz && \
    rm -rf elasticsearch-${VERSION}.tar.gz && \
    ln -s elasticsearch-${VERSION} elasticsearch

RUN ./elasticsearch/bin/plugin install https://download.elastic.co/elasticsearch/release/org/elasticsearch/plugin/cloud-aws/${VERSION}/cloud-aws-${VERSION}.zip

COPY assets/elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml

EXPOSE 9200 9300

VOLUME /opt/elasticsearch/data

ENTRYPOINT ["/opt/elasticsearch/bin/elasticsearch"]

CMD []
