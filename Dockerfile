FROM python:3.7

RUN apt-get update

### python環境構築
ADD requirements.txt .
RUN pip install -r requirements.txt

### 一般ユーザとしてuser作成
ARG uname

ARG uid
RUN useradd -u $uid -o -m $uname

ARG gid
RUN groupmod -g $gid -o $uname

RUN export HOME=/home/${uname}

USER $uid

### 作業ディレクトリ作成(コンテナ立ち上げ時にマウントするディレクトリ)
RUN mkdir /home/${uname}/work
WORKDIR /home/${uname}/work
