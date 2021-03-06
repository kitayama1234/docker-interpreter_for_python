### pythonインタープリタとして機能するdocker imageを作成するDockerfile

FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime

### gosuやopencv関連パッケージなどのインストール
RUN apt-get update && \
    apt-get install -y gosu && \
    apt-get install -y tzdata && \
    apt-get install -y libgl1-mesa-dev && \
    apt-get install -y libopencv-dev

### python環境構築
ADD requirements.txt .
RUN pip install -r requirements.txt

### build時に引数として与えられたuname、uid、gidから一般ユーザー作成、gosu権限付与
ARG uname
ENV USER_NAME=$uname
ARG uid
ARG gid

RUN useradd -u $uid -o -m $uname && \
    groupmod -g $gid -o $uname && \
    chpasswd ${uname}:defaultpw

### homeディレクトリの設定
RUN export HOME=/home/${uname}

### ホストにマウントする作業ディレクトリ作成
RUN mkdir /home/${uname}/work
WORKDIR /home/${uname}/work

