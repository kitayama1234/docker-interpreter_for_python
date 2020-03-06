FROM python:3.7

RUN apt-get update
RUN apt-get install -y sudo

### python環境構築
ADD requirements.txt .
RUN pip install -r requirements.txt

### build時に引数として与えられたuname、uid、gidから一般ユーザー作成
ARG uname
ARG uid
ARG gid

RUN useradd -u $uid -o -m $uname && \
    groupmod -g $gid -o $uname && \
    chpasswd ${uname}:defaultpw

### 作成したユーザーをsudoersに追加し、パスワードを入力しなくてもsudoが使える様にする
RUN echo 'Defaults visiblepw' >> /etc/sudoers
RUN echo "${uname} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN export HOME=/home/${uname}

USER $uid

### 作業ディレクトリ作成(コンテナ立ち上げ時にマウントするディレクトリ)
RUN mkdir /home/${uname}/work
WORKDIR /home/${uname}/work
