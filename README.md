# Dockerを利用したpythonインタープリタ作成および活用
  
### 準備
- Dockerfile
  * お好みのpythonイメージを指定
- requirements.txt
  * 必要なpythonのモジュールを記述
- entrypoint.sh
  * LOCAL_UIDとLOCAL_GIDをホストのものに変えると良い（権限周りのトラブル回避）
  
### image (インタープリタ) 作成
```
sudo docker build -t my_interpreter .
```
  
### imageでコンテナを立ち上げてbashで接続
```
sudo docker run -it --rm my_interpreter bash
```
  
### imageをインタープリタとして共有ディレクトリ配下スクリプト実行
```
sudo docker run --rm -v ${PWD}/code:/code my_interpreter python script.py
```
  
### jupyter notebook
```
docker run --rm -v ${PWD}/code:/code -p 8888:8888 my_interpreter jupyter notebook --port 8888 --ip=0.0.0.0 --allow-root
```