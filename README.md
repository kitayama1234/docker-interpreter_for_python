# Dockerを利用したpythonインタープリタ作成および活用
  
### 準備
- Dockerfile
  * お好みのpythonイメージを指定
- requirements.txt
  * 必要なpythonのモジュールを記述
  
### image (インタープリタ) 作成
```
docker build \
-t py_interpreter \
--build-arg uname=${USER} \
--build-arg uid=${UID} \
--build-arg gid=$(id -g) \
.
```
  
### imageをインタープリタとして共有ディレクトリ配下スクリプト実行
```
docker run --rm -v ${PWD}/code:/home/${USER}/code py_interpreter python script.py
```
  
### jupyter notebook
```
docker run --rm -v ${PWD}/code:/home/${USER}/code -p 8888:8888 py_interpreter jupyter notebook --port 8888 --ip=0.0.0.0 --allow-root
```