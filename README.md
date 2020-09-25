# Dockerを利用したpythonインタープリタ作成および活用
gosu(Dockerコンテナ内で使えるsudoのようなもの)を利用して、ホスト側と同じユーザー名,uid,gidで実行できるPython環境を構築する。
  
### 準備
- Dockerfile
  * お好みのpythonイメージを指定
- requirements.txt
  * 必要なpythonのモジュールを記述
  
### image (インタープリタ) 作成
```
docker build \
-t my_interpreter \
--build-arg uname=${USER} \
--build-arg uid=${UID} \
--build-arg gid=$(id -g) \
-f Dockerfile \
.
```
  
### imageをインタープリタとして共有ディレクトリ配下スクリプト実行
```
docker run --rm -v ${PWD}/work:/home/${USER}/work my_interpreter gosu ${USER} python script.py
```
  
### jupyter notebook (local host)
```
docker run --rm -v ${PWD}/work:/home/${USER}/work -p 8888:8888 my_interpreter gosu ${USER} jupyter notebook --port 8888 --ip=0.0.0.0
```

### Pytorch環境におけるgpu使用テスト
(Dockerfile_gosuにてcuda対応バージョンのpytorchイメージを元イメージとして指定すること)
```
docker run --rm --gpus=all -v ${PWD}/work:/home/${USER}/work my_interpreter gosu ${USER} python -u test_cuda.py
```
