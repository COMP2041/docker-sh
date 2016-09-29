FROM debian:jessie   
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_AU.UTF-8  
RUN echo "deb http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu trusty main" >/etc/apt/sources.list.d/fkrull-deadsnakes-trusty.list &&\
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DB82666C &&\
	apt-get update &&\
	apt-get install -y --no-install-recommends \
		python python3.5 python-requests python3-requests python-beautifulsoup python-bs4 python3-bs4 python-lxml python3-lxml \
		perl rsync wget curl xz-utils id3 time unzip locales vim ssh imagemagick git net-tools bind9-host &&\
	localedef -i en_AU -c -f UTF-8 -A /usr/share/locale/locale.alias en_AU.UTF-8 &&\
    dpkg-reconfigure -f noninteractive tzdata &&\
    rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/bin/*3.5 /usr/local/bin &&\
	adduser --disabled-password --gecos '' --home  /home/cs2041 cs2041 &&\
	mkdir -p /home/cs2041/public_html/scripts /web /home/cs2041/bin &&\
	ln -s  /home/cs2041/public_html /web/cs2041 &&\
	ln -sf /home/cs2041/public_html/scripts/autotest /home/cs2041/bin &&\
	ln -sf  give_remote /home/cs2041/public_html/scripts/give &&\
	chmod -R 755 /web /home &&\
	chown -R cs2041.cs2041 /web /home &&\
	wget --quiet -O- http://www.cse.unsw.edu.au/~cs2041/cgi/distributed_files.cgi | \
	tar -C /home/cs2041/public_html --owner=cs2041 -xJf -

ENV PATH $PATH:/home/cs2041/public_html/scripts
ADD /entrypoint entrypoint
ENTRYPOINT ["/entrypoint"]
