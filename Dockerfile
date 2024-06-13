# Based on Blockstream's esplora project

FROM node:18-alpine AS base


RUN mkdir -p /srv/faucet

COPY ./html /srv/faucet/html
COPY ./built /srv/faucet/app
COPY ./node_modules /srv/faucet/node_modules

WORKDIR /srv/faucet/app


ENV FAUCET_NAME="Signet Faucet"

EXPOSE 8123

CMD ["node","index.js"]
