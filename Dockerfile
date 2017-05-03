FROM ubuntu:14.04

# Install dependencies
RUN apt-get -q update && \
    apt-get install libfontconfig libcurl3 && \
    apt-get clean

# Enable the CGI MOD
RUN a2enmod cgi && \
	sed -i 's/\#Include conf-available\/serve-cgi-bin.conf/Include conf-available\/serve-cgi-bin.conf/' /etc/apache2/sites-available/000-default.conf

# Config Apache Log
RUN sed -i  's/^export APACHE_LOG_DIR=[^\n]*$/export APACHE_LOG_DIR=\/var\/lib\/behmeh\/apache_logs/' /etc/apache2/envvars

#FIXME: what if bitbucket is not accessible?
ADD https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 /data/phantomjs.tar.bz2

# Setup PhantomJS
RUN cd /data/ && \
    tar -xvf phantomjs.tar.bz2

# TODO: ENV PHANTOM_EXECUTABLE /data/phantomjs-2.1.1-linux-x86_64/bin/phantomjs
# TODO: export PHANTOM_EXECUTABLE=/data/phantomjs-2.1.1-linux-x86_64/bin/phantomjs
# ENV TERM xterm

COPY src/behmeh.js /data/behmeh.js
COPY src/behmeh.sh /usr/lib/cgi-bin/behmeh.cgi
COPY src/apache_start.sh /apache_start.sh
COPY config/behmehhtpasswd /etc/apache2/.behmehhtpasswd
COPY config/serve-cgi-bin.conf /etc/apache2/conf-available/serve-cgi-bin.conf

EXPOSE 80

RUN chmod u+x /apache_start.sh
CMD [ "/apache_start.sh" ]