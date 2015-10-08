FROM debian:jessie

RUN echo "deb http://ftp.br.debian.org/debian testing main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.br.debian.org/debian testing main contrib non-free" >> /etc/apt/sources.list

RUN apt-get -y update
RUN apt-get -y build-dep lighttpd
RUN apt-get install -y gcc vim curl

RUN cd /home

RUN curl https://codeload.github.com/lighttpd/lighttpd1.4/tar.gz/lighttpd-1.4.34 | tar xvz

RUN cd lighttpd1.4-lighttpd-1.4.34 && \
  ./autogen.sh && \
  ./configure && \
  make

CMD ["bash"]
