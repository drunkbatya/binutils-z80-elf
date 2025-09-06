FROM ubuntu:24.04 AS builder

LABEL org.opencontainers.image.source="https://github.com/drunkbatya/binutils-z80-elf"

RUN apt update && apt -y install build-essential git make autoconf automake wget
ARG BINUTILS_VERSION=2.45

RUN mkdir -p /buildroot/src
RUN wget -O /buildroot/src/binutils-${BINUTILS_VERSION}.tar.xz https://ftpmirror.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.xz
RUN tar -xvf /buildroot/src/binutils-${BINUTILS_VERSION}.tar.xz -C /buildroot/src/

WORKDIR /configureroot
RUN /buildroot/src/binutils-${BINUTILS_VERSION}/configure --target=z80-elf --prefix /outputroot

RUN make -j
RUN make -j install

FROM ubuntu:24.04 AS output
RUN apt update && apt -y install git make python3 xxd gettext
COPY --from=builder /outputroot /outputroot
RUN echo -e "[safe]\n\tdirectory = *" > /root/.gitconfig

ENV PATH="/outputroot/bin:$PATH"
