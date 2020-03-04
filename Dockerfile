FROM python:3.7

RUN apt-get update && apt-get -y install gosu
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN mkdir /code
WORKDIR /code

ADD requirements.txt /code/
RUN pip install -r requirements.txt

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
