FROM python:3.12.0a4-bullseye
LABEL maintainer="madiele92@gmail.com"

ENV streamlinkCommit=15fbab1b45e8bbe432b385c088cea2acfb8812f1
ENV PATH "${HOME}/.local/bin:${PATH}"

RUN apt-get update \
    && apt-get install -y gosu python3-pip ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade git+https://github.com/streamlink/streamlink.git@${streamlinkCommit}

RUN echo 'export PATH="${HOME}/.local/bin:${PATH}"'

RUN mkdir /home/download
RUN mkdir /home/script
RUN mkdir /home/plugins

COPY ./streamlink-recorder.sh /home/script/
COPY ./entrypoint.sh /home/script

RUN ["chmod", "+x", "/home/script/entrypoint.sh"]
RUN useradd -u 1000 stream_usr

ENTRYPOINT [ "/home/script/entrypoint.sh" ]

CMD /bin/sh ./home/script/streamlink-recorder.sh ${streamOptions} ${streamLink} ${streamQuality} ${streamName}
