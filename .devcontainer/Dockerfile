FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

# C/C++
RUN apt-get install -y \
    build-essential \
    g++ \
    gcc \
    make \
    cmake \
    git \
    curl \
    wget \
    vim

# OpenJDK 17
RUN apt-get install -y openjdk-17-jdk

# Verilator
RUN apt-get install -y \
    help2man \
    perl \
    python3 \
    autoconf \
    flex \
    bison \
    ccache \
    libgoogle-perftools-dev \
    libjemalloc-dev \
    numactl \
    perl-doc

RUN (apt-get install -y libfl2 || echo "libfl2 not available, skipping") && \
    (apt-get install -y libfl-dev || echo "libfl-dev not available, skipping") && \
    (apt-get install -y zlibc zlib1g zlib1g-dev || echo "zlib packages not available, skipping")

# Gtkwave
RUN apt-get install -y gtkwave

# DTC
RUN apt-get install -y device-tree-compiler

# Others
RUN apt-get install -y \
    pkg-config \
    libtool

RUN rm -rf /var/lib/apt/lists/*

# Install Scala 2.13.18
RUN curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs \
    && chmod +x cs \
    && ./cs install scala:2.13.18 scalac:2.13.18 \
    && rm cs

ENV PATH="/root/.local/share/coursier/bin:${PATH}"

# Install Mill
RUN curl -L https://repo1.maven.org/maven2/com/lihaoyi/mill-dist/1.1.5/mill-dist-1.1.5-mill.sh -o mill \
    && chmod +x mill \
    && mv mill /usr/local/bin/mill

# Install Verilator
RUN git clone https://github.com/verilator/verilator /tmp/verilator \
    && cd /tmp/verilator \
    && git checkout stable \
    && autoconf \
    && ./configure \
    && make -j $(nproc) \
    && make install \
    && rm -rf /tmp/verilator

# Check
RUN scala -version && \
    scalac -version && \
    mill --version && \
    verilator --version && \
    dtc --version && \
    java -version && \
    gcc --version && \
    make --version

# Setup workplace
WORKDIR /workspace

# Keep alive
CMD ["sleep", "infinity"]