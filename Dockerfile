FROM ubuntu

RUN --mount=type=cache,target=/var/cache/apt \ 
    apt-get update && DEBIAN_FRONTEND=noninteractive  apt-get install -yq \
    autoconf \
    autoconf-archive \
    automake \
    bc \
    build-essential \
    checkinstall \
    cmake \
    g++ \
    git \
    libcairo2-dev \
    libicu-dev \
    libjpeg-dev \
    libpango1.0-dev \
    libgif-dev \
    libwebp-dev \
    libopenjp2-7-dev \
    libpng-dev \
    libtiff-dev \
    libtool \
    pkg-config \
    python3-dev \
    python3-pip \
    software-properties-common \
    wget \
    xzgv \
    zlib1g-dev 

RUN --mount=type=cache,target=/var/cache/apt add-apt-repository -y ppa:alex-p/tesseract-ocr-devel && \
    apt-get -y update && apt install -y tesseract-ocr

WORKDIR /tesstrain

RUN git clone https://github.com/tesseract-ocr/tesstrain /tesstrain && \
    git checkout 0ce3ae97a2a9c91c1f`2ec9c5c669b258326ca463

RUN wget https://github.com/tesseract-ocr/tessdata_best/raw/main/eng.traineddata -P /tessdata_best

RUN --mount=type=cache,target=/root/.cache pip install -r requirements.txt

RUN make tesseract-langdata

ENV TESSDATA=/tessdata_best
ENV MODEL_NAME=osrs
ENV START_MODEL=eng
ENV MAX_ITERATIONS=10000

CMD ["make", "-e", "training"]