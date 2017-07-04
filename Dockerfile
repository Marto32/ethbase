FROM python:2.7.9

# Update and install dependencies
RUN apt-get update
RUN apt-get install -y \
  git-core \
  build-essential \
  automake \
  pkg-config \
  libtool \
  libffi-dev \
  libgmp-dev \
  python-dev \
  libssl-dev \
  python-pip

RUN pip install --upgrade pip
RUN pip install jupyter

# Install pyrlp
RUN git clone https://github.com/ethereum/pyrlp /apps/pyrlp
WORKDIR /apps/pyrlp
RUN pip install -e .

# Install pydevp2p
RUN git clone https://github.com/ethereum/pydevp2p /apps/pydevp2p
WORKDIR /apps/pydevp2p
RUN pip install -e .

# # Install pyethereum
# RUN git clone https://github.com/ethereum/pyethereum/ /apps/pyethereum
# WORKDIR /apps/pyethereum
# RUN pip install -e .

# Install and setup pyethapp
RUN git clone https://github.com/ethereum/pyethapp /apps/pyethapp
WORKDIR /apps/pyethapp
RUN pip install -Iv ipython==5.4.1
RUN USE_PYETHEREUM_DEVELOP=1 python setup.py develop

# Fix debian's ridiculous gevent-breaking constant removal
# (e.g. https://github.com/hypothesis/h/issues/1704#issuecomment-63893295):
RUN sed -i 's/PROTOCOL_SSLv3/PROTOCOL_SSLv23/g' /usr/local/lib/python2.7/site-packages/gevent/ssl.py

RUN mkdir -p /data/chaindata
RUN mkdir -p /data/keystore
RUN mkdir -p /data/nodes

EXPOSE 8888
EXPOSE 4000
EXPOSE 30303
EXPOSE 30303/udp

VOLUME /data

RUN mkdir /code
WORKDIR /code

# Finalize jupyter notebook setup
# Per http://jupyter-notebook.readthedocs.io/en/latest/public_server.html#docker-cmd
# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--debug"]

