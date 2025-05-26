FROM python:3

RUN apt-get update && apt-get install -y \
    git cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential \
    g++ libstdc++-arm-none-eabi-newlib

WORKDIR /builder
RUN git clone --recurse-submodules https://github.com/raspberrypi/pico-sdk.git --branch master
ENV PICO_SDK_PATH="/builder/pico-sdk"

WORKDIR /builder/src
COPY . .
WORKDIR /builder/src/dist
RUN cmake .. -DPICO_BOARD=pico_w && make -j4

