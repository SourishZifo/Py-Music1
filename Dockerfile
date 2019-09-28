FROM alpine:latest
LABEL maintainer="Winding"

# pkg
RUN apk update \
&& apk add --no-cache \
  ca-certificates \
  ffmpeg \
  opus \
  python3 \
  libsodium-dev \
  bash \
  git \
\
# build_pkg
&& apk add --no-cache --virtual .build-deps \
  gcc \
  libffi-dev \
  make \
  musl-dev \
  python3-dev \
\
# ビルドの依存関係をクリーンアップする
&& apk del .build-deps

WORKDIR /usr/src/musicbot
RUN  git clone https://github.com/Winding6636/DiscoMusicBot_py.git /usr/src/musicbot \
&&git checkout modified
# pip依存関係をインストールする
RUN pip3 install --upgrade pip \
&& pip3 install --no-cache-dir -r requirements.txt

ADD config /usr/src/musicbot/config

# 構成をマッピングするためのボリュームを作成します
VOLUME /usr/src/musicbot/config

ENV APP_ENV=docker

ENTRYPOINT ["python3", "dockerentry.py"]
