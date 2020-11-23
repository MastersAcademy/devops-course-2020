FROM alpine

COPY app.js /usr/src/app/app.js
WORKDIR /usr/src/app

RUN apk add --update nodejs

ENV PORT=3030
EXPOSE 3030

CMD [ "node", "app.js" ]