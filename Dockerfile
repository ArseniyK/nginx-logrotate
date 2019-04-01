FROM alpine
MAINTAINER Arseniy Krasnov

RUN apk --update add bash logrotate

RUN echo "*/5 * * * * /usr/sbin/logrotate /etc/logrotate.conf" >> /etc/crontabs/root
ADD logrotate.conf /etc/logrotate.conf
ADD upload-log-s3.sh /opt/upload-log-s3.sh
ADD start.sh /opt/start.sh
RUN ln -s /opt/upload-log-s3.sh /usr/bin/upload-log-s3.sh
RUN chmod +x /opt/upload-log-s3.sh
RUN chmod +x /opt/start.sh

RUN apk add --no-cache python py-pip py-setuptools ca-certificates libmagic
RUN pip install python-dateutil python-magic

ARG S3CMD_CURRENT_VERSION=2.0.2
ENV S3CMD_CURRENT_VERSION=$S3CMD_CURRENT_VERSION

RUN mkdir -p /opt \
    && wget https://github.com/s3tools/s3cmd/releases/download/v${S3CMD_CURRENT_VERSION}/s3cmd-${S3CMD_CURRENT_VERSION}.zip \
    && unzip s3cmd-${S3CMD_CURRENT_VERSION}.zip -d /opt/
RUN ln -s /opt/s3cmd-${S3CMD_CURRENT_VERSION}/s3cmd /usr/bin/s3cmd

CMD ["/opt/start.sh"]
