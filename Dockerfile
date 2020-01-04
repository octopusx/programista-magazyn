FROM alpine:3.11.2

RUN apk add --update nodejs nodejs-npm

COPY . /root
WORKDIR /root
RUN npm i

RUN mkdir /storage
ENV OUTDIR="/storage"

RUN (crontab -l 2>/dev/null; echo "15 4 * * * /root/node_modules/.bin/ts-node /root/prog.ts $OUTDIR 2>&1 | tee -a /storage/log.txt") | crontab -

CMD crond -l 2 -f