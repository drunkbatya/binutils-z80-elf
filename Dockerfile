FROM ubuntu:24.04

RUN apt update && apt -y install build-essential git make autoconf automake python3 xxd gettext
ARG BINUTILS_VERSION=2.45

ADD https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.xz /buildroot/src/
RUN tar -xvf /buildroot/src/binutils-${BINUTILS_VERSION}.tar.xz -C /buildroot/src/
WORKDIR /configureroot
RUN /buildroot/src/binutils-${BINUTILS_VERSION}/configure --target=z80-elf --prefix /outputroot
