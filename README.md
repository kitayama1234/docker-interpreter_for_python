# Dockerを利用したpythonインタープリタ作成および活用
  
### 準備するもの
* requirements.txt
* Dockerfileなど
  
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
