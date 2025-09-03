FROM ubuntu:24.04

LABEL org.opencontainers.image.source="https://github.com/drunkbatya/binutils-z80-elf"

RUN apt update && apt -y install build-essential git make autoconf automake python3 xxd gettext wget
ARG BINUTILS_VERSION=2.45

RUN mkdir -p /buildroot/src
RUN wget -O /buildroot/src/binutils-${BINUTILS_VERSION}.tar.xz https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.xz
RUN tar -xvf /buildroot/src/binutils-${BINUTILS_VERSION}.tar.xz -C /buildroot/src/

WORKDIR /configureroot
RUN /buildroot/src/binutils-${BINUTILS_VERSION}/configure --target=z80-elf --prefix /outputroot

RUN make -j
RUN make -j install

ENV PATH="/outputroot/bin:$PATH"
