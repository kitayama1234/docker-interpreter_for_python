### pythonインタープリタとして機能するdocker imageを作成するDockerfile
### sudo権限つき一般ユーザバージョン(不安定)

FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime

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

### 作成したユーザーでログインする
USER $uid

### ホストにマウントする作業ディレクトリ作成
RUN mkdir /home/${uname}/work
WORKDIR /home/${uname}/work
