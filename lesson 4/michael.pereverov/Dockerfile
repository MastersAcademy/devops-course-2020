FROM node:15.2.0-alpine3.12

ENV WORKDIR=/usr/src/app

ENV PORT=8000

WORKDIR $WORKDIR

COPY . $WORKDIR

EXPOSE $PORT

CMD ["node", "app.js"]

